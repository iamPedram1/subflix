export type ReleaseSourceType =
  | 'bluray'
  | 'webdl'
  | 'webrip'
  | 'hdtv'
  | 'dvdrip';
export type ReleaseResolution = 480 | 720 | 1080 | 2160;
export type ReleaseCodec = 'x264' | 'x265' | 'h264' | 'h265' | 'hevc';

export type ParsedReleaseHint = {
  sourceType?: ReleaseSourceType;
  resolution?: ReleaseResolution;
  codec?: ReleaseCodec;
  releaseGroup?: string;
  tokens: string[];
};

const normalize = (value: string | undefined): string =>
  value?.trim().toLowerCase() ?? '';

const uniq = (tokens: string[]): string[] =>
  tokens.filter((token, index, list) => list.indexOf(token) === index);

const tokenize = (value: string): string[] =>
  uniq(
    normalize(value)
      .split(/[^a-z0-9]+/i)
      .map((token) => token.trim())
      .filter(Boolean),
  );

const hasAllTokens = (tokens: string[], required: string[]): boolean =>
  required.every((value) => tokens.includes(normalize(value)));

const isLikelyGroupToken = (value: string): boolean => {
  const token = normalize(value).replace(/[^a-z0-9]/g, '');
  if (token.length < 2 || token.length > 20) {
    return false;
  }

  // Avoid treating common metadata tokens as "group".
  const blacklist = new Set([
    'bluray',
    'bdrip',
    'brrip',
    'brip',
    'webdl',
    'webrip',
    'hdtv',
    'dvdrip',
    'x264',
    'x265',
    'h264',
    'h265',
    'hevc',
    '480p',
    '720p',
    '1080p',
    '2160p',
  ]);
  if (blacklist.has(token)) {
    return false;
  }

  return true;
};

const extractReleaseGroup = (raw: string): string | undefined => {
  const value = raw.trim();
  if (!value.length) {
    return undefined;
  }

  // Prefer bracketed groups near the end: "... [GROUP]"
  const bracketMatch = value.match(/\[([^\]]{2,32})\]\s*$/);
  if (bracketMatch?.[1] && isLikelyGroupToken(bracketMatch[1])) {
    return normalize(bracketMatch[1]);
  }

  // Prefer the final "-GROUP" segment: "...-GROUP"
  const dashIndex = value.lastIndexOf('-');
  if (dashIndex > 0 && dashIndex < value.length - 1) {
    const candidate = value.slice(dashIndex + 1).trim();
    if (isLikelyGroupToken(candidate)) {
      return normalize(candidate);
    }
  }

  return undefined;
};

const extractResolution = (tokens: string[]): ReleaseResolution | undefined => {
  const match = tokens.find((token) => /^(480|720|1080|2160)p$/.test(token));
  if (!match) {
    return undefined;
  }

  const numeric = Number(match.slice(0, -1));
  if (
    numeric === 480 ||
    numeric === 720 ||
    numeric === 1080 ||
    numeric === 2160
  ) {
    return numeric;
  }

  return undefined;
};

const extractSourceType = (tokens: string[]): ReleaseSourceType | undefined => {
  if (
    tokens.includes('bluray') ||
    hasAllTokens(tokens, ['blu', 'ray']) ||
    ['bdrip', 'brrip', 'brip'].some((token) => tokens.includes(token))
  ) {
    return 'bluray';
  }

  if (tokens.includes('webdl') || hasAllTokens(tokens, ['web', 'dl'])) {
    return 'webdl';
  }

  if (tokens.includes('webrip') || hasAllTokens(tokens, ['web', 'rip'])) {
    return 'webrip';
  }

  if (tokens.includes('hdtv')) {
    return 'hdtv';
  }

  if (tokens.includes('dvdrip') || hasAllTokens(tokens, ['dvd', 'rip'])) {
    return 'dvdrip';
  }

  return undefined;
};

const extractCodec = (tokens: string[]): ReleaseCodec | undefined => {
  if (tokens.includes('x264') || hasAllTokens(tokens, ['x', '264'])) {
    return 'x264';
  }

  if (tokens.includes('x265') || hasAllTokens(tokens, ['x', '265'])) {
    return 'x265';
  }

  if (tokens.includes('hevc')) {
    return 'hevc';
  }

  if (
    tokens.includes('h264') ||
    tokens.includes('avc') ||
    hasAllTokens(tokens, ['h', '264'])
  ) {
    return 'h264';
  }

  if (tokens.includes('h265') || hasAllTokens(tokens, ['h', '265'])) {
    return 'h265';
  }

  return undefined;
};

export const parseReleaseHint = (
  raw: string | undefined,
  options?: { releaseGroupOverride?: string },
): ParsedReleaseHint => {
  const normalized = raw?.trim() ?? '';
  if (!normalized.length) {
    return { tokens: [] };
  }

  const tokens = tokenize(normalized);
  const releaseGroup =
    normalize(options?.releaseGroupOverride) ||
    extractReleaseGroup(normalized) ||
    undefined;

  return {
    sourceType: extractSourceType(tokens),
    resolution: extractResolution(tokens),
    codec: extractCodec(tokens),
    releaseGroup,
    tokens: uniq([...(releaseGroup ? [releaseGroup] : []), ...tokens]),
  };
};

export const mergeReleaseHints = (
  hints: ParsedReleaseHint[],
): ParsedReleaseHint => {
  const firstScalar = <T>(values: Array<T | undefined>): T | undefined =>
    values.find((value): value is T => value !== undefined);

  const mergedTokens = uniq(hints.flatMap((hint) => hint.tokens));

  return {
    sourceType: firstScalar(hints.map((hint) => hint.sourceType)),
    resolution: firstScalar(hints.map((hint) => hint.resolution)),
    codec: firstScalar(hints.map((hint) => hint.codec)),
    releaseGroup: firstScalar(hints.map((hint) => hint.releaseGroup)),
    tokens: mergedTokens,
  };
};
