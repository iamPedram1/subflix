import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { load } from 'cheerio';

import {
  CatalogSubtitleFileProvider,
  DownloadSubtitleFileInput,
  DownloadedSubtitlePayload,
} from 'features/catalog/ports/catalog-subtitle-file-provider.port';
import { fetchWithTimeout } from 'features/catalog/utils/provider-fetch.util';
import {
  assertLooksLikeBinarySubtitleResponse,
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
export class PodnapisiSubtitleFileProvider implements CatalogSubtitleFileProvider {
  readonly provider = 'podnapisi' as const;

  constructor(private readonly configService: ConfigService) {}

  async downloadSubtitleFile(
    input: DownloadSubtitleFileInput,
  ): Promise<DownloadedSubtitlePayload> {
    const baseUrl =
      this.configService.get<string>('subtitleSources.podnapisi.baseUrl') ??
      'https://www.podnapisi.net';
    const timeoutMs =
      this.configService.get<number>('subtitleSources.podnapisi.timeoutMs') ??
      10_000;

    const pageUrl = new URL(
      `/en/subtitles/${encodeURIComponent(input.providerSubtitleId)}`,
      baseUrl,
    );
    const pageResponse = await fetchWithTimeout(pageUrl.toString(), {
      timeoutMs,
      headers: {
        Accept:
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      },
    });

    if (!pageResponse.ok) {
      throw new Error(
        `Podnapisi page request failed with status ${pageResponse.status}.`,
      );
    }

    const html = await pageResponse.text();
    const downloadUrl = resolveDownloadUrlFromPage(html, pageUrl);
    if (!downloadUrl) {
      throw new Error('Podnapisi download link was not found.');
    }

    const downloadResponse = await fetchWithTimeout(downloadUrl.toString(), {
      timeoutMs,
      headers: {
        Accept: '*/*',
      },
    });

    if (!downloadResponse.ok) {
      throw new Error(
        `Podnapisi download request failed with status ${downloadResponse.status}.`,
      );
    }

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
