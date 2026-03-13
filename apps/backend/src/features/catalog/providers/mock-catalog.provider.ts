import { Injectable } from '@nestjs/common';

import { delay } from 'src/common/utils/delay.util';
import {
  NotFoundDomainError,
  ServiceUnavailableDomainError,
} from 'src/common/domain/errors/domain.error';

import {
  buildMockSubtitleCues,
  buildMockSubtitleSources,
  mockCatalog,
} from '../data/mock-catalog.data';
import { CatalogMediaItem } from '../models/catalog-media-item.model';
import { CatalogSubtitleSource } from '../models/catalog-subtitle-source.model';
import { MediaCatalogPort } from '../ports/media-catalog.port';
import { SubtitleSourcePort } from '../ports/subtitle-source.port';

@Injectable()
/** Deterministic in-memory catalog adapter used while external providers are mocked. */
export class MockCatalogProvider
  implements MediaCatalogPort, SubtitleSourcePort
{
  /** Simulates a provider-backed catalog search with deterministic fake results. */
  async search(query: string): Promise<CatalogMediaItem[]> {
    await delay(query.trim().length > 2 ? 350 : 150);

    const normalized = query.trim().toLowerCase();
    if (normalized.includes('error')) {
      throw new ServiceUnavailableDomainError(
        'Mock search failed. Please try another title.',
      );
    }

    return mockCatalog.filter(
      (item) =>
        item.title.toLowerCase().includes(normalized) ||
        item.genres.some((genre) => genre.toLowerCase().includes(normalized)),
    );
  }

  /** Returns a single fake catalog entry when it exists. */
  findById(mediaId: string): Promise<CatalogMediaItem | null> {
    return Promise.resolve(
      mockCatalog.find((item) => item.id === mediaId) ?? null,
    );
  }

  /** Returns subtitle sources for a fake media title. */
  async getSubtitleSources(mediaId: string): Promise<CatalogSubtitleSource[]> {
    await delay(500);

    if (mediaId.includes('error')) {
      throw new ServiceUnavailableDomainError(
        'Subtitles are temporarily unavailable for this title.',
      );
    }

    return buildMockSubtitleSources(mediaId);
  }

  /** Returns normalized subtitle cues for the selected fake source. */
  async getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    await delay(300);

    const hasSource = buildMockSubtitleSources(mediaId).some(
      (source) => source.id === subtitleSourceId,
    );
    if (!hasSource) {
      throw new NotFoundDomainError(
        'The requested subtitle source was not found.',
      );
    }

    return buildMockSubtitleCues(mediaId);
  }
}
