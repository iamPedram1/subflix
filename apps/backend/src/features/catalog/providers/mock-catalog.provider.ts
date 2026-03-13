import { Injectable } from '@nestjs/common';

import { ServiceUnavailableDomainError } from 'src/common/domain/errors/domain.error';

import { buildMockSubtitleSources, mockCatalog } from '../data/mock-catalog.data';
import { CatalogMediaItem } from '../models/catalog-media-item.model';
import { CatalogSubtitleSource } from '../models/catalog-subtitle-source.model';
import { MediaCatalogPort } from '../ports/media-catalog.port';
import { SubtitleSourcePort } from '../ports/subtitle-source.port';

const wait = async (milliseconds: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));

@Injectable()
export class MockCatalogProvider implements MediaCatalogPort, SubtitleSourcePort {
  async search(query: string): Promise<CatalogMediaItem[]> {
    await wait(query.trim().length > 2 ? 350 : 150);

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

  async getSubtitleSources(mediaId: string): Promise<CatalogSubtitleSource[]> {
    await wait(500);

    if (mediaId.includes('error')) {
      throw new ServiceUnavailableDomainError(
        'Subtitles are temporarily unavailable for this title.',
      );
    }

    return buildMockSubtitleSources(mediaId);
  }
}
