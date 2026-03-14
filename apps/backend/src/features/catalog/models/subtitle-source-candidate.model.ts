import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

import { SubtitleSourceProviderName } from 'features/catalog/models/subtitle-source-provider-name.model';

export type SubtitleSourceCandidate = {
  provider: SubtitleSourceProviderName;
  providerSubtitleId: string;
  mediaTitle: string;
  mediaType: 'movie' | 'tv';
  year?: number;
  seasonNumber?: number;
  episodeNumber?: number;
  languageCode?: string;
  languageName?: string;
  releaseName?: string;
  releaseGroup?: string;
  format?: SubtitleFormat;
  lineCount?: number;
  hearingImpaired: boolean;
  downloadCount?: number;
  providerRating?: number;
  uploader?: string;
  sourcePageUrl: string;
  score: number;
  tmdbId?: number;
  imdbId?: string;
};
