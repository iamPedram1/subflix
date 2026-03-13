import { INestApplication, ValidationPipe } from '@nestjs/common';

import { GlobalExceptionFilter } from './common/http/filters/global-exception.filter';
import { RequestIdInterceptor } from './common/http/interceptors/request-id.interceptor';

/**
 * Applies the shared NestJS runtime configuration used by both the HTTP server
 * and the e2e test harness.
 */
export const configureApp = (app: INestApplication): void => {
  app.setGlobalPrefix('v1');
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      transformOptions: { enableImplicitConversion: true },
      forbidNonWhitelisted: true,
    }),
  );
  app.useGlobalInterceptors(new RequestIdInterceptor());
  app.useGlobalFilters(new GlobalExceptionFilter());
};
