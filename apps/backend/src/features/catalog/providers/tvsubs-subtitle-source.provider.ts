import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { load } from 'cheerio';

import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import { SubtitleSourceProvider } from 'features/catalog/ports/subtitle-source-provider.port';
import {
  fetchWithTimeout,
  readResponseText,
} from 'features/catalog/utils/provider-fetch.util';
import { assertAllowedDownloadUrl } from 'features/catalog/utils/subtitle-download.util';

type TvShowMatch = {
  href: string;
  title: string;
  yearStart?: number;
};

const normalize = (value: string): string =>
  value
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, ' ');

@Injectable()
export class TvSubsSubtitleSourceProvider implements SubtitleSourceProvider {
  readonly name = 'tvsubs' as const;

  constructor(private readonly configService: ConfigService) {}

  async searchSources(
    input: SubtitleSourceSearchInput,
  ): Promise<SubtitleSourceCandidate[]> {
    if (
      input.mediaType !== 'tv' ||
      input.seasonNumber === undefined ||
      input.episodeNumber === undefined
    ) {
      return [];
    }

    const baseUrl =
      this.configService.get<string>('subtitleSources.tvsubs.baseUrl') ??
      'https://www.tvsubtitles.net';
    const searchResponse = await fetchWithTimeout(
      new URL('/search.php', baseUrl).toString(),
      {
        method: 'POST',
        body: new URLSearchParams({
          qs: input.originalTitle ?? input.title,
        }),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        timeoutMs:
          this.configService.get<number>('subtitleSources.tvsubs.timeoutMs') ??
          10_000,
        maxRedirects:
          this.configService.get<number>('subtitleSources.maxRedirects') ?? 3,
        validateRedirectUrl: ({ redirectUrl }) => {
          assertAllowedDownloadUrl(redirectUrl, new URL(baseUrl));
        },
      },
    );

    if (!searchResponse.ok) {
      throw new Error(
        `TVSubs request failed with status ${searchResponse.status}.`,
      );
    }

    const searchHtml = await readResponseText(searchResponse, {
      maxBytes:
        this.configService.get<number>('subtitleSources.pageMaxBytes') ??
        512 * 1024,
      tooLargeMessage: 'Subtitle provider page exceeds the maximum allowed size.',
    });
    const show = this.selectBestShow(searchHtml, input);
    if (!show) {
      return [];
    }

    const seasonResponse = await fetchWithTimeout(
      new URL(
        show.href.replace(
          /tvshow-(\d+)\.html$/,
          `tvshow-$1-${input.seasonNumber}.html`,
        ),
        baseUrl,
      ).toString(),
      {
        timeoutMs:
          this.configService.get<number>('subtitleSources.tvsubs.timeoutMs') ??
          10_000,
        maxRedirects:
          this.configService.get<number>('subtitleSources.maxRedirects') ?? 3,
        validateRedirectUrl: ({ redirectUrl }) => {
          assertAllowedDownloadUrl(redirectUrl, new URL(baseUrl));
        },
      },
    );

    if (!seasonResponse.ok) {
      throw new Error(
        `TVSubs season request failed with status ${seasonResponse.status}.`,
      );
    }

    return this.parseSeasonPage(
      await readResponseText(seasonResponse, {
        maxBytes:
          this.configService.get<number>('subtitleSources.pageMaxBytes') ??
          512 * 1024,
        tooLargeMessage:
          'Subtitle provider page exceeds the maximum allowed size.',
      }),
      input,
      baseUrl,
      show,
    );
  }

  private selectBestShow(
    html: string,
    input: SubtitleSourceSearchInput,
  ): TvShowMatch | null {
    const $ = load(html);
    const matches: Array<TvShowMatch | null> = $(
      'div.left_articles li a[href^="/tvshow-"]',
    )
      .toArray()
      .map((anchor) => {
        const element = $(anchor);
        const href = element.attr('href');
        const text = element.text().trim();
        if (!href || !text.length) {
          return null;
        }

        const yearMatch = text.match(/\((\d{4})(?:-(\d{4}))?\)$/);
        return {
          href,
          title: text.replace(/\s*\(\d{4}(?:-\d{4})?\)\s*$/, '').trim(),
          yearStart: yearMatch ? Number(yearMatch[1]) : undefined,
        } satisfies TvShowMatch;
      });

    const filteredMatches = matches.filter(
      (match): match is TvShowMatch => match !== null,
    );

    if (!filteredMatches.length) {
      return null;
    }

    const normalizedTarget = normalize(input.originalTitle ?? input.title);
    return (
      filteredMatches.find(
        (match) => normalize(match.title) === normalizedTarget,
      ) ??
      filteredMatches.find((match) =>
        normalize(match.title).includes(normalizedTarget),
      ) ??
      null
    );
  }

  private parseSeasonPage(
    html: string,
    input: SubtitleSourceSearchInput,
    baseUrl: string,
    show: TvShowMatch,
  ): SubtitleSourceCandidate[] {
    const $ = load(html);
    const episodeRows = $('table#table5 tr[bgcolor="#ffffff"]');
    if (!episodeRows.length) {
      return [];
    }

    const episodeCode = `${input.seasonNumber}x${String(input.episodeNumber).padStart(2, '0')}`;
    const matches: SubtitleSourceCandidate[] = [];

    for (const row of episodeRows.toArray()) {
      const entry = $(row);
      const rowCells = entry.find('td');
      const rowEpisodeCode = rowCells.eq(0).text().trim();
      if (rowEpisodeCode !== episodeCode) {
        continue;
      }

      const episodeTitle = rowCells.eq(1).text().trim() || show.title;
      const links = rowCells
        .eq(3)
        .find('a[href*="subtitle-"]')
        .toArray()
        .map((anchor) => {
          const element = $(anchor);
          const href = element.attr('href')?.trim();
          const flag = element.find('img').attr('alt')?.trim();
          return { href, flag };
        })
        .filter(
          (
            item,
          ): item is {
            href: string;
            flag: string;
          } => Boolean(item.href && item.flag),
        )
        .filter(
          (item) =>
            item.flag.toLowerCase() === input.preferredLanguage.toLowerCase(),
        );

      for (const link of links) {
        const providerSubtitleId = link.href.match(
          /subtitle-(\d+)\.html$/,
        )?.[1];
        if (!providerSubtitleId) {
          continue;
        }

        matches.push({
          provider: this.name,
          providerSubtitleId,
          mediaTitle: show.title,
          mediaType: 'tv',
          year: show.yearStart ?? input.year,
          seasonNumber: input.seasonNumber,
          episodeNumber: input.episodeNumber,
          languageCode: link.flag.toLowerCase(),
          languageName: link.flag.toUpperCase(),
          releaseName: episodeTitle,
          releaseGroup: undefined,
          format: SubtitleFormat.Srt,
          lineCount: undefined,
          hearingImpaired: false,
          downloadCount: undefined,
          providerRating: 0,
          uploader: undefined,
          sourcePageUrl: new URL(link.href, baseUrl).toString(),
          score: 0,
        });
      }
    }

    return matches;
  }
}
