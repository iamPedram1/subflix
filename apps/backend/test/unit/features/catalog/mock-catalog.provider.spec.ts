import { MockCatalogProvider } from 'src/features/catalog/providers/mock-catalog.provider';

describe('MockCatalogProvider', () => {
  let provider: MockCatalogProvider;

  beforeEach(() => {
    provider = new MockCatalogProvider();
  });

  it('filters catalog titles by query', async () => {
    const results = await provider.search('dune');

    expect(results).toHaveLength(1);
    expect(results[0]?.id).toBe('dune_part_two');
  });

  it('throws a controlled error for failing search terms', async () => {
    await expect(provider.search('error')).rejects.toMatchObject({
      code: 'service_unavailable',
    });
  });
});
