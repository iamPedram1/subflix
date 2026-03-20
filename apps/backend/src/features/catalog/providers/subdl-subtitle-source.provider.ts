import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import { SubtitleSourceProvider } from 'features/catalog/ports/subtitle-source-provider.port';
import {
  fetchWithTimeout,
  readResponseJson,
} from 'features/catalog/utils/provider-fetch.util';

type SubdlResponse = {
  status?: boolean;
  statusCode?: number;
  subtitles?: unknown[];
  results?: unknown[];
  message?: string;
};

type SubtitleRecord = Record<string, unknown>;

const toRecord = (value: unknown): SubtitleRecord =>
  typeof value === 'object' && value !== null ? (value as SubtitleRecord) : {};

const readString = (
  record: SubtitleRecord,
  keys: string[],
): string | undefined => {
  for (const key of keys) {
    const value = record[key];
    if (typeof value === 'string' && value.trim().length > 0) {
      return value.trim();
    }
  }

  return undefined;
};

const readNumber = (
  record: SubtitleRecord,
  keys: string[],
): number | undefined => {
  for (const key of keys) {
    const value = record[key];
    const parsed =
      typeof value === 'number'
        ? value
        : typeof value === 'string'
          ? Number(value)
          : Number.NaN;
    if (Number.isFinite(parsed)) {
      return parsed;
    }
  }

  return undefined;
};

const readBoolean = (record: SubtitleRecord, keys: string[]): boolean => {
  for (const key of keys) {
    const value = record[key];
    if (typeof value === 'boolean') {
      return value;
    }

    if (typeof value === 'number') {
      return value > 0;
    }

    if (typeof value === 'string') {
      const normalized = value.trim().toLowerCase();
      if (['1', 'true', 'yes'].includes(normalized)) {
        return true;
      }

      if (['0', 'false', 'no'].includes(normalized)) {
        return false;
      }
    }
  }

  return false;
};

const normalizeSubdlLanguageCode = (language: string): string => {
  const normalized = language.trim().replace(/-/g, '_').toUpperCase();

  if (normalized === 'PT_BR') {
    return 'BR_PT';
  }

  return normalized;
};

const toPublicLanguageCode = (
  value: string | undefined,
): string | undefined => {
  if (!value) {
    return undefined;
  }

  return value.trim().toLowerCase().replace(/_/g, '-');
};

const normalizeRating = (value: number | undefined): number => {
  const safeValue = value ?? Number.NaN;
  if (!Number.isFinite(safeValue)) {
    return 0;
  }

  return Math.max(0, Math.min(5, safeValue > 5 ? safeValue / 20 : safeValue));
};

@Injectable()
export class SubdlSubtitleSourceProvider implements SubtitleSourceProvider {
  readonly name = 'subdl' as const;

  constructor(private readonly configService: ConfigService) {}

