import { TranslationSourceType } from '@prisma/client';

import { parseJobRetryMeta } from 'features/translation-jobs/utils/job-staleness.util';

/**
 * Numeric dispatch priority tiers. Lower values are dispatched first.
 *
 * Tier semantics:
 *   CATALOG   — Fresh catalog jobs. These may complete without AI translation
 *               (e.g. target-language subtitle reuse or cached translation),
 *               making them the highest-value candidates to run early.
 *   UPLOAD    — Fresh upload jobs. These always require AI translation but
 *               skip catalog overhead (no subtitle download or quality eval).
 *   RECOVERED — Jobs recovered from a stall. Deprioritized to avoid consuming
 *               concurrency slots at the expense of fresh jobs, but promoted
 *               back to their base tier once they age past the configured
 *               fairness threshold to prevent indefinite starvation.
 */
export const DispatchPriority = {
  CATALOG: 10,
  UPLOAD: 20,
  RECOVERED: 30,
} as const;

export type DispatchPriority =
  (typeof DispatchPriority)[keyof typeof DispatchPriority];

/** Fields required to compute dispatch priority for a queued job. */
export type PrioritizableJob = {
  id: string;
  sourceType: TranslationSourceType;
  createdAt: Date;
  jobMeta: unknown;
};

/** A job record extended with its computed dispatch priority. */
export type PrioritizedJob = PrioritizableJob & {
  priority: DispatchPriority;
};

/**
 * Computes the scheduling priority for a single queued job.
 *
 * Rules (in evaluation order):
 * 1. If the job was recovered from a stall AND its age is below the fairness
 *    threshold, it is placed in the RECOVERED tier (lowest priority).
 * 2. Once a recovered job exceeds the fairness threshold it is promoted back
 *    to its base tier to prevent indefinite starvation.
 * 3. Fresh catalog jobs receive CATALOG priority — they may complete instantly
 *    via target-language subtitle reuse or cached translation.
 * 4. Fresh upload jobs receive UPLOAD priority — they require AI translation
 *    but skip the catalog acquisition pipeline entirely.
 *
 * @param job                  The queued job record.
 * @param now                  Current timestamp (injected for deterministic testing).
 * @param fairnessThresholdMs  Age after which recovered jobs are promoted to
 *                             their base tier.
 */
export function computeDispatchPriority(
  job: PrioritizableJob,
  now: Date,
  fairnessThresholdMs: number,
): DispatchPriority {
  const meta = parseJobRetryMeta(job.jobMeta);
  const ageMs = now.getTime() - job.createdAt.getTime();

  if (meta.recoveredFromStall && ageMs < fairnessThresholdMs) {
    return DispatchPriority.RECOVERED;
  }

  return job.sourceType === TranslationSourceType.catalog
    ? DispatchPriority.CATALOG
    : DispatchPriority.UPLOAD;
}

/**
 * Picks the top `limit` jobs from `candidates` in priority order.
 *
 * Sorting rules:
 * - Primary: priority ascending (lower value = dispatched first).
 * - Secondary: createdAt ascending (oldest-first FIFO within the same tier).
 *
 * This is a pure function: it does not read config or touch the DB.
 *
 * @param candidates          Queued job records to rank.
 * @param limit               Maximum number of jobs to return.
 * @param now                 Current timestamp for priority computation.
 * @param fairnessThresholdMs Passed through to computeDispatchPriority.
 */
export function pickDispatchCandidates(
  candidates: PrioritizableJob[],
  limit: number,
  now: Date,
  fairnessThresholdMs: number,
): PrioritizedJob[] {
  const scored: PrioritizedJob[] = candidates.map((job) => ({
    ...job,
    priority: computeDispatchPriority(job, now, fairnessThresholdMs),
  }));

  scored.sort((a, b) => {
    if (a.priority !== b.priority) return a.priority - b.priority;
    return a.createdAt.getTime() - b.createdAt.getTime();
  });

  return scored.slice(0, limit);
}
