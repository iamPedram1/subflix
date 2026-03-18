import { TranslationSourceType } from '@prisma/client';
import { describe, expect, it } from 'vitest';

import {
  DispatchPriority,
  PrioritizableJob,
  computeDispatchPriority,
  pickDispatchCandidates,
} from 'features/translation-jobs/utils/translation-job-priority.util';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const FAIRNESS_MS = 5 * 60_000; // 5 minutes

const NOW = new Date('2026-01-01T12:00:00.000Z');

const makeJob = (
  overrides: Partial<PrioritizableJob> & { id?: string } = {},
): PrioritizableJob => ({
  id: overrides.id ?? 'job-1',
  sourceType: overrides.sourceType ?? TranslationSourceType.upload,
  createdAt: overrides.createdAt ?? new Date('2026-01-01T11:00:00.000Z'),
  jobMeta: overrides.jobMeta ?? null,
});

const freshCatalog = (
  id: string,
  createdAt = new Date('2026-01-01T11:00:00.000Z'),
): PrioritizableJob =>
  makeJob({ id, sourceType: TranslationSourceType.catalog, createdAt });

const freshUpload = (
  id: string,
  createdAt = new Date('2026-01-01T11:00:00.000Z'),
): PrioritizableJob =>
  makeJob({ id, sourceType: TranslationSourceType.upload, createdAt });

const recoveredJob = (
  id: string,
  sourceType: TranslationSourceType,
  createdAt = new Date('2026-01-01T11:00:00.000Z'),
): PrioritizableJob =>
  makeJob({
    id,
    sourceType,
    createdAt,
    jobMeta: { attemptCount: 1, recoveredFromStall: true },
  });

// ---------------------------------------------------------------------------
// Priority tier constants
// ---------------------------------------------------------------------------

describe('DispatchPriority constants', () => {
  it('CATALOG has a lower numeric value than UPLOAD (dispatched first)', () => {
    expect(DispatchPriority.CATALOG).toBeLessThan(DispatchPriority.UPLOAD);
  });

  it('UPLOAD has a lower numeric value than RECOVERED (dispatched first)', () => {
    expect(DispatchPriority.UPLOAD).toBeLessThan(DispatchPriority.RECOVERED);
  });
});

// ---------------------------------------------------------------------------
// computeDispatchPriority
// ---------------------------------------------------------------------------

describe('computeDispatchPriority', () => {
  it('returns CATALOG for a fresh catalog job', () => {
    const job = freshCatalog('job-1');
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.CATALOG,
    );
  });

  it('returns UPLOAD for a fresh upload job', () => {
    const job = freshUpload('job-1');
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.UPLOAD,
    );
  });

  it('returns RECOVERED for a recently-recovered catalog job', () => {
    const job = recoveredJob(
      'job-1',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:58:00.000Z'), // 2 minutes old — under threshold
    );
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.RECOVERED,
    );
  });

  it('returns RECOVERED for a recently-recovered upload job', () => {
    const job = recoveredJob(
      'job-1',
      TranslationSourceType.upload,
      new Date('2026-01-01T11:58:00.000Z'),
    );
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.RECOVERED,
    );
  });

  it('promotes a recovered catalog job to CATALOG once past the fairness threshold', () => {
    // Job was created 6 minutes ago — exceeds 5-minute fairness threshold
    const job = recoveredJob(
      'job-1',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:54:00.000Z'),
    );
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.CATALOG,
    );
  });

  it('promotes a recovered upload job to UPLOAD once past the fairness threshold', () => {
    const job = recoveredJob(
      'job-1',
      TranslationSourceType.upload,
      new Date('2026-01-01T11:54:00.000Z'),
    );
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.UPLOAD,
    );
  });

  it('treats a job with null jobMeta as non-recovered', () => {
    const job = makeJob({
      sourceType: TranslationSourceType.catalog,
      jobMeta: null,
    });
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.CATALOG,
    );
  });

  it('treats a job with empty jobMeta object as non-recovered', () => {
    const job = makeJob({
      sourceType: TranslationSourceType.upload,
      jobMeta: {},
    });
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.UPLOAD,
    );
  });

  it('exact fairness threshold boundary: job at exactly the threshold age is promoted', () => {
    const createdAt = new Date(NOW.getTime() - FAIRNESS_MS);
    const job = recoveredJob('job-1', TranslationSourceType.catalog, createdAt);
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.CATALOG,
    );
  });

  it('one millisecond below threshold: job stays RECOVERED', () => {
    const createdAt = new Date(NOW.getTime() - FAIRNESS_MS + 1);
    const job = recoveredJob('job-1', TranslationSourceType.catalog, createdAt);
    expect(computeDispatchPriority(job, NOW, FAIRNESS_MS)).toBe(
      DispatchPriority.RECOVERED,
    );
  });
});

// ---------------------------------------------------------------------------
// pickDispatchCandidates
// ---------------------------------------------------------------------------

