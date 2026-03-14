import type { ArgumentsHost } from '@nestjs/common';
import { describe, expect, it, vi } from 'vitest';

import {
  DomainError,
  TooManyRequestsDomainError,
} from 'common/domain/errors/domain.error';
import { GlobalExceptionFilter } from 'common/http/filters/global-exception.filter';

const createMockHost = (params: {
  acceptLanguage?: string;
  requestId?: string;
}) => {
  const response = {
    status: vi.fn().mockReturnThis(),
    json: vi.fn(),
  };

  const request = {
    header: vi.fn((name: string) => {
      const normalized = name.toLowerCase();
      if (normalized === 'accept-language') {
        return params.acceptLanguage;
      }
      if (normalized === 'x-request-id') {
        return params.requestId ?? 'test-request-id';
      }
      return undefined;
    }),
  };

  const host: ArgumentsHost = {
    switchToHttp: () => ({
      getResponse: () => response,
      getRequest: () => request,
    }),
  } as unknown as ArgumentsHost;

  return { host, request, response };
};

describe('GlobalExceptionFilter i18n', () => {
  it('localizes DomainError messages when an i18n key is present', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({ acceptLanguage: 'fr' });

    const error = new TooManyRequestsDomainError(
      'Too many requests. Please try again later.',
      { limit: 1 },
      { key: 'errors.rate_limited' },
    );

    filter.catch(error, host);

    expect(response.status).toHaveBeenCalledWith(429);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'rate_limited',
        message: 'Trop de requêtes. Veuillez réessayer plus tard.',
        details: { limit: 1 },
      }),
    );
  });

  it('keeps the original message when no i18n key is present', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({ acceptLanguage: 'ar' });

    const error = new DomainError({
      statusCode: 400,
      code: 'validation_failed',
      message: 'Plain error message.',
      details: { field: 'x' },
    });

    filter.catch(error, host);

    expect(response.status).toHaveBeenCalledWith(400);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'validation_failed',
        message: 'Plain error message.',
        details: { field: 'x' },
      }),
    );
  });

  it('localizes unknown errors using the internal error message', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({ acceptLanguage: 'ar' });

    filter.catch(new Error('boom'), host);

    expect(response.status).toHaveBeenCalledWith(500);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'internal_error',
        message: 'حدث خطأ غير متوقع.',
      }),
    );
  });
});
