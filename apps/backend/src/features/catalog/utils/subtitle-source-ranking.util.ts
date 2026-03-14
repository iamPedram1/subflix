import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';

import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import {
  mergeReleaseHints,
  parseReleaseHint,
} from 'features/catalog/utils/release-hint-parser.util';
import { scoreReleaseHintMatch } from 'features/catalog/utils/release-hint-match.util';

const PROVIDER_PRIORITY: Record<SubtitleSourceCandidate['provider'], number> = {
  subdl: 0,
  podnapisi: 1,
  tvsubs: 2,
};

const normalize = (value: string | undefined): string =>
  value?.trim().toLowerCase() ?? '';

const hasExactIdentityMatch = (
  candidate: SubtitleSourceCandidate,
  input: SubtitleSourceSearchInput,
): boolean => {
  return (
    (input.tmdbId !== undefined && candidate.tmdbId === input.tmdbId) ||
    (input.imdbId !== undefined &&
      normalize(candidate.imdbId) === normalize(input.imdbId))
  );
};

const hasPreferredLanguageMatch = (
  candidate: SubtitleSourceCandidate,
  input: SubtitleSourceSearchInput,
): boolean => {
  return (
    normalize(candidate.languageCode) === normalize(input.preferredLanguage)
  );
};

const calculateReleaseHintDelta = (
  candidate: SubtitleSourceCandidate,
  input: SubtitleSourceSearchInput,
): number => {
  const rawHints = (input.releaseHints ?? [])
    .map((hint) => hint.trim())
    .filter(Boolean);
  if (rawHints.length === 0) {
    return 0;
  }

  const preferred = mergeReleaseHints(
    rawHints.map((hint) => parseReleaseHint(hint)),
  );
  const candidateHint = parseReleaseHint(candidate.releaseName ?? '', {
    releaseGroupOverride: candidate.releaseGroup,
  });

  if (candidateHint.tokens.length === 0) {
    return 0;
  }

  return scoreReleaseHintMatch(preferred, candidateHint).scoreDelta;
};

const calculateScore = (
  candidate: SubtitleSourceCandidate,
  input: SubtitleSourceSearchInput,
): number => {
  let score = 0;

  if (hasExactIdentityMatch(candidate, input)) {
    score += 100;
  }

  if (candidate.mediaType === input.mediaType) {
    score += 30;
  }

  if (input.year !== undefined && candidate.year === input.year) {
    score += 20;
  }

  if (
    input.seasonNumber !== undefined &&
    candidate.seasonNumber === input.seasonNumber
  ) {
    score += 25;
  }

  if (
    input.episodeNumber !== undefined &&
    candidate.episodeNumber === input.episodeNumber
  ) {
    score += 25;
  }

  if (hasPreferredLanguageMatch(candidate, input)) {
    score += 15;
  }

  score += calculateReleaseHintDelta(candidate, input);

  if (candidate.releaseName?.trim() || candidate.releaseGroup?.trim()) {
    score += 4;
  }

  if (candidate.hearingImpaired) {
    score += 1;
  }

  return score;
};

export const rankSubtitleSourceCandidates = (
  candidates: SubtitleSourceCandidate[],
  input: SubtitleSourceSearchInput,
): SubtitleSourceCandidate[] => {
  return candidates
    .map((candidate) => ({
      ...candidate,
      score: calculateScore(candidate, input),
    }))
    .sort((left, right) => {
      if (right.score !== left.score) {
        return right.score - left.score;
      }

      const leftDownloads = left.downloadCount ?? 0;
      const rightDownloads = right.downloadCount ?? 0;
      if (rightDownloads !== leftDownloads) {
        return rightDownloads - leftDownloads;
      }

      const providerPriority =
        PROVIDER_PRIORITY[left.provider] - PROVIDER_PRIORITY[right.provider];
      if (providerPriority !== 0) {
        return providerPriority;
      }

      return buildSubtitleSourceId(
        left.provider,
        left.providerSubtitleId,
      ).localeCompare(
        buildSubtitleSourceId(right.provider, right.providerSubtitleId),
      );
    });
};
