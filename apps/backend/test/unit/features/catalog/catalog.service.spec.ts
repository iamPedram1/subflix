import { AppCacheService } from 'src/common/cache/app-cache.service';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { MediaCatalogPort } from 'src/features/catalog/ports/media-catalog.port';
import { SubtitleSourcePort } from 'src/features/catalog/ports/subtitle-source.port';

describe('CatalogService', () => {
  const createCacheService = () =>
    ({
      getOrSet: vi.fn(async (_key, loader: () => Promise<unknown>) => loader()),
    }) as unknown as AppCacheService;

  it('normalizes search queries before delegating to the media provider', async () => {
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

    expect(cacheService.getOrSet).not.toHaveBeenCalled();
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

  it('delegates findById directly to the media provider', async () => {
    const cacheService = createCacheService();
    const mediaCatalogPort = {
      search: vi.fn(),
      findById: vi.fn().mockResolvedValue(null),
    } as unknown as MediaCatalogPort;

    const service = new CatalogService(
      cacheService,
      mediaCatalogPort,
      {} as SubtitleSourcePort,
    );

    await service.findById('movie_157336');

    expect(cacheService.getOrSet).not.toHaveBeenCalled();
    expect(mediaCatalogPort.findById).toHaveBeenCalledWith('movie_157336');
  });
});
