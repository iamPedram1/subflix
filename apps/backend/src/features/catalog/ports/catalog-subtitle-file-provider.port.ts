import { SubtitleSourceProviderName } from 'features/catalog/models/subtitle-source-provider-name.model';

export const CATALOG_SUBTITLE_FILE_PROVIDERS = Symbol(
  'CATALOG_SUBTITLE_FILE_PROVIDERS',
);

export type DownloadedSubtitlePayload = {
  sourceUrl: string;
  fileName?: string;
  contentType?: string;
  bytes: Buffer;
};

export type DownloadSubtitleFileInput = {
  provider: SubtitleSourceProviderName;
  providerSubtitleId: string;
};

export interface CatalogSubtitleFileProvider {
  readonly provider: SubtitleSourceProviderName;

  downloadSubtitleFile(
    input: DownloadSubtitleFileInput,
  ): Promise<DownloadedSubtitlePayload>;
}
