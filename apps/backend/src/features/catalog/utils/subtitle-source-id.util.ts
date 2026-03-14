import { SubtitleSourceProviderName } from 'features/catalog/models/subtitle-source-provider-name.model';
import { ValidationDomainError } from 'common/domain/errors/domain.error';

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

const isSafeDecodedValue = (value: string): boolean => {
  if (value.length < 1 || value.length > 512) {
    return false;
  }

  // Reject control characters. Provider ids and URLs should always be printable.
  for (let i = 0; i < value.length; i += 1) {
    const code = value.charCodeAt(i);
    if (code < 32 || code === 127) {
      return false;
    }
  }

  return true;
};

export const decodeSubtitleSourceId = (
  value: string,
): { provider: SubtitleSourceProviderName; providerSubtitleId: string } => {
  const trimmed = value.trim();
  if (!isStableSubtitleSourceId(trimmed)) {
    throw new ValidationDomainError(
      'The requested subtitle source was not found.',
      undefined,
      {
        key: 'errors.translation.subtitle_source_not_found',
      },
    );
  }

  const [, providerRaw, encoded] = trimmed.split(':', 3);
  const provider = providerRaw as SubtitleSourceProviderName;

  const decoded = Buffer.from(encoded ?? '', 'base64url').toString('utf8');
  if (!decoded.length || !isSafeDecodedValue(decoded)) {
    throw new ValidationDomainError(
      'The requested subtitle source was not found.',
      undefined,
      {
        key: 'errors.translation.subtitle_source_not_found',
      },
    );
  }

  // Ensure the token is canonical base64url for the decoded value (reject malformed base64 payloads).
  if (toBase64Url(decoded) !== encoded) {
    throw new ValidationDomainError(
      'The requested subtitle source was not found.',
      undefined,
      {
        key: 'errors.translation.subtitle_source_not_found',
      },
    );
  }

  return {
    provider,
    providerSubtitleId: decoded,
  };
};
