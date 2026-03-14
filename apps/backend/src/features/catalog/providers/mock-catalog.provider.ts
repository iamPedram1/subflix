import { Injectable } from '@nestjs/common';

import { SearchMediaType } from 'src/common/domain/enums/search-media-type.enum';
import { delay } from 'src/common/utils/delay.util';
import { ServiceUnavailableDomainError } from 'src/common/domain/errors/domain.error';

import { mockCatalog } from '../data/mock-catalog.data';
import { CatalogMediaDetails } from '../models/catalog-media-details.model';
import { CatalogMediaItem } from '../models/catalog-media-item.model';
import { MediaCatalogPort } from '../ports/media-catalog.port';

@Injectable()
/** Deterministic in-memory catalog adapter used while external providers are mocked. */
export class MockCatalogProvider implements MediaCatalogPort {
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
  findById(mediaId: string): Promise<CatalogMediaDetails | null> {
    const item = mockCatalog.find((entry) => entry.id === mediaId);
    if (!item) {
      return Promise.resolve(null);
    }

    return Promise.resolve({
      ...item,
      originalTitle: item.title,
      providerMediaType:
        item.mediaType === SearchMediaType.Movie ? 'movie' : 'tv',
    });
  }
}
