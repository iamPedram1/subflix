import { SubtitleQualityEvaluation } from 'features/catalog/models/subtitle-quality-evaluation.model';

const disallowedWarnings = new Set([
  'invalid_timing_ranges',
  'episode_mismatch',
  'release_contradiction',
  'suspiciously_short_subtitle',
  'tiny_duration_coverage',
]);

export const canReuseTargetLanguageSubtitle = (
  evaluation: SubtitleQualityEvaluation,
): { allowed: boolean; reason: string } => {
  if (evaluation.shouldBlockAutoUse) {
    return { allowed: false, reason: 'blocked_by_quality_gate' };
  }

  if (evaluation.confidenceLevel === 'low') {
    return { allowed: false, reason: 'low_confidence' };
  }

  if (evaluation.warnings.some((warning) => disallowedWarnings.has(warning))) {
    return { allowed: false, reason: 'disallowed_warning' };
  }

  // Conservative MVP: don't reuse when release matching explicitly flags a mismatch.
  if (evaluation.warnings.includes('release_mismatch')) {
    return { allowed: false, reason: 'release_mismatch' };
  }

  return { allowed: true, reason: 'allowed' };
};
