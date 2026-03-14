import { INestApplication, ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Application as ExpressApplication, json, urlencoded } from 'express';
import helmet from 'helmet';

import { GlobalExceptionFilter } from 'common/http/filters/global-exception.filter';
import { RequestIdInterceptor } from 'common/http/interceptors/request-id.interceptor';

/**
 * Applies the shared NestJS runtime configuration used by both the HTTP server
 * and the e2e test harness.
 */
export const configureApp = (app: INestApplication): void => {
  const configService = app.get(ConfigService);
  const expressApp = app.getHttpAdapter().getInstance() as ExpressApplication;
  const maxBodyBytes =
    configService.get<number>('app.maxBodyBytes') ?? 32 * 1024;

  expressApp.disable('x-powered-by');
  app.use(
    helmet({
      contentSecurityPolicy: false,
      crossOriginResourcePolicy: false,
    }),
  );
  app.use(json({ limit: `${maxBodyBytes}b` }));
  app.use(urlencoded({ extended: true, limit: `${maxBodyBytes}b` }));
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
