type RedirectValidationContext = {
  currentUrl: URL;
  redirectUrl: URL;
};

type FetchWithTimeoutOptions = {
  method?: string;
  body?: URLSearchParams;
  headers?: HeadersInit;
  timeoutMs: number;
  maxRedirects?: number;
  validateRedirectUrl?: (
    context: RedirectValidationContext,
  ) => void | Promise<void>;
};

type LimitedReadOptions = {
  maxBytes: number;
  tooLargeMessage: string;
};

const DEFAULT_HEADERS: HeadersInit = {
  Accept:
    'text/html,application/xhtml+xml,application/xml;q=0.9,application/json;q=0.8,*/*;q=0.7',
  'Accept-Language': 'en-US,en;q=0.9',
  'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
};

const REDIRECT_STATUSES = new Set([301, 302, 303, 307, 308]);

const shouldRewriteToGet = (status: number, method: string): boolean => {
  const normalizedMethod = method.toUpperCase();
  return (
    status === 303 ||
    ((status === 301 || status === 302) && normalizedMethod === 'POST')
  );
};

const defaultValidateRedirectUrl = ({
  currentUrl,
  redirectUrl,
}: RedirectValidationContext): void => {
  if (redirectUrl.protocol !== 'https:') {
    throw new Error('Provider redirect must use HTTPS.');
  }

  if (redirectUrl.hostname !== currentUrl.hostname) {
    throw new Error('Provider redirect points to an untrusted host.');
  }
};

const ensureWithinContentLength = (
  response: Response,
  options: LimitedReadOptions,
): void => {
  const contentLength = Number(response.headers.get('content-length') ?? NaN);
  if (Number.isFinite(contentLength) && contentLength > options.maxBytes) {
    throw new Error(options.tooLargeMessage);
  }
};

const readResponseBufferLimited = async (
  response: Response,
  options: LimitedReadOptions,
): Promise<Buffer> => {
  ensureWithinContentLength(response, options);

  if (!response.body) {
    return Buffer.alloc(0);
  }

  const reader = response.body.getReader();
  const chunks: Buffer[] = [];
  let totalBytes = 0;

  while (true) {
    const { done, value } = await reader.read();
    if (done) {
      break;
    }

    const chunk = Buffer.from(value);
    totalBytes += chunk.length;
    if (totalBytes > options.maxBytes) {
      await reader.cancel(options.tooLargeMessage);
      throw new Error(options.tooLargeMessage);
    }

    chunks.push(chunk);
  }

  return Buffer.concat(chunks, totalBytes);
};

export const fetchWithTimeout = async (
  url: string,
  options: FetchWithTimeoutOptions,
): Promise<Response> => {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), options.timeoutMs);
  const maxRedirects = options.maxRedirects ?? 3;
  let redirectsFollowed = 0;
  let currentUrl = new URL(url);
  let method = options.method ?? 'GET';
  let body = options.body;
  const headers = {
    ...DEFAULT_HEADERS,
    ...options.headers,
  };

  try {
    while (true) {
      const response = await fetch(currentUrl, {
        method,
        body,
        headers,
        redirect: 'manual',
        signal: controller.signal,
      });

      if (!REDIRECT_STATUSES.has(response.status)) {
        return response;
      }

      const location = response.headers.get('location');
      if (!location) {
        throw new Error('Provider redirect did not include a location header.');
      }
      if (redirectsFollowed >= maxRedirects) {
        throw new Error('Provider request exceeded the maximum redirect limit.');
      }

      const redirectUrl = new URL(location, currentUrl);
      await (options.validateRedirectUrl ?? defaultValidateRedirectUrl)({
        currentUrl,
        redirectUrl,
      });

      if (shouldRewriteToGet(response.status, method)) {
        method = 'GET';
        body = undefined;
      }

      currentUrl = redirectUrl;
      redirectsFollowed += 1;
    }
  } catch (error) {
    if (
      error instanceof Error &&
      (error.name === 'AbortError' || error.message.includes('aborted'))
    ) {
      throw new Error('Provider request timed out.');
    }

    throw error;
  } finally {
    clearTimeout(timeout);
  }
};

export const readResponseText = async (
  response: Response,
  options: { maxBytes?: number; tooLargeMessage?: string } = {},
): Promise<string> => {
  const buffer = await readResponseBufferLimited(response, {
    maxBytes: options.maxBytes ?? 512 * 1024,
    tooLargeMessage:
      options.tooLargeMessage ??
      'Provider response exceeds the maximum allowed size.',
  });

  return buffer.toString('utf8');
};

export const readResponseJson = async <T>(
  response: Response,
  options: {
    maxBytes?: number;
    tooLargeMessage?: string;
    invalidJsonMessage?: string;
  } = {},
): Promise<T> => {
  const text = await readResponseText(response, {
    maxBytes: options.maxBytes,
    tooLargeMessage: options.tooLargeMessage,
  });

  try {
    return JSON.parse(text) as T;
  } catch {
    throw new Error(
      options.invalidJsonMessage ?? 'Provider returned invalid JSON.',
    );
  }
};
