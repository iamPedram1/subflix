import {
  applyAttemptFailed,
  applyAttemptStarted,
  applyRecoveredFromStall,
  canRetryAfterStall,
  isJobStalled,
  JobRetryMeta,
  parseJobRetryMeta,
} from 'features/translation-jobs/utils/job-staleness.util';

const T0 = new Date('2024-01-01T00:00:00.000Z');
const STALE_AFTER_MS = 5 * 60_000; // 5 minutes

describe('parseJobRetryMeta', () => {
  it('returns zero-count meta for null', () => {
    expect(parseJobRetryMeta(null)).toEqual({ attemptCount: 0 });
  });

  it('returns zero-count meta for undefined', () => {
    expect(parseJobRetryMeta(undefined)).toEqual({ attemptCount: 0 });
  });

  it('returns zero-count meta for an array', () => {
    expect(parseJobRetryMeta([])).toEqual({ attemptCount: 0 });
  });

  it('returns zero-count meta for a non-object primitive', () => {
    expect(parseJobRetryMeta('string')).toEqual({ attemptCount: 0 });
  });

  it('parses a full meta object correctly', () => {
    const raw = {
      attemptCount: 2,
      lastAttemptStartedAt: '2024-01-01T00:00:00.000Z',
      lastAttemptFailedAt: '2024-01-01T00:01:00.000Z',
      lastFailureReasonCode: 'execution_error',
      recoveredFromStall: true,
    };
    expect(parseJobRetryMeta(raw)).toEqual(raw);
  });

  it('defaults attemptCount to 0 when missing', () => {
    expect(parseJobRetryMeta({ lastFailureReasonCode: 'foo' })).toMatchObject({
      attemptCount: 0,
    });
  });

  it('ignores fields with wrong types', () => {
    const raw = {
      attemptCount: 'not-a-number',
      recoveredFromStall: 'yes',
    };
    expect(parseJobRetryMeta(raw)).toEqual({ attemptCount: 0 });
  });
});

describe('isJobStalled', () => {
  it('returns false when updatedAt is recent', () => {
    const updatedAt = new Date(T0.getTime() + STALE_AFTER_MS - 1);
    const now = T0.getTime() + STALE_AFTER_MS;
    expect(isJobStalled(updatedAt, now, STALE_AFTER_MS)).toBe(false);
  });

  it('returns true exactly at the stale threshold', () => {
    const updatedAt = T0;
    const now = T0.getTime() + STALE_AFTER_MS;
    expect(isJobStalled(updatedAt, now, STALE_AFTER_MS)).toBe(true);
  });

  it('returns true when updatedAt is older than the threshold', () => {
    const updatedAt = T0;
    const now = T0.getTime() + STALE_AFTER_MS + 1;
    expect(isJobStalled(updatedAt, now, STALE_AFTER_MS)).toBe(true);
  });
});

describe('canRetryAfterStall', () => {
  it('returns true when attemptCount is below maxAttempts', () => {
    const meta: JobRetryMeta = { attemptCount: 2 };
    expect(canRetryAfterStall(meta, 3)).toBe(true);
  });

  it('returns false when attemptCount equals maxAttempts', () => {
    const meta: JobRetryMeta = { attemptCount: 3 };
    expect(canRetryAfterStall(meta, 3)).toBe(false);
  });

  it('returns false when attemptCount exceeds maxAttempts', () => {
    const meta: JobRetryMeta = { attemptCount: 5 };
    expect(canRetryAfterStall(meta, 3)).toBe(false);
  });
});

describe('applyAttemptStarted', () => {
  it('increments attemptCount and sets lastAttemptStartedAt', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    const result = applyAttemptStarted(meta, T0);
    expect(result.attemptCount).toBe(2);
    expect(result.lastAttemptStartedAt).toBe(T0.toISOString());
  });

  it('preserves existing fields', () => {
    const meta: JobRetryMeta = {
      attemptCount: 0,
      lastFailureReasonCode: 'execution_error',
      recoveredFromStall: true,
    };
    const result = applyAttemptStarted(meta, T0);
    expect(result.lastFailureReasonCode).toBe('execution_error');
    expect(result.recoveredFromStall).toBe(true);
  });

  it('does not mutate the input', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    applyAttemptStarted(meta, T0);
    expect(meta.attemptCount).toBe(1);
  });
});

describe('applyAttemptFailed', () => {
  it('sets lastAttemptFailedAt and lastFailureReasonCode', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    const result = applyAttemptFailed(meta, 'execution_error', T0);
    expect(result.lastAttemptFailedAt).toBe(T0.toISOString());
    expect(result.lastFailureReasonCode).toBe('execution_error');
  });

  it('does not change attemptCount', () => {
    const meta: JobRetryMeta = { attemptCount: 2 };
    const result = applyAttemptFailed(meta, 'stall_recovery_exhausted', T0);
    expect(result.attemptCount).toBe(2);
  });

  it('does not mutate the input', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    applyAttemptFailed(meta, 'execution_error', T0);
    expect(meta.lastAttemptFailedAt).toBeUndefined();
  });
});

describe('applyRecoveredFromStall', () => {
  it('sets recoveredFromStall to true', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    expect(applyRecoveredFromStall(meta).recoveredFromStall).toBe(true);
  });

  it('preserves all other fields', () => {
    const meta: JobRetryMeta = {
      attemptCount: 2,
      lastFailureReasonCode: 'execution_error',
    };
    const result = applyRecoveredFromStall(meta);
    expect(result.attemptCount).toBe(2);
    expect(result.lastFailureReasonCode).toBe('execution_error');
  });

  it('does not mutate the input', () => {
    const meta: JobRetryMeta = { attemptCount: 1 };
    applyRecoveredFromStall(meta);
    expect(meta.recoveredFromStall).toBeUndefined();
  });
});
