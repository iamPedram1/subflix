const parseContentDispositionFilename = (
  headerValue: string | null,
): string | undefined => {
  if (!headerValue) {
    return undefined;
  }

  // Basic RFC 6266 handling for "filename=" and "filename*=".
  const filenameStar = headerValue.match(
    /filename\*\s*=\s*UTF-8''([^;]+)/i,
  )?.[1];
  if (filenameStar) {
    try {
      return decodeURIComponent(filenameStar.trim().replace(/^"|"$/g, ''));
    } catch {
      return filenameStar.trim().replace(/^"|"$/g, '');
    }
  }

  const filename = headerValue.match(/filename\s*=\s*([^;]+)/i)?.[1];
  if (!filename) {
    return undefined;
  }

  return filename.trim().replace(/^"|"$/g, '');
};

export const readDownloadFilename = (
  response: Response,
): string | undefined => {
  return parseContentDispositionFilename(
    response.headers.get('content-disposition'),
  );
};

export const assertLooksLikeBinarySubtitleResponse = async (
  response: Response,
): Promise<void> => {
  const contentType = response.headers.get('content-type')?.toLowerCase() ?? '';
  if (
    contentType.includes('text/html') ||
    contentType.includes('application/xhtml+xml')
  ) {
    throw new Error('Provider returned HTML instead of a subtitle download.');
  }

  // Some providers may return "text/plain" for subtitles. Allow it.
  if (!contentType.length) {
    return;
  }

  if (
    contentType.includes('application/json') ||
    contentType.includes('application/xml')
  ) {
    throw new Error('Provider returned an unexpected payload type.');
  }
};

export const readResponseBuffer = async (
  response: Response,
  options?: { maxBytes?: number },
): Promise<Buffer> => {
  const maxBytes = options?.maxBytes ?? 5 * 1024 * 1024;
  const contentLength = Number(response.headers.get('content-length') ?? NaN);
  if (Number.isFinite(contentLength) && contentLength > maxBytes) {
    throw new Error('Subtitle download exceeds the maximum allowed size.');
  }

  const arrayBuffer = await response.arrayBuffer();
  const buffer = Buffer.from(arrayBuffer);
  if (buffer.length > maxBytes) {
    throw new Error('Subtitle download exceeds the maximum allowed size.');
  }

  return buffer;
};

export const assertNotHtmlPayload = (bytes: Buffer): void => {
  const head = bytes.slice(0, 1024).toString('utf8').toLowerCase();
  if (head.includes('<html') || head.includes('<!doctype html')) {
    throw new Error('Provider returned HTML instead of a subtitle download.');
  }
};
