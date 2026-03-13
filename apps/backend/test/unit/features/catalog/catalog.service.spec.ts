import { AppCacheService } from 'src/common/cache/app-cache.service';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { MediaCatalogPort } from 'src/features/catalog/ports/media-catalog.port';
import { SubtitleSourcePort } from 'src/features/catalog/ports/subtitle-source.port';

describe('CatalogService', () => {
  const createCacheService = () =>
    ({
      getOrSet: vi.fn(async (_key, loader: () => Promise<unknown>) => loader()),
    }) as unknown as AppCacheService;

  it('reuses the normalized search cache key for equivalent queries', async () => {
    const cacheService = createCacheService();
    const mediaCatalogPort = {
      search: vi.fn().mockResolvedValue([]),
      findById: vi.fn(),
    } as unknown as MediaCatalogPort;
    const subtitleSourcePort = {
      getSubtitleSources: vi.fn(),
      getSubtitleCues: vi.fn(),
    } as unknown as SubtitleSourcePort;

    const service = new CatalogService(
      cacheService,
      mediaCatalogPort,
      subtitleSourcePort,
    );

    await service.search(' Dune ');

    expect(cacheService.getOrSet).toHaveBeenCalledWith(
      'catalog:search:dune',
      expect.any(Function),
      expect.objectContaining({
        ttlMs: 5 * 60_000,
      }),
    );
    expect(mediaCatalogPort.search).toHaveBeenCalledWith('dune');
  });

  it('caches subtitle cues per media and source combination', async () => {
    const cacheService = createCacheService();
    const subtitleSourcePort = {
      getSubtitleSources: vi.fn(),
      getSubtitleCues: vi.fn().mockResolvedValue([]),
    } as unknown as SubtitleSourcePort;

    const service = new CatalogService(
      cacheService,
      {} as MediaCatalogPort,
      subtitleSourcePort,
    );

    await service.getSubtitleCues('inception', 'webdl');

    expect(cacheService.getOrSet).toHaveBeenCalledWith(
      'catalog:cues:inception:webdl',
      expect.any(Function),
      expect.objectContaining({
        ttlMs: 30 * 60_000,
      }),
    );
  });
});
