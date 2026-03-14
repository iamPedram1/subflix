import { buildSubtitleSourceId } from './subtitle-source-id.util';

import { SubtitleSourceCandidate } from '../models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from '../models/subtitle-source-search-input.model';

const PROVIDER_PRIORITY: Record<SubtitleSourceCandidate['provider'], number> = {
  subdl: 0,
  podnapisi: 1,
  tvsubs: 2,
};

const normalize = (value: string | undefined): string =>
  value?.trim().toLowerCase() ?? '';

const tokenize = (values: string[]): string[] =>
  values
    .flatMap((value) =>
      value
        .toLowerCase()
        .split(/[^a-z0-9]+/i)
        .map((token) => token.trim())
        .filter((token) => token.length >= 3),
    )
    .filter((token, index, list) => list.indexOf(token) === index);

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

const hasReleaseHintMatch = (
  candidate: SubtitleSourceCandidate,
  input: SubtitleSourceSearchInput,
): boolean => {
  const release = normalize(candidate.releaseName);
  if (!release.length) {
    return false;
  }

  const tokens = tokenize([
    ...(input.releaseHints ?? []),
    input.title,
    input.originalTitle ?? '',
  ]);

  return tokens.some((token) => release.includes(token));
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

  if (hasReleaseHintMatch(candidate, input)) {
    score += 10;
  }

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
