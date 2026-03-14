import { Injectable } from '@nestjs/common';

import {
  NotFoundDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { delay } from 'common/utils/delay.util';

import {
  buildMockSubtitleCues,
  mockCatalog,
} from 'features/catalog/data/mock-catalog.data';
import { SubtitleCuePort } from 'features/catalog/ports/subtitle-cue.port';
import { isStableSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';

@Injectable()
/** Keeps catalog translation jobs working while real cue downloads remain deferred. */
export class MockSubtitleCueProvider implements SubtitleCuePort {
  async getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    await delay(300);

    const mediaExists = mockCatalog.some((item) => item.id === mediaId);
    if (!mediaExists) {
      throw new NotFoundDomainError(
        'The requested media title was not found.',
        undefined,
        {
          key: 'errors.translation.media_not_found',
        },
      );
    }

    const legacyMockId = subtitleSourceId.startsWith(`${mediaId}-`);
    if (!legacyMockId && !isStableSubtitleSourceId(subtitleSourceId)) {
      throw new ValidationDomainError(
        'The requested subtitle source was not found.',
        undefined,
        {
          key: 'errors.translation.subtitle_source_not_found',
        },
      );
    }

    return buildMockSubtitleCues(mediaId);
  }
}