  async searchSources(
    input: SubtitleSourceSearchInput,
  ): Promise<SubtitleSourceCandidate[]> {
    const apiKey = this.configService
      .get<string>('subtitleSources.subdl.apiKey')
      ?.trim();
    if (!apiKey?.length) {
      throw new Error('SubDL API key is not configured.');
    }

    const url = new URL(
      `${this.configService.get<string>('subtitleSources.subdl.apiBaseUrl') ?? 'https://api.subdl.com/api/v1'}/subtitles`,
    );
    url.searchParams.set('api_key', apiKey);
    url.searchParams.set(
      'languages',
      normalizeSubdlLanguageCode(input.preferredLanguage),
    );
    url.searchParams.set('type', input.mediaType);

    if (input.tmdbId !== undefined) {
      url.searchParams.set('tmdb_id', String(input.tmdbId));
    }

    if (input.imdbId) {
      url.searchParams.set('imdb_id', input.imdbId);
    }

    if (input.seasonNumber !== undefined) {
      url.searchParams.set('season_number', String(input.seasonNumber));
    }

    if (input.episodeNumber !== undefined) {
      url.searchParams.set('episode_number', String(input.episodeNumber));
    }

    if (input.year !== undefined) {
      url.searchParams.set('year', String(input.year));
    }

    if (!input.tmdbId && !input.imdbId) {
      url.searchParams.set('film_name', input.originalTitle ?? input.title);
    }

    const response = await fetchWithTimeout(url.toString(), {
      timeoutMs:
        this.configService.get<number>('subtitleSources.subdl.timeoutMs') ??
        7_000,
      maxRedirects:
        this.configService.get<number>('subtitleSources.maxRedirects') ?? 3,
      headers: {
        Accept: 'application/json',
      },
    });

    if (!response.ok) {
      throw new Error(`SubDL request failed with status ${response.status}.`);
    }

    const payload = await readResponseJson<SubdlResponse>(response, {
      maxBytes:
        this.configService.get<number>('subtitleSources.apiResponseMaxBytes') ??
        512 * 1024,
      tooLargeMessage: 'Subtitle provider response exceeds the maximum allowed size.',
      invalidJsonMessage: 'Subtitle provider returned invalid JSON.',
    });
    if (payload.status === false || (payload.statusCode ?? 200) >= 400) {
      throw new Error(
        payload.message ?? 'SubDL returned a non-success response.',
      );
    }

    const rawResults = payload.subtitles ?? payload.results ?? [];
    return rawResults
      .map((item) => this.toCandidate(toRecord(item), input))
      .filter(
        (candidate): candidate is SubtitleSourceCandidate => candidate !== null,
      );
  }

  private toCandidate(
    item: SubtitleRecord,
    input: SubtitleSourceSearchInput,
  ): SubtitleSourceCandidate | null {
    const providerSubtitleId =
      readString(item, ['subtitle_id', 'id', 'sd_id']) ??
      readString(item, ['url', 'page', 'detail_url']);
    if (!providerSubtitleId) {
      return null;
    }

    const mediaTitle =
      readString(item, ['movie_name', 'title', 'film_name', 'name']) ??
      input.title;
    const releaseName = readString(item, [
      'release_name',
      'release',
      'file_name',
      'subtitle_name',
      'name',
    ]);
    const languageCode = toPublicLanguageCode(
      readString(item, ['language', 'lang', 'language_code']),
    );
    const sourcePageUrl =
      readString(item, ['url', 'page', 'detail_url']) ??
      `https://subdl.com/subtitle/${encodeURIComponent(providerSubtitleId)}`;

    return {
      provider: this.name,
      providerSubtitleId,
      mediaTitle,
      mediaType: input.mediaType,
      year:
        readNumber(item, ['year', 'release_year', 'from_year']) ?? input.year,
      seasonNumber:
        readNumber(item, ['season_number', 'season']) ?? input.seasonNumber,
      episodeNumber:
        readNumber(item, ['episode_number', 'episode']) ?? input.episodeNumber,
      languageCode,
      languageName: readString(item, ['language_name', 'lang_name']),
      releaseName,
      releaseGroup: readString(item, ['release_group']),
      format: this.detectFormat(releaseName, sourcePageUrl),
      lineCount: readNumber(item, ['line_count', 'lines']),
      hearingImpaired: readBoolean(item, [
        'hearing_impaired',
        'hi',
        'is_hearing_impaired',
      ]),
      downloadCount: readNumber(item, ['downloads', 'download_count']),
      providerRating: normalizeRating(readNumber(item, ['rating', 'score'])),
      uploader: readString(item, ['uploader', 'author', 'uploaded_by']),
      sourcePageUrl,
      score: 0,
      tmdbId: input.tmdbId,
      imdbId: input.imdbId,
    };
  }

  private detectFormat(
    releaseName: string | undefined,
    sourcePageUrl: string,
  ): SubtitleFormat {
    const combined = `${releaseName ?? ''} ${sourcePageUrl}`.toLowerCase();
    return combined.includes('.vtt') || combined.includes('webvtt')
      ? SubtitleFormat.Vtt
      : SubtitleFormat.Srt;
  }
}
