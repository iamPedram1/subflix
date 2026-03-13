import { SearchMediaType } from 'src/common/domain/enums/search-media-type.enum';
import { SubtitleFormat } from 'src/common/domain/enums/subtitle-format.enum';
import { SubtitleCue } from 'src/features/subtitles/models/subtitle-cue.model';

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

const cueLibrary: Record<string, string[]> = {
  inception: [
    'You must not be afraid to dream a little bigger.',
    'We only have one clean pass at this idea.',
    'If the kick misses, we stay down there.',
    'Keep your eyes on the totem.',
    'We wake up when the van hits the water.',
  ],
  dune_part_two: [
    'The desert does not forgive hesitation.',
    'Power is moving faster than prophecy.',
    'The south is ready, but not patient.',
    'Every banner here is waiting for a decision.',
    'Tonight decides whether legend becomes war.',
  ],
  breaking_bad: [
    'Chemistry is the study of transformation.',
    'No more half measures.',
    'We are running out of clean exits.',
    'This family is already paying the price.',
    'The next move changes everything.',
  ],
  severance: [
    'Your outie approved this procedure.',
    'The numbers matter, even if you do not know why.',
    'Every corridor here is designed to make you comply.',
    'This file should never have reached your desk.',
    'The board will ask for a cleaner explanation.',
  ],
};

export const buildMockSubtitleCues = (mediaId: string): SubtitleCue[] => {
  const lines = cueLibrary[mediaId] ?? [
    'Keep the channel open until I say otherwise.',
    'The file moves at sunrise, not before.',
    'Every second of silence matters right now.',
    'We only get one version of this conversation.',
    'Make sure the handoff looks invisible.',
  ];

  return lines.map((text, index) => ({
    cueIndex: index + 1,
    startMs: 1_000 + index * 3_000,
    endMs: 3_200 + index * 3_000,
    text,
  }));
};
