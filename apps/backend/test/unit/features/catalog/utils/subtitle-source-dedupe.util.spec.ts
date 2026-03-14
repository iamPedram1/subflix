import { dedupeSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-dedupe.util';

describe('dedupeSubtitleSourceCandidates', () => {
  it('dedupes by provider and provider subtitle id first', () => {
    const deduped = dedupeSubtitleSourceCandidates([
      {
        provider: 'subdl',
        providerSubtitleId: 'same',
        mediaTitle: 'Inception',
        mediaType: 'movie',
        hearingImpaired: false,
        sourcePageUrl: 'https://subdl.com/1',
        score: 10,
      },
      {
        provider: 'subdl',
        providerSubtitleId: 'same',
        mediaTitle: 'Inception',
        mediaType: 'movie',
        hearingImpaired: false,
        sourcePageUrl: 'https://subdl.com/1',
        score: 20,
      },
    ]);

    expect(deduped).toHaveLength(1);
    expect(deduped[0]?.score).toBe(20);
  });

  it('falls back to provider and normalized source page url when provider ids are missing', () => {
    const deduped = dedupeSubtitleSourceCandidates([
      {
        provider: 'podnapisi',
        providerSubtitleId: '',
        mediaTitle: 'Inception',
        mediaType: 'movie',
        hearingImpaired: false,
        sourcePageUrl: 'https://podnapisi.net/one',
        score: 10,
      },
      {
        provider: 'podnapisi',
        providerSubtitleId: '',
        mediaTitle: 'Inception',
        mediaType: 'movie',
        hearingImpaired: false,
        sourcePageUrl: 'https://podnapisi.net/ONE',
        score: 12,
      },
    ]);

    expect(deduped).toHaveLength(1);
    expect(deduped[0]?.score).toBe(12);
  });
});
