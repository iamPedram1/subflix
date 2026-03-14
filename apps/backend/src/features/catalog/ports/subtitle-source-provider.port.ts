import { SubtitleSourceCandidate } from '../models/subtitle-source-candidate.model';
import { SubtitleSourceProviderName } from '../models/subtitle-source-provider-name.model';
import { SubtitleSourceSearchInput } from '../models/subtitle-source-search-input.model';

export const SUBTITLE_SOURCE_PROVIDERS = Symbol('SUBTITLE_SOURCE_PROVIDERS');

export interface SubtitleSourceProvider {
  readonly name: SubtitleSourceProviderName;
  searchSources(
    input: SubtitleSourceSearchInput,
  ): Promise<SubtitleSourceCandidate[]>;
}
