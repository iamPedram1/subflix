type FetchWithTimeoutOptions = {
  method?: string;
  body?: URLSearchParams;
  headers?: HeadersInit;
  timeoutMs: number;
};

const DEFAULT_HEADERS: HeadersInit = {
  Accept:
    'text/html,application/xhtml+xml,application/xml;q=0.9,application/json;q=0.8,*/*;q=0.7',
  'Accept-Language': 'en-US,en;q=0.9',
  'User-Agent':
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
};

export const fetchWithTimeout = async (
  url: string,
  options: FetchWithTimeoutOptions,
): Promise<Response> => {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), options.timeoutMs);

  try {
    return await fetch(url, {
      method: options.method,
      body: options.body,
      headers: {
        ...DEFAULT_HEADERS,
        ...options.headers,
      },
      redirect: 'follow',
      signal: controller.signal,
    });
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
