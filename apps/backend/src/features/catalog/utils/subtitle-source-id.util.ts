import { SubtitleSourceProviderName } from '../models/subtitle-source-provider-name.model';

const SUBTITLE_SOURCE_ID_PATTERN =
  /^ssrc:(subdl|podnapisi|tvsubs):[A-Za-z0-9_-]+$/;

const toBase64Url = (value: string): string =>
  Buffer.from(value, 'utf8').toString('base64url');

export const buildSubtitleSourceId = (
  provider: SubtitleSourceProviderName,
  providerSubtitleId: string,
): string => {
  return `ssrc:${provider}:${toBase64Url(providerSubtitleId)}`;
};

export const isStableSubtitleSourceId = (value: string): boolean => {
  return SUBTITLE_SOURCE_ID_PATTERN.test(value);
};
