import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { load } from 'cheerio';

import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import { SubtitleSourceProvider } from 'features/catalog/ports/subtitle-source-provider.port';
import { fetchWithTimeout } from 'features/catalog/utils/provider-fetch.util';

const normalizeLanguageCode = (value: string): string => {
  return value.trim().toLowerCase().replace(/_/g, '-');
};

const normalizeRating = (value: string | undefined): number => {
  const percent = Number(value?.match(/([\d.]+)%/)?.[1] ?? Number.NaN);
  if (!Number.isFinite(percent)) {
    return 0;
  }

  return Math.max(0, Math.min(5, Number((percent / 20).toFixed(1))));
};

@Injectable()
export class PodnapisiSubtitleSourceProvider implements SubtitleSourceProvider {
  readonly name = 'podnapisi' as const;

  constructor(private readonly configService: ConfigService) {}

  async searchSources(
    input: SubtitleSourceSearchInput,
  ): Promise<SubtitleSourceCandidate[]> {
    const baseUrl =
      this.configService.get<string>('subtitleSources.podnapisi.baseUrl') ??
      'https://www.podnapisi.net';
    const url = new URL('/en/subtitles/search/', baseUrl);
    url.searchParams.set('keywords', this.buildKeywords(input));
    url.searchParams.set(
      'language',
      input.preferredLanguage.split(/[-_]/, 1)[0] ?? input.preferredLanguage,
    );

    if (input.year !== undefined) {
      url.searchParams.set('year', String(input.year));
    }

    const response = await fetchWithTimeout(url.toString(), {
      timeoutMs:
        this.configService.get<number>('subtitleSources.podnapisi.timeoutMs') ??
        10_000,
    });

    if (!response.ok) {
      throw new Error(
        `Podnapisi request failed with status ${response.status}.`,
      );
    }

    const html = await response.text();
    const $ = load(html);
    const rows = $('tr.subtitle-entry');
    if (!rows.length) {
      return [];
    }

    const candidates: Array<SubtitleSourceCandidate | null> = rows
      .toArray()
      .map((row) => {
        const entry = $(row);
        const href = entry.attr('data-href')?.trim();
        if (!href) {
          return null;
        }

        const columns = entry.find('td');
        const pageLink = entry.find('a[alt="Subtitles\' page"]').first();
        const titleText = pageLink.text().trim();
        const year = Number(titleText.match(/\((\d{4})\)/)?.[1] ?? Number.NaN);
        const releaseName = entry.find('span.release').first().text().trim();
        const languageElement = columns.eq(3).find('abbr').first();
        const languageCode = normalizeLanguageCode(
          languageElement.text() || input.preferredLanguage,
        );
        const languageName =
          languageElement.attr('data-title')?.trim() ||
          languageElement.attr('title')?.trim();
        const providerSubtitleId = href.split('/').at(-1)?.trim();
        if (!providerSubtitleId) {
          return null;
        }

        return {
          provider: this.name,
          providerSubtitleId,
          mediaTitle:
            titleText.replace(/\s*\(\d{4}\)\s*/, '').trim() || input.title,
          mediaType: input.mediaType,
          year: Number.isFinite(year) ? year : input.year,
          seasonNumber: input.seasonNumber,
          episodeNumber: input.episodeNumber,
          languageCode,
          languageName,
          releaseName: releaseName || titleText,
          releaseGroup: undefined,
          format: this.detectFormat(releaseName, href),
          lineCount: undefined,
          hearingImpaired: entry.find('.fa-cc').length > 0,
          downloadCount: this.parseNumber(columns.eq(5).text()),
          providerRating: normalizeRating(
            columns.eq(7).find('.progress.rating').attr('data-title'),
          ),
          uploader: columns.eq(4).text().trim() || undefined,
          sourcePageUrl: new URL(href, baseUrl).toString(),
          score: 0,
        } satisfies SubtitleSourceCandidate;
      });

    return candidates.filter(
      (candidate): candidate is SubtitleSourceCandidate => candidate !== null,
    );
  }

  private buildKeywords(input: SubtitleSourceSearchInput): string {
    if (input.mediaType === 'tv' && input.seasonNumber && input.episodeNumber) {
      return `${input.originalTitle ?? input.title} S${String(input.seasonNumber).padStart(2, '0')}E${String(input.episodeNumber).padStart(2, '0')}`;
    }

    return input.originalTitle ?? input.title;
  }

  private parseNumber(value: string): number | undefined {
    const parsed = Number(value.trim());
    return Number.isFinite(parsed) ? parsed : undefined;
  }

  private detectFormat(releaseName: string, href: string): SubtitleFormat {
    const combined = `${releaseName} ${href}`.toLowerCase();
    return combined.includes('.vtt') ? SubtitleFormat.Vtt : SubtitleFormat.Srt;
  }
}