describe('pickDispatchCandidates', () => {
  it('returns an empty array when given no candidates', () => {
    const result = pickDispatchCandidates([], 3, NOW, FAIRNESS_MS);
    expect(result).toEqual([]);
  });

  it('catalog jobs are selected before upload jobs', () => {
    const candidates = [freshUpload('upload-1'), freshCatalog('catalog-1')];
    const result = pickDispatchCandidates(candidates, 2, NOW, FAIRNESS_MS);
    expect(result[0].id).toBe('catalog-1');
    expect(result[1].id).toBe('upload-1');
  });

  it('FIFO ordering within the same tier: older createdAt dispatched first', () => {
    const older = freshCatalog('catalog-old', new Date('2026-01-01T10:00:00.000Z'));
    const newer = freshCatalog('catalog-new', new Date('2026-01-01T11:00:00.000Z'));
    const result = pickDispatchCandidates(
      [newer, older],
      2,
      NOW,
      FAIRNESS_MS,
    );
    expect(result[0].id).toBe('catalog-old');
    expect(result[1].id).toBe('catalog-new');
  });

  it('FIFO within upload tier', () => {
    const older = freshUpload('upload-old', new Date('2026-01-01T10:00:00.000Z'));
    const newer = freshUpload('upload-new', new Date('2026-01-01T11:00:00.000Z'));
    const result = pickDispatchCandidates(
      [newer, older],
      2,
      NOW,
      FAIRNESS_MS,
    );
    expect(result[0].id).toBe('upload-old');
    expect(result[1].id).toBe('upload-new');
  });

  it('fresh jobs are selected before recovered jobs', () => {
    const recovered = recoveredJob(
      'recovered-1',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:58:00.000Z'), // under fairness threshold
    );
    const fresh = freshCatalog('fresh-1', new Date('2026-01-01T11:59:00.000Z'));
    const result = pickDispatchCandidates(
      [recovered, fresh],
      2,
      NOW,
      FAIRNESS_MS,
    );
    expect(result[0].id).toBe('fresh-1');
    expect(result[1].id).toBe('recovered-1');
  });

  it('recovered-but-aged job is promoted and selected before a non-aged recovered job', () => {
    const agedRecovered = recoveredJob(
      'recovered-aged',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:54:00.000Z'), // 6 min old — promoted to CATALOG
    );
    const freshRecovered = recoveredJob(
      'recovered-fresh',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:59:00.000Z'), // 1 min old — stays RECOVERED
    );
    const result = pickDispatchCandidates(
      [freshRecovered, agedRecovered],
      2,
      NOW,
      FAIRNESS_MS,
    );
    // agedRecovered is promoted to CATALOG (10) while freshRecovered stays RECOVERED (30)
    expect(result[0].id).toBe('recovered-aged');
    expect(result[1].id).toBe('recovered-fresh');
  });

  it('respects the limit — returns at most limit items', () => {
    const candidates = [
      freshCatalog('c1'),
      freshCatalog('c2'),
      freshCatalog('c3'),
      freshUpload('u1'),
      freshUpload('u2'),
    ];
    const result = pickDispatchCandidates(candidates, 2, NOW, FAIRNESS_MS);
    expect(result).toHaveLength(2);
  });

  it('returns all when candidates are fewer than limit', () => {
    const candidates = [freshCatalog('c1'), freshUpload('u1')];
    const result = pickDispatchCandidates(candidates, 10, NOW, FAIRNESS_MS);
    expect(result).toHaveLength(2);
  });

  it('attaches the computed priority to each returned job', () => {
    const candidates = [freshCatalog('c1'), freshUpload('u1')];
    const result = pickDispatchCandidates(candidates, 2, NOW, FAIRNESS_MS);
    expect(result.find((j) => j.id === 'c1')?.priority).toBe(
      DispatchPriority.CATALOG,
    );
    expect(result.find((j) => j.id === 'u1')?.priority).toBe(
      DispatchPriority.UPLOAD,
    );
  });

  it('is deterministic — same input always produces same output', () => {
    const candidates = [
      freshUpload('u1', new Date('2026-01-01T10:00:00.000Z')),
      freshCatalog('c1', new Date('2026-01-01T11:00:00.000Z')),
      freshCatalog('c2', new Date('2026-01-01T09:00:00.000Z')),
      recoveredJob(
        'r1',
        TranslationSourceType.upload,
        new Date('2026-01-01T11:58:00.000Z'),
      ),
    ];
    const first = pickDispatchCandidates(candidates, 4, NOW, FAIRNESS_MS);
    const second = pickDispatchCandidates(candidates, 4, NOW, FAIRNESS_MS);
    expect(first.map((j) => j.id)).toEqual(second.map((j) => j.id));
  });

  it('full ordering: catalog FIFO → upload FIFO → recovered', () => {
    const c1 = freshCatalog('c1', new Date('2026-01-01T09:00:00.000Z'));
    const c2 = freshCatalog('c2', new Date('2026-01-01T10:00:00.000Z'));
    const u1 = freshUpload('u1', new Date('2026-01-01T09:30:00.000Z'));
    const u2 = freshUpload('u2', new Date('2026-01-01T10:30:00.000Z'));
    const r1 = recoveredJob(
      'r1',
      TranslationSourceType.catalog,
      new Date('2026-01-01T11:58:00.000Z'), // under threshold — stays RECOVERED
    );
    const result = pickDispatchCandidates(
      [u2, r1, c2, u1, c1],
      5,
      NOW,
      FAIRNESS_MS,
    );
    expect(result.map((j) => j.id)).toEqual(['c1', 'c2', 'u1', 'u2', 'r1']);
  });
});
