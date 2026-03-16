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
  assertAllowedDownloadUrl,
  assertNotHtmlPayload,
  readDownloadFilename,
  readResponseBuffer,
} from 'features/catalog/utils/subtitle-download.util';

const SUBDL_HOST_ALLOWLIST = new Set(['subdl.com', 'www.subdl.com']);

const asUrl = (value: string): URL | null => {
  try {
    return new URL(value);
  } catch {
    return null;
  }
};

const isAllowedSubdlUrl = (url: URL): boolean => {
  return url.protocol === 'https:' && SUBDL_HOST_ALLOWLIST.has(url.hostname);
};

const buildSubdlPageUrl = (providerSubtitleId: string): URL => {
  const maybeUrl = asUrl(providerSubtitleId);
  if (maybeUrl) {
    if (!isAllowedSubdlUrl(maybeUrl)) {
      throw new Error('SubDL subtitle source URL is not allowed.');
    }
    return maybeUrl;
  }

  return new URL(
    `/subtitle/${encodeURIComponent(providerSubtitleId)}`,
    'https://subdl.com',
  );
};

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
export class SubdlSubtitleFileProvider implements CatalogSubtitleFileProvider {
  readonly provider = 'subdl' as const;

  constructor(private readonly configService: ConfigService) {}

  async downloadSubtitleFile(
    input: DownloadSubtitleFileInput,
  ): Promise<DownloadedSubtitlePayload> {
    const pageUrl = buildSubdlPageUrl(input.providerSubtitleId);
    const timeoutMs =
      this.configService.get<number>('subtitleSources.subdl.timeoutMs') ??
      7_000;

    const pageResponse = await fetchWithTimeout(pageUrl.toString(), {
      timeoutMs,
      headers: {
        Accept:
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      },
    });

    if (!pageResponse.ok) {
      throw new Error(
        `SubDL page request failed with status ${pageResponse.status}.`,
      );
    }

    const html = await pageResponse.text();
    const downloadUrl = resolveDownloadUrlFromPage(html, pageUrl);
    if (!downloadUrl) {
      throw new Error('SubDL download link was not found.');
    }
    assertAllowedDownloadUrl(downloadUrl, pageUrl);

    const downloadResponse = await fetchWithTimeout(downloadUrl.toString(), {
      timeoutMs,
      headers: {
        Accept: '*/*',
      },
    });

    if (!downloadResponse.ok) {
      throw new Error(
        `SubDL download request failed with status ${downloadResponse.status}.`,
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
