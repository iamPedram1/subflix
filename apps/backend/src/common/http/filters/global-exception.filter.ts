import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { MulterError } from 'multer';

import { DomainError } from 'common/domain/errors/domain.error';
import {
  isI18nKey,
  resolveLocaleFromAcceptLanguage,
  translate,
} from 'common/i18n/i18n.util';

import { REQUEST_ID_HEADER } from 'common/http/constants/request-context.constants';

@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost): void {
    const context = host.switchToHttp();
    const response = context.getResponse<Response>();
    const request = context.getRequest<Request>();
    const requestId = request.header(REQUEST_ID_HEADER) ?? 'unknown';
    const timestamp = new Date().toISOString();
    const locale = resolveLocaleFromAcceptLanguage(
      request.header('accept-language'),
    );

    if (exception instanceof DomainError) {
      const message =
        exception.i18nKey && isI18nKey(exception.i18nKey)
          ? translate(locale, exception.i18nKey, exception.i18nArgs)
          : exception.message;

      response.status(exception.statusCode).json({
        code: exception.code,
        message,
        details: exception.details,
        requestId,
        timestamp,
      });
      return;
    }

    if (exception instanceof MulterError) {
      const status =
        exception.code === 'LIMIT_FILE_SIZE'
          ? HttpStatus.PAYLOAD_TOO_LARGE
          : HttpStatus.BAD_REQUEST;

      response.status(status).json({
        code:
          exception.code === 'LIMIT_FILE_SIZE'
            ? 'payload_too_large'
            : 'upload_invalid',
        message:
          exception.code === 'LIMIT_FILE_SIZE'
            ? translate(locale, 'errors.payload_too_large')
            : translate(locale, 'errors.upload_invalid'),
        details: {
          multerCode: exception.code,
        },
        requestId,
        timestamp,
      });
      return;
    }

    if (exception instanceof HttpException) {
      const status = exception.getStatus();
      const payload = exception.getResponse();
      const message =
        typeof payload === 'object' && payload && 'message' in payload
          ? payload.message
          : exception.message;

      response.status(status).json({
        code: status === 400 ? 'validation_failed' : 'http_error',
        message,
        details: typeof payload === 'object' ? payload : undefined,
        requestId,
        timestamp,
      });
      return;
    }

    response.status(HttpStatus.INTERNAL_SERVER_ERROR).json({
      code: 'internal_error',
      message: translate(locale, 'errors.internal_error'),
      requestId,
      timestamp,
    });
  }
}
