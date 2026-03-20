import {
  fetchWithTimeout,
  readResponseJson,
  readResponseText,
} from 'features/catalog/utils/provider-fetch.util';

describe('provider-fetch util', () => {
  afterEach(() => {
    vi.unstubAllGlobals();
    vi.restoreAllMocks();
  });

  it('rejects redirects to untrusted hosts before following them', async () => {
    const fetchMock = vi
      .fn()
      .mockResolvedValueOnce(
        new Response(null, {
          status: 302,
          headers: { location: 'https://evil.example/download' },
        }),
      );
    vi.stubGlobal('fetch', fetchMock);

    await expect(
      fetchWithTimeout('https://subdl.com/subtitle/source-1', {
        timeoutMs: 1_000,
      }),
    ).rejects.toThrow('Provider redirect points to an untrusted host.');

    expect(fetchMock).toHaveBeenCalledTimes(1);
  });

  it('allows validated redirects before returning the final response', async () => {
    const fetchMock = vi
      .fn()
      .mockResolvedValueOnce(
        new Response(null, {
          status: 302,
          headers: { location: 'https://www.subdl.com/subtitle/source-1' },
        }),
      )
      .mockResolvedValueOnce(new Response('ok', { status: 200 }));
    vi.stubGlobal('fetch', fetchMock);

    const response = await fetchWithTimeout('https://subdl.com/subtitle/source-1', {
      timeoutMs: 1_000,
      validateRedirectUrl: ({ redirectUrl }) => {
        if (!['subdl.com', 'www.subdl.com'].includes(redirectUrl.hostname)) {
          throw new Error('bad redirect');
        }
      },
    });

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledTimes(2);
  });

  it('rejects oversized text responses', async () => {
    const response = new Response('abcdef', {
      status: 200,
      headers: { 'content-length': '6' },
    });

    await expect(
      readResponseText(response, {
        maxBytes: 5,
        tooLargeMessage: 'too large',
      }),
    ).rejects.toThrow('too large');
  });

  it('rejects oversized json responses', async () => {
    const response = new Response('{"items":[1,2,3]}', {
      status: 200,
      headers: { 'content-length': '17' },
    });

    await expect(
      readResponseJson(response, {
        maxBytes: 5,
        tooLargeMessage: 'json too large',
      }),
    ).rejects.toThrow('json too large');
  });
});
