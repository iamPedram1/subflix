import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

import { SubtitleTimingAnalysis } from 'features/catalog/models/subtitle-timing-analysis.model';

const clamp = (value: number, min: number, max: number): number =>
  Math.max(min, Math.min(max, value));

const uniq = (values: string[]): string[] =>
  values.filter((value, index, list) => list.indexOf(value) === index);

const sortCues = (cues: SubtitleCue[]): SubtitleCue[] =>
  [...cues].sort((a, b) => a.cueIndex - b.cueIndex);

export const shiftSubtitleCues = (
  cues: SubtitleCue[],
  offsetMs: number,
): SubtitleCue[] | null => {
  if (offsetMs === 0) {
    return cues;
  }

  const shifted: SubtitleCue[] = [];
  for (const cue of cues) {
    const startMs = cue.startMs + offsetMs;
    const endMs = cue.endMs + offsetMs;

    if (startMs < 0 || endMs < 0) {
      return null;
    }

    if (endMs <= startMs) {
      return null;
    }

    shifted.push({
      cueIndex: cue.cueIndex,
      startMs,
      endMs,
      text: cue.text,
    });
  }

  return shifted;
};

const scoreOffsetCandidate = (
  cues: SubtitleCue[],
  offsetMs: number,
): number => {
  const sorted = sortCues(cues);

  let firstStart = Number.POSITIVE_INFINITY;
  let cuesInFirstTwoMinutes = 0;
  let firstGapMs = 0;
  let previousStart: number | null = null;

  for (const cue of sorted) {
    const startMs = cue.startMs + offsetMs;
    const endMs = cue.endMs + offsetMs;

    if (startMs < 0 || endMs < 0) {
      return -1_000_000;
    }
    if (endMs <= startMs) {
      return -1_000_000;
    }

    if (startMs < firstStart) {
      firstStart = startMs;
    }

    if (startMs < 120_000) {
      cuesInFirstTwoMinutes += 1;
    }

    if (previousStart !== null && firstGapMs === 0) {
      firstGapMs = Math.max(0, startMs - previousStart);
    }

    previousStart = startMs;
  }

  if (!Number.isFinite(firstStart)) {
    return -1_000_000;
  }

  // Treat a reasonable first-cue window as "good" so we don't over-correct.
  // Penalize only when the first cue is very early (<1s) or very late.
  const goodFirstStartMinMs = 1_000;
  const goodFirstStartMaxMs = 20_000;
  const distanceOutsideWindow =
    firstStart < goodFirstStartMinMs
      ? goodFirstStartMinMs - firstStart
      : firstStart > goodFirstStartMaxMs
        ? firstStart - goodFirstStartMaxMs
        : 0;
  const penaltyFirstStartDistance = clamp(distanceOutsideWindow / 100, 0, 45);

  const penaltyEarlyStart = firstStart < 1_000 ? 18 : 0;
  const penaltySilentIntro =
    firstStart > 120_000 ? clamp((firstStart - 120_000) / 1_000, 10, 45) : 0;

  const penaltySparseIntro = cuesInFirstTwoMinutes < 2 ? 15 : 0;
  const penaltyLargeInitialGap = firstGapMs > 30_000 ? 10 : 0;

  const penalty =
    penaltyFirstStartDistance +
    penaltyEarlyStart +
    penaltySilentIntro +
    penaltySparseIntro +
    penaltyLargeInitialGap;

  return 100 - penalty;
};

export const analyzeSubtitleTimingOffset = (params: {
  cues: SubtitleCue[];
  maxOffsetMs: number;
  stepMs: number;
  confidenceThreshold: number;
  enabled: boolean;
}): { cues: SubtitleCue[]; analysis: SubtitleTimingAnalysis } => {
  const warnings: string[] = [];

  if (!params.enabled) {
    return {
      cues: params.cues,
      analysis: {
        detectedOffsetMs: 0,
        confidence: 0,
        appliedCorrection: false,
        warnings: [],
      },
    };
  }

  const maxOffsetMs = Math.max(0, Math.floor(params.maxOffsetMs));
  const stepMs = Math.max(250, Math.floor(params.stepMs));

  const baselineScore = scoreOffsetCandidate(params.cues, 0);

  let bestOffsetMs = 0;
  let bestScore = baselineScore;

  for (let offset = -maxOffsetMs; offset <= maxOffsetMs; offset += stepMs) {
    const candidateScore = scoreOffsetCandidate(params.cues, offset);
    if (candidateScore > bestScore) {
      bestScore = candidateScore;
      bestOffsetMs = offset;
    }
  }

  const improvement = bestScore - baselineScore;
  const confidence = clamp(
    Math.round(50 + Math.max(0, improvement) * 8),
    0,
    100,
  );

  const safeShifted = shiftSubtitleCues(params.cues, bestOffsetMs);
  const isSafe = safeShifted !== null;

  if (!isSafe && bestOffsetMs !== 0) {
    warnings.push('alignment_unsafe_shift');
  }

  const shouldApply =
    bestOffsetMs !== 0 &&
    isSafe &&
    confidence >= params.confidenceThreshold &&
    improvement >= 3;

  if (bestOffsetMs !== 0 && confidence < params.confidenceThreshold) {
    warnings.push('alignment_low_confidence');
  }

  if (bestOffsetMs !== 0 && improvement < 3) {
    warnings.push('alignment_low_improvement');
  }

  return {
    cues: shouldApply && safeShifted ? safeShifted : params.cues,
    analysis: {
      detectedOffsetMs: bestOffsetMs,
      confidence,
      appliedCorrection: shouldApply,
      warnings: uniq(warnings),
    },
  };
};
