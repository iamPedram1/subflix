import { Injectable } from '@nestjs/common';

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

const wait = async (milliseconds: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));

@Injectable()
export class MockCatalogProvider
  implements MediaCatalogPort, SubtitleSourcePort
{
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

  findById(mediaId: string): Promise<CatalogMediaItem | null> {
    return Promise.resolve(
      mockCatalog.find((item) => item.id === mediaId) ?? null,
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

  async getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    await wait(300);

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
