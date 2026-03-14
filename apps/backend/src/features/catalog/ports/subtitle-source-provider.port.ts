import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceProviderName } from 'features/catalog/models/subtitle-source-provider-name.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';

export const SUBTITLE_SOURCE_PROVIDERS = Symbol('SUBTITLE_SOURCE_PROVIDERS');

export interface SubtitleSourceProvider {
  readonly name: SubtitleSourceProviderName;
  searchSources(
    input: SubtitleSourceSearchInput,
  ): Promise<SubtitleSourceCandidate[]>;
}
