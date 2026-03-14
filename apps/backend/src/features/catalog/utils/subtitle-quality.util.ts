import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import {
  mergeReleaseHints,
  parseReleaseHint,
} from 'features/catalog/utils/release-hint-parser.util';
import { scoreReleaseHintMatch } from 'features/catalog/utils/release-hint-match.util';

import {
  SubtitleConfidenceLevel,
  SubtitleQualityEvaluation,
} from 'features/catalog/models/subtitle-quality-evaluation.model';

const clamp = (value: number, min: number, max: number): number =>
  Math.max(min, Math.min(max, value));

const uniq = (values: string[]): string[] =>
  values.filter((value, index, list) => list.indexOf(value) === index);

const sumDurations = (cues: SubtitleCue[]): number =>
  cues.reduce((total, cue) => total + Math.max(0, cue.endMs - cue.startMs), 0);

const estimateSpanMs = (cues: SubtitleCue[]): number => {
  if (cues.length === 0) {
    return 0;
  }

  const sorted = [...cues].sort((a, b) => a.cueIndex - b.cueIndex);
  const first = sorted[0];
  const last = sorted[sorted.length - 1];
  return Math.max(0, (last?.endMs ?? 0) - (first?.startMs ?? 0));
};

const detectTimingIssues = (cues: SubtitleCue[]) => {
  const sorted = [...cues].sort((a, b) => a.cueIndex - b.cueIndex);

  let nonMonotonicStarts = 0;
  let invalidRanges = 0;
  let overlaps = 0;

  let previousStart = -1;
  let previousEnd = -1;

  for (const cue of sorted) {
    if (cue.endMs <= cue.startMs) {
      invalidRanges += 1;
    }

    if (previousStart >= 0 && cue.startMs + 100 < previousStart) {
      nonMonotonicStarts += 1;
    }

    if (previousEnd >= 0 && cue.startMs < previousEnd) {
      overlaps += 1;
    }

    previousStart = cue.startMs;
    previousEnd = cue.endMs;
  }

  return {
    nonMonotonicStarts,
    invalidRanges,
    overlaps,
    totalCues: sorted.length,
  };
};

const parseEpisodeCode = (
  value: string,
): { seasonNumber: number; episodeNumber: number } | null => {
  const match =
    value.match(/s(\d{1,2})e(\d{1,2})/i) ?? value.match(/(\d{1,2})x(\d{2})/i);
  if (!match) {
    return null;
  }

  const seasonNumber = Number(match[1]);
  const episodeNumber = Number(match[2]);
  if (!Number.isInteger(seasonNumber) || !Number.isInteger(episodeNumber)) {
    return null;
  }

  return { seasonNumber, episodeNumber };
};

const looksLikeEnglish = (cues: SubtitleCue[]): boolean => {
  const sample = cues
    .slice(0, 40)
    .map((cue) => cue.text)
    .join(' ');
  const letters = (sample.match(/[a-z]/gi) ?? []).length;
  const nonLetters = (sample.match(/[^a-z]/gi) ?? []).length;
  const ratio = letters / Math.max(1, letters + nonLetters);

  const lower = sample.toLowerCase();
  const hasStopwords =
    lower.includes(' the ') ||
    lower.includes(' and ') ||
    lower.includes(' you ') ||
    lower.includes(' i ') ||
    lower.includes(" i'm ") ||
    lower.includes(' to ');

  return ratio >= 0.35 && hasStopwords;
};

const deriveLevel = (score: number): SubtitleConfidenceLevel => {
  if (score >= 80) {
    return 'high';
  }
  if (score >= 55) {
    return 'medium';
  }
  return 'low';
};

