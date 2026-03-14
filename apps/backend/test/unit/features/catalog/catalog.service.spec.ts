import { AppCacheService } from 'src/common/cache/app-cache.service';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { MediaCatalogPort } from 'src/features/catalog/ports/media-catalog.port';
import { SubtitleCuePort } from 'src/features/catalog/ports/subtitle-cue.port';
import { SubtitleSourceDiscoveryService } from 'src/features/catalog/subtitle-source-discovery.service';

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
    const subtitleCuePort = {
      getSubtitleCues: vi.fn(),
    } as unknown as SubtitleCuePort;

    const service = new CatalogService(
      cacheService,
      {} as SubtitleSourceDiscoveryService,
      mediaCatalogPort,
      subtitleCuePort,
    );

    await service.search(' Dune ');

    expect(cacheService.getOrSet).not.toHaveBeenCalled();
    expect(mediaCatalogPort.search).toHaveBeenCalledWith('dune');
  });

  it('caches subtitle cues per media and source combination', async () => {
    const cacheService = createCacheService();
    const subtitleCuePort = {
      getSubtitleCues: vi.fn().mockResolvedValue([]),
    } as unknown as SubtitleCuePort;

    const service = new CatalogService(
      cacheService,
      {} as SubtitleSourceDiscoveryService,
      {} as MediaCatalogPort,
      subtitleCuePort,
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
      {} as SubtitleSourceDiscoveryService,
      mediaCatalogPort,
      {} as SubtitleCuePort,
    );

    await service.findById('movie_157336');

    expect(cacheService.getOrSet).not.toHaveBeenCalled();
    expect(mediaCatalogPort.findById).toHaveBeenCalledWith('movie_157336');
  });
});
