import { describe, expect, it } from 'vitest';

import { checkTranslationReuseCompatibility } from 'features/translation-jobs/utils/translation-reuse-compat.util';

describe('checkTranslationReuseCompatibility', () => {
  const currentCues = [
    { cueIndex: 1, startMs: 1_000, endMs: 2_000, text: 'Hello' },
    { cueIndex: 2, startMs: 2_500, endMs: 3_000, text: 'World' },
  ];

  it('rejects when cue counts differ', () => {
    const result = checkTranslationReuseCompatibility(currentCues, [
      { cueIndex: 1, startMs: 1_000, endMs: 2_000, translatedText: 'Salut' },
    ]);

    expect(result).toEqual({
      compatible: false,
      reason: 'cue_count_mismatch',
    });
  });

  it('rejects when timings differ', () => {
    const result = checkTranslationReuseCompatibility(currentCues, [
      { cueIndex: 1, startMs: 999, endMs: 2_000, translatedText: 'Salut' },
      { cueIndex: 2, startMs: 2_500, endMs: 3_000, translatedText: 'Monde' },
    ]);

    expect(result.compatible).toBe(false);
    expect(result.reason).toBe('cue_timing_mismatch');
  });

  it('rejects when translated text is empty', () => {
    const result = checkTranslationReuseCompatibility(currentCues, [
      { cueIndex: 1, startMs: 1_000, endMs: 2_000, translatedText: ' ' },
      { cueIndex: 2, startMs: 2_500, endMs: 3_000, translatedText: 'Monde' },
    ]);

    expect(result.compatible).toBe(false);
    expect(result.reason).toBe('missing_translated_text');
  });

  it('accepts identical cue shapes', () => {
    const result = checkTranslationReuseCompatibility(currentCues, [
      { cueIndex: 1, startMs: 1_000, endMs: 2_000, translatedText: 'Salut' },
      { cueIndex: 2, startMs: 2_500, endMs: 3_000, translatedText: 'Monde' },
    ]);

    expect(result).toEqual({ compatible: true, reason: 'compatible' });
  });
});
