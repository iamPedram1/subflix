import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { load } from 'cheerio';

import {
  CatalogSubtitleFileProvider,
  DownloadSubtitleFileInput,
  DownloadedSubtitlePayload,
} from 'features/catalog/ports/catalog-subtitle-file-provider.port';
import {
  fetchWithTimeout,
  readResponseText,
} from 'features/catalog/utils/provider-fetch.util';
import {
  assertLooksLikeBinarySubtitleResponse,
  assertAllowedDownloadUrl,
  assertNotHtmlPayload,
  readDownloadFilename,
  readResponseBuffer,
} from 'features/catalog/utils/subtitle-download.util';

const resolveDownloadUrlFromPage = (html: string, pageUrl: URL): URL | null => {
  const $ = load(html);
  const candidates = $('a')
    .toArray()
    .map((node) => $(node).attr('href')?.trim())
    .filter((href): href is string => Boolean(href && href.length));

  const direct = candidates.find((href) =>
    /\.(zip|srt|vtt)(\?.*)?$/i.test(href),
  );
  if (direct) {
    return new URL(direct, pageUrl);
  }

  const download = candidates.find((href) => /download/i.test(href));
  if (download) {
    return new URL(download, pageUrl);
  }

  return null;
};

@Injectable()
export class TvSubsSubtitleFileProvider implements CatalogSubtitleFileProvider {
  readonly provider = 'tvsubs' as const;

  constructor(private readonly configService: ConfigService) {}

  async downloadSubtitleFile(
    input: DownloadSubtitleFileInput,
  ): Promise<DownloadedSubtitlePayload> {
    const baseUrl =
      this.configService.get<string>('subtitleSources.tvsubs.baseUrl') ??
      'https://www.tvsubtitles.net';
    const timeoutMs =
      this.configService.get<number>('subtitleSources.tvsubs.timeoutMs') ??
      10_000;

    const pageUrl = new URL(
      `/subtitle-${encodeURIComponent(input.providerSubtitleId)}.html`,
      baseUrl,
    );
    const pageResponse = await fetchWithTimeout(pageUrl.toString(), {
      timeoutMs,
      maxRedirects:
        this.configService.get<number>('subtitleSources.maxRedirects') ?? 3,
      validateRedirectUrl: ({ redirectUrl }) => {
        assertAllowedDownloadUrl(redirectUrl, pageUrl);
      },
      headers: {
        Accept:
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      },
    });

    if (!pageResponse.ok) {
      throw new Error(
        `TVSubs page request failed with status ${pageResponse.status}.`,
      );
    }

    const html = await readResponseText(pageResponse, {
      maxBytes:
        this.configService.get<number>('subtitleSources.pageMaxBytes') ??
        512 * 1024,
      tooLargeMessage: 'Subtitle provider page exceeds the maximum allowed size.',
    });
    const downloadUrl = resolveDownloadUrlFromPage(html, pageUrl);
    if (!downloadUrl) {
      throw new Error('TVSubs download link was not found.');
    }
    assertAllowedDownloadUrl(downloadUrl, pageUrl);

    const downloadResponse = await fetchWithTimeout(downloadUrl.toString(), {
      timeoutMs,
      maxRedirects:
        this.configService.get<number>('subtitleSources.maxRedirects') ?? 3,
      validateRedirectUrl: ({ redirectUrl }) => {
        assertAllowedDownloadUrl(redirectUrl, pageUrl);
      },
      headers: {
        Accept: '*/*',
      },
    });

    if (!downloadResponse.ok) {
      throw new Error(
        `TVSubs download request failed with status ${downloadResponse.status}.`,
      );
    }
    assertAllowedDownloadUrl(new URL(downloadResponse.url), pageUrl);

    await assertLooksLikeBinarySubtitleResponse(downloadResponse);

    const bytes = await readResponseBuffer(downloadResponse, {
      maxBytes:
        this.configService.get<number>('subtitleSources.downloadMaxBytes') ??
        5 * 1024 * 1024,
    });
    assertNotHtmlPayload(bytes);
    const fileName =
      readDownloadFilename(downloadResponse) ??
      downloadUrl.pathname.split('/').at(-1) ??
      undefined;

    return {
      sourceUrl: downloadUrl.toString(),
      fileName,
      contentType: downloadResponse.headers.get('content-type') ?? undefined,
      bytes,
    };
  }
}
