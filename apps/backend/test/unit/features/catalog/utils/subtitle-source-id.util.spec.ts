import { ValidationDomainError } from 'common/domain/errors/domain.error';
import {
  buildSubtitleSourceId,
  decodeSubtitleSourceId,
} from 'features/catalog/utils/subtitle-source-id.util';

describe('subtitle-source-id.util', () => {
  it('decodes stable subtitle source ids back into provider and provider subtitle id', () => {
    const id = buildSubtitleSourceId('subdl', 'subtitle-123');
    expect(decodeSubtitleSourceId(id)).toEqual({
      provider: 'subdl',
      providerSubtitleId: 'subtitle-123',
    });
  });

  it('rejects malformed ids with a normalized validation error', () => {
    expect(() => decodeSubtitleSourceId('ssrc:subdl:not-base64')).toThrow(
      ValidationDomainError,
    );
    expect(() => decodeSubtitleSourceId('nope')).toThrow(ValidationDomainError);
  });
});
