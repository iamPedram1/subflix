import { canReuseTargetLanguageSubtitle } from 'features/translation-jobs/utils/subtitle-acquisition-policy.util';

describe('canReuseTargetLanguageSubtitle', () => {
  it('allows reuse for medium/high confidence with no disallowed warnings', () => {
    const result = canReuseTargetLanguageSubtitle({
      confidenceScore: 65,
      confidenceLevel: 'medium',
      warnings: ['low_cue_count'],
      shouldBlockAutoUse: false,
      signals: {},
    });

    expect(result.allowed).toBe(true);
  });

  it('rejects reuse when quality gate blocks auto use', () => {
    const result = canReuseTargetLanguageSubtitle({
      confidenceScore: 5,
      confidenceLevel: 'low',
      warnings: ['invalid_timing_ranges'],
      shouldBlockAutoUse: true,
      signals: {},
    });

    expect(result.allowed).toBe(false);
    expect(result.reason).toBe('blocked_by_quality_gate');
  });

  it('rejects reuse when confidence is low', () => {
    const result = canReuseTargetLanguageSubtitle({
      confidenceScore: 40,
      confidenceLevel: 'low',
      warnings: [],
      shouldBlockAutoUse: false,
      signals: {},
    });

    expect(result.allowed).toBe(false);
    expect(result.reason).toBe('low_confidence');
  });

  it('rejects reuse when a release mismatch is present', () => {
    const result = canReuseTargetLanguageSubtitle({
      confidenceScore: 80,
      confidenceLevel: 'high',
      warnings: ['release_mismatch'],
      shouldBlockAutoUse: false,
      signals: {},
    });

    expect(result.allowed).toBe(false);
    expect(result.reason).toBe('release_mismatch');
  });
});
