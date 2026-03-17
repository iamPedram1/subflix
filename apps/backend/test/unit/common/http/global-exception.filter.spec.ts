import { HttpException } from '@nestjs/common';
import type { ArgumentsHost } from '@nestjs/common';
import { describe, expect, it, vi } from 'vitest';
import { MulterError } from 'multer';

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

// ---------------------------------------------------------------------------
// MulterError handling
// ---------------------------------------------------------------------------

describe('GlobalExceptionFilter MulterError', () => {
  it('returns 413 payload_too_large for LIMIT_FILE_SIZE', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(new MulterError('LIMIT_FILE_SIZE'), host);

    expect(response.status).toHaveBeenCalledWith(413);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'payload_too_large',
      }),
    );
  });

  it('returns 400 upload_invalid for any other MulterError code', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(new MulterError('LIMIT_FILE_COUNT'), host);

    expect(response.status).toHaveBeenCalledWith(400);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'upload_invalid',
      }),
    );
  });

  it('includes the multerCode in the details field', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(new MulterError('LIMIT_FIELD_COUNT'), host);

    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        details: { multerCode: 'LIMIT_FIELD_COUNT' },
      }),
    );
  });
});

// ---------------------------------------------------------------------------
// HttpException handling
// ---------------------------------------------------------------------------

describe('GlobalExceptionFilter HttpException', () => {
  it('returns validation_failed code for a 400 HttpException', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(new HttpException('Bad request', 400), host);

    expect(response.status).toHaveBeenCalledWith(400);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'validation_failed',
      }),
    );
  });

  it('returns http_error code for non-400 HttpExceptions', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(new HttpException('Forbidden', 403), host);

    expect(response.status).toHaveBeenCalledWith(403);
    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'http_error',
      }),
    );
  });

  it('extracts message from an object payload', () => {
    const filter = new GlobalExceptionFilter();
    const { host, response } = createMockHost({});

    filter.catch(
      new HttpException({ message: ['field is required'], error: 'Bad Request' }, 400),
      host,
    );

    expect(response.json).toHaveBeenCalledWith(
      expect.objectContaining({
        code: 'validation_failed',
        message: ['field is required'],
      }),
    );
  });
});

// ---------------------------------------------------------------------------
// DomainError i18n (existing)
// ---------------------------------------------------------------------------

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