export const evaluateCatalogSubtitleQuality = (params: {
  media: CatalogMediaDetails;
  cues: SubtitleCue[];
  sourceName: string;
  subtitleSourceId: string;
  releaseHint?: string;
  seasonNumber?: number;
  episodeNumber?: number;
  expectedLanguageCode?: string;
}): SubtitleQualityEvaluation => {
  const warnings: string[] = [];
  const signals: Record<string, unknown> = {};

  const cueCount = params.cues.length;
  signals.cueCount = cueCount;

  if (cueCount === 0) {
    return {
      confidenceScore: 0,
      confidenceLevel: 'low',
      warnings: ['empty_subtitle'],
      shouldBlockAutoUse: true,
      signals: { cueCount: 0 },
    };
  }

  const timing = detectTimingIssues(params.cues);
  signals.timing = timing;

  if (timing.invalidRanges > 0) {
    warnings.push('invalid_timing_ranges');
  }

  if (timing.nonMonotonicStarts > 0) {
    warnings.push('non_monotonic_cues');
  }

  const spanMs = estimateSpanMs(params.cues);
  const coveredMs = sumDurations(params.cues);
  signals.spanMs = spanMs;
  signals.coveredMs = coveredMs;

  const expectedMs = Math.max(0, (params.media.runtimeMinutes ?? 0) * 60_000);
  signals.expectedMs = expectedMs;

  // Cue count sanity thresholds.
  const isTv = params.media.providerMediaType === 'tv';
  const extremelyLowCueCount = isTv ? cueCount < 10 : cueCount < 20;
  const lowCueCount = isTv ? cueCount < 30 : cueCount < 80;
  const warnCueCount = isTv ? cueCount < 80 : cueCount < 200;

  if (extremelyLowCueCount) {
    warnings.push('extremely_low_cue_count');
  } else if (lowCueCount) {
    warnings.push('low_cue_count');
  } else if (warnCueCount) {
    warnings.push('below_expected_cue_count');
  }

  // Timing sanity: subtitles that cover a tiny portion of the expected runtime are suspicious.
  if (spanMs < 30_000) {
    warnings.push('suspiciously_short_subtitle');
  } else if (expectedMs > 0) {
    const ratio = spanMs / expectedMs;
    signals.spanRatio = Number(ratio.toFixed(3));
    if (ratio < 0.2) {
      warnings.push('tiny_duration_coverage');
    } else if (ratio < 0.5) {
      warnings.push('low_duration_coverage');
    }
  }

  // Episode consistency: compare explicit episode tokens in sourceName to requested episode scope.
  if (
    params.seasonNumber !== undefined &&
    params.episodeNumber !== undefined &&
    isTv
  ) {
    const parsed = parseEpisodeCode(params.sourceName);
    if (parsed) {
      signals.episodeCode = parsed;
      if (
        parsed.seasonNumber !== params.seasonNumber ||
        parsed.episodeNumber !== params.episodeNumber
      ) {
        warnings.push('episode_mismatch');
      }
    } else {
      warnings.push('missing_episode_metadata');
    }
  }

  // File/label indicators.
  const sourceNameLower = params.sourceName.toLowerCase();
  if (
    sourceNameLower.includes('sample') ||
    sourceNameLower.includes('trailer')
  ) {
    warnings.push('suspicious_filename');
  }
  if (sourceNameLower.includes('forced')) {
    warnings.push('forced_subtitle');
  }

  // Release confidence: reuse release-aware hint scoring.
  if (params.releaseHint?.trim()) {
    const preferred = mergeReleaseHints([
      parseReleaseHint(params.releaseHint.trim()),
    ]);
    const candidate = parseReleaseHint(params.sourceName);
    const breakdown = scoreReleaseHintMatch(preferred, candidate);
    signals.releaseMatch = breakdown;

    if (breakdown.scoreDelta <= -20) {
      warnings.push('release_contradiction');
    } else if (breakdown.scoreDelta < 0) {
      warnings.push('release_mismatch');
    } else if (breakdown.scoreDelta >= 20) {
      // No warning, but keep as a positive signal.
    }
  }

  // Language sanity (very lightweight).
  const expectedLanguage = params.expectedLanguageCode?.trim().toLowerCase();
  if (!expectedLanguage || expectedLanguage === 'en') {
    if (!looksLikeEnglish(params.cues)) {
      warnings.push('language_unexpected');
    }
  }

  // Blocking policy: only block clearly broken subtitles.
  const shouldBlockAutoUse = timing.invalidRanges > 0 || spanMs === 0;

  // Deterministic score aggregation.
  let score = 100;

  if (timing.invalidRanges > 0) {
    score -= 60;
  }

  if (timing.nonMonotonicStarts > 0) {
    score -= Math.min(30, 5 + timing.nonMonotonicStarts * 4);
  }

  if (extremelyLowCueCount) {
    score -= 55;
  } else if (lowCueCount) {
    score -= 35;
  } else if (warnCueCount) {
    score -= 15;
  }

  if (expectedMs > 0 && spanMs > 0) {
    const ratio = spanMs / expectedMs;
    if (ratio < 0.2) {
      score -= 35;
    } else if (ratio < 0.5) {
      score -= 18;
    }
  } else if (spanMs > 0 && spanMs < 60_000) {
    score -= 25;
  }

  if (warnings.includes('suspicious_filename')) {
    score -= 10;
  }

  if (warnings.includes('forced_subtitle')) {
    score -= 6;
  }

  if (warnings.includes('episode_mismatch')) {
    score -= 20;
  }

  if (warnings.includes('missing_episode_metadata')) {
    score -= 8;
  }

  if (warnings.includes('release_contradiction')) {
    score -= 25;
  } else if (warnings.includes('release_mismatch')) {
    score -= 12;
  }

  if (warnings.includes('language_unexpected')) {
    score -= 10;
  }

  // Reward richer metadata a bit if present.
  if (params.releaseHint?.trim()) {
    score += 2;
  }
  if (sourceNameLower.includes('1080p') || sourceNameLower.includes('2160p')) {
    score += 2;
  }

  score = clamp(score, 0, 100);

  return {
    confidenceScore: score,
    confidenceLevel: deriveLevel(score),
    warnings: uniq(warnings),
    shouldBlockAutoUse,
    signals,
  };
};
