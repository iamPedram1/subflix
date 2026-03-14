import {
  analyzeSubtitleTimingOffset,
  shiftSubtitleCues,
} from 'features/catalog/utils/subtitle-timing-alignment.util';

describe('subtitle-timing-alignment.util', () => {
  it('refuses to shift cues into negative timestamps', () => {
    const shifted = shiftSubtitleCues(
      [{ cueIndex: 1, startMs: 500, endMs: 1500, text: 'Hello' }],
      -1000,
    );

    expect(shifted).toBeNull();
  });

  it('detects and applies a positive offset when cues start extremely early', () => {
    const result = analyzeSubtitleTimingOffset({
      enabled: true,
      maxOffsetMs: 10_000,
      stepMs: 1_000,
      confidenceThreshold: 60,
      cues: [
        { cueIndex: 1, startMs: 0, endMs: 1200, text: 'Hello' },
        { cueIndex: 2, startMs: 1500, endMs: 3000, text: 'World' },
      ],
    });

    expect(result.analysis.appliedCorrection).toBe(true);
    expect(result.analysis.detectedOffsetMs).toBe(1000);
    expect(result.cues[0]?.startMs).toBe(1000);
  });

  it('does not apply correction when subtitles already start in a reasonable window', () => {
    const result = analyzeSubtitleTimingOffset({
      enabled: true,
      maxOffsetMs: 10_000,
      stepMs: 1_000,
      confidenceThreshold: 60,
      cues: [
        { cueIndex: 1, startMs: 1500, endMs: 2500, text: 'Hello' },
        { cueIndex: 2, startMs: 3500, endMs: 5000, text: 'World' },
      ],
    });

    expect(result.analysis.appliedCorrection).toBe(false);
    expect(result.analysis.detectedOffsetMs).toBe(0);
  });
});
