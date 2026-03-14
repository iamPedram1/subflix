import { ParsedReleaseHint } from 'features/catalog/utils/release-hint-parser.util';

export type ReleaseHintMatchBreakdown = {
  groupExact: boolean;
  sourceTypeMatch: boolean;
  resolutionMatch: boolean;
  codecMatch: boolean;
  sourceTypeMismatch: boolean;
  resolutionMismatch: boolean;
  codecMismatch: boolean;
  scoreDelta: number;
};

const normalize = (value: string | undefined): string =>
  value?.trim().toLowerCase() ?? '';

const hasExactGroupMatch = (
  preferred: ParsedReleaseHint,
  candidate: ParsedReleaseHint,
): boolean => {
  const left = normalize(preferred.releaseGroup);
  const right = normalize(candidate.releaseGroup);
  return left.length > 0 && left === right;
};

const WEIGHTS = {
  groupExact: 25,
  sourceTypeMatch: 10,
  resolutionMatch: 8,
  codecMatch: 6,
  sourceTypeMismatch: -8,
  resolutionMismatch: -6,
  codecMismatch: -4,
} as const;

export const scoreReleaseHintMatch = (
  preferred: ParsedReleaseHint,
  candidate: ParsedReleaseHint,
): ReleaseHintMatchBreakdown => {
  let scoreDelta = 0;

  const groupExact = hasExactGroupMatch(preferred, candidate);
  if (groupExact) {
    scoreDelta += WEIGHTS.groupExact;
  }

  const sourceTypeMatch =
    preferred.sourceType !== undefined &&
    candidate.sourceType !== undefined &&
    preferred.sourceType === candidate.sourceType;
  const sourceTypeMismatch =
    preferred.sourceType !== undefined &&
    candidate.sourceType !== undefined &&
    preferred.sourceType !== candidate.sourceType;
  if (sourceTypeMatch) {
    scoreDelta += WEIGHTS.sourceTypeMatch;
  } else if (sourceTypeMismatch) {
    scoreDelta += WEIGHTS.sourceTypeMismatch;
  }

  const resolutionMatch =
    preferred.resolution !== undefined &&
    candidate.resolution !== undefined &&
    preferred.resolution === candidate.resolution;
  const resolutionMismatch =
    preferred.resolution !== undefined &&
    candidate.resolution !== undefined &&
    preferred.resolution !== candidate.resolution;
  if (resolutionMatch) {
    scoreDelta += WEIGHTS.resolutionMatch;
  } else if (resolutionMismatch) {
    scoreDelta += WEIGHTS.resolutionMismatch;
  }

  const codecMatch =
    preferred.codec !== undefined &&
    candidate.codec !== undefined &&
    preferred.codec === candidate.codec;
  const codecMismatch =
    preferred.codec !== undefined &&
    candidate.codec !== undefined &&
    preferred.codec !== candidate.codec;
  if (codecMatch) {
    scoreDelta += WEIGHTS.codecMatch;
  } else if (codecMismatch) {
    scoreDelta += WEIGHTS.codecMismatch;
  }

  return {
    groupExact,
    sourceTypeMatch,
    resolutionMatch,
    codecMatch,
    sourceTypeMismatch,
    resolutionMismatch,
    codecMismatch,
    scoreDelta,
  };
};
