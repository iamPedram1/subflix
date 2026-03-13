import { SearchMediaType } from 'src/common/domain/enums/search-media-type.enum';
import { SubtitleFormat } from 'src/common/domain/enums/subtitle-format.enum';

import { CatalogMediaItem } from '../models/catalog-media-item.model';
import { CatalogSubtitleSource } from '../models/catalog-subtitle-source.model';

export const mockCatalog: CatalogMediaItem[] = [
  {
    id: 'inception',
    title: 'Inception',
    year: 2010,
    mediaType: SearchMediaType.Movie,
    synopsis:
      'A dream-hacking team tries to plant an idea before time runs out.',
    genres: ['Sci-Fi', 'Thriller'],
    runtimeMinutes: 148,
    popularity: 9.4,
  },
  {
    id: 'dune_part_two',
    title: 'Dune: Part Two',
    year: 2024,
    mediaType: SearchMediaType.Movie,
    synopsis:
      'Paul embraces destiny while balancing prophecy, power, and survival.',
    genres: ['Sci-Fi', 'Epic'],
    runtimeMinutes: 166,
    popularity: 9.6,
  },
  {
    id: 'breaking_bad',
    title: 'Breaking Bad',
    year: 2008,
    mediaType: SearchMediaType.Series,
    synopsis:
      'A chemistry teacher remakes himself through crime and consequence.',
    genres: ['Crime', 'Drama'],
    runtimeMinutes: 49,
    popularity: 9.7,
  },
  {
    id: 'severance',
    title: 'Severance',
    year: 2022,
    mediaType: SearchMediaType.Series,
    synopsis:
      'Office workers split memory and identity in a meticulous corporate mystery.',
    genres: ['Sci-Fi', 'Drama'],
    runtimeMinutes: 54,
    popularity: 9.2,
  },
  {
    id: 'interstellar',
    title: 'Interstellar',
    year: 2014,
    mediaType: SearchMediaType.Movie,
    synopsis:
      'A desperate mission leaves Earth to find a future beyond collapse.',
    genres: ['Sci-Fi', 'Adventure'],
    runtimeMinutes: 169,
    popularity: 9.5,
  },
  {
    id: 'the_bear',
    title: 'The Bear',
    year: 2022,
    mediaType: SearchMediaType.Series,
    synopsis:
      'An ambitious chef inherits a chaotic kitchen and tries to rebuild it.',
    genres: ['Drama', 'Comedy'],
    runtimeMinutes: 31,
    popularity: 8.8,
  },
  {
    id: 'blade_runner_2049',
    title: 'Blade Runner 2049',
    year: 2017,
    mediaType: SearchMediaType.Movie,
    synopsis:
      'A replicant hunter uncovers a buried secret that could rewrite the future.',
    genres: ['Sci-Fi', 'Noir'],
    runtimeMinutes: 164,
    popularity: 9.1,
  },
  {
    id: 'the_last_of_us',
    title: 'The Last of Us',
    year: 2023,
    mediaType: SearchMediaType.Series,
    synopsis:
      'Two survivors cross a fractured world where every choice costs more.',
    genres: ['Drama', 'Adventure'],
    runtimeMinutes: 58,
    popularity: 9.3,
  },
];

export const buildMockSubtitleSources = (
  mediaId: string,
): CatalogSubtitleSource[] => [
  {
    id: `${mediaId}-webdl`,
    label: 'English WEB-DL 1080p',
    releaseGroup: 'SubFlix Studio',
    format: SubtitleFormat.Srt,
    hearingImpaired: false,
    lineCount: 612,
    downloads: 24870,
    rating: 4.9,
  },
  {
    id: `${mediaId}-retail`,
    label: 'Retail Dialogue Match',
    releaseGroup: 'PrimeFrame',
    format: SubtitleFormat.Vtt,
    hearingImpaired: true,
    lineCount: 628,
    downloads: 18420,
    rating: 4.7,
  },
  {
    id: `${mediaId}-bluray`,
    label: 'BluRay Scene Sync',
    releaseGroup: 'Cinema Core',
    format: SubtitleFormat.Srt,
    hearingImpaired: false,
    lineCount: 598,
    downloads: 12670,
    rating: 4.6,
  },
];
