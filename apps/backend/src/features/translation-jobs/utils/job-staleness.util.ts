/**
 * Pure utility for translation job staleness detection and retry policy decisions.
 *
 * All functions are side-effect-free and accept explicit timestamps so they can
 * be tested deterministically without fake timers.
 */

export interface JobRetryMeta {
  attemptCount: number;
  lastAttemptStartedAt?: string; // ISO-8601
  lastAttemptFailedAt?: string; // ISO-8601
  lastFailureReasonCode?: string;
  recoveredFromStall?: boolean;
}

/** Safely parses retry metadata from an untyped JSON field. */
export function parseJobRetryMeta(jobMeta: unknown): JobRetryMeta {
  if (!jobMeta || typeof jobMeta !== 'object' || Array.isArray(jobMeta)) {
    return { attemptCount: 0 };
  }

  const m = jobMeta as Record<string, unknown>;

  return {
    attemptCount: typeof m.attemptCount === 'number' ? m.attemptCount : 0,
    lastAttemptStartedAt:
      typeof m.lastAttemptStartedAt === 'string'
        ? m.lastAttemptStartedAt
        : undefined,
    lastAttemptFailedAt:
      typeof m.lastAttemptFailedAt === 'string'
        ? m.lastAttemptFailedAt
        : undefined,
    lastFailureReasonCode:
      typeof m.lastFailureReasonCode === 'string'
        ? m.lastFailureReasonCode
        : undefined,
    recoveredFromStall:
      typeof m.recoveredFromStall === 'boolean'
        ? m.recoveredFromStall
        : undefined,
  };
}

/**
 * Returns true when a translating job has had no DB activity for longer than
 * the configured stale threshold.
 *
 * Uses `updatedAt` as the activity proxy — every markProgress() call updates
 * that column, making it a reliable heartbeat.
 */
export function isJobStalled(
  updatedAt: Date,
  now: number,
  staleAfterMs: number,
): boolean {
  return now - updatedAt.getTime() >= staleAfterMs;
}

/** Returns true when the job still has remaining attempts under the policy. */
export function canRetryAfterStall(
  meta: JobRetryMeta,
  maxAttempts: number,
): boolean {
  return meta.attemptCount < maxAttempts;
}

/** Increments the attempt counter when the runner claims the job. */
export function applyAttemptStarted(
  meta: JobRetryMeta,
  now: Date,
): JobRetryMeta {
  return {
    ...meta,
    attemptCount: meta.attemptCount + 1,
    lastAttemptStartedAt: now.toISOString(),
  };
}

/** Records failure metadata without changing attemptCount. */
export function applyAttemptFailed(
  meta: JobRetryMeta,
  reasonCode: string,
  now: Date,
): JobRetryMeta {
  return {
    ...meta,
    lastAttemptFailedAt: now.toISOString(),
    lastFailureReasonCode: reasonCode,
  };
}

/** Marks that the job was recovered from a stall on this attempt. */
export function applyRecoveredFromStall(meta: JobRetryMeta): JobRetryMeta {
  return { ...meta, recoveredFromStall: true };
}
