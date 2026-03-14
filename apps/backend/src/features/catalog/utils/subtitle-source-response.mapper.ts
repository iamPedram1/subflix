import { SubtitleFormat } from 'src/common/domain/enums/subtitle-format.enum';

import { CatalogSubtitleSource } from '../models/catalog-subtitle-source.model';
import { SubtitleSourceCandidate } from '../models/subtitle-source-candidate.model';
import { buildSubtitleSourceId } from './subtitle-source-id.util';

const formatProviderName = (
  provider: SubtitleSourceCandidate['provider'],
): string => {
  if (provider === 'subdl') {
    return 'SubDL';
  }

  if (provider === 'tvsubs') {
    return 'TVSubs';
  }

  return 'Podnapisi';
};

const extractReleaseGroup = (candidate: SubtitleSourceCandidate): string => {
  const rawGroup = candidate.releaseGroup?.trim();
  if (rawGroup) {
    return rawGroup;
  }

  const rawRelease = candidate.releaseName?.trim() ?? '';
  const dashSegments = rawRelease
    .split(/[-[]/)
    .map((segment) => segment.trim());
  const releaseGroup = dashSegments.at(-1);
  if (releaseGroup?.length) {
    return releaseGroup;
  }

  return candidate.uploader?.trim() || formatProviderName(candidate.provider);
};

const buildLabel = (candidate: SubtitleSourceCandidate): string => {
  const language =
    candidate.languageName?.trim() ||
    candidate.languageCode?.trim().toUpperCase() ||
    'Subtitle';
  const release = candidate.releaseName?.trim() || candidate.mediaTitle.trim();

  return `${language} ${release}`.trim();
};

const detectFormat = (candidate: SubtitleSourceCandidate): SubtitleFormat => {
  if (candidate.format) {
    return candidate.format;
  }

  const combined =
    `${candidate.releaseName ?? ''} ${candidate.sourcePageUrl}`.toLowerCase();
  return combined.includes('.vtt') || combined.includes('webvtt')
    ? SubtitleFormat.Vtt
    : SubtitleFormat.Srt;
};

export const toCatalogSubtitleSource = (
  candidate: SubtitleSourceCandidate,
): CatalogSubtitleSource => {
  return {
    id: buildSubtitleSourceId(candidate.provider, candidate.providerSubtitleId),
    label: buildLabel(candidate),
    releaseGroup: extractReleaseGroup(candidate),
    format: detectFormat(candidate),
    hearingImpaired: candidate.hearingImpaired ?? false,
    lineCount: candidate.lineCount ?? 0,
    downloads: candidate.downloadCount ?? 0,
    rating: candidate.providerRating ?? 0,
  };
};
