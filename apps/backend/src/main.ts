import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { NestFactory } from '@nestjs/core';

import { GlobalExceptionFilter } from './common/http/filters/global-exception.filter';
import { RequestIdInterceptor } from './common/http/interceptors/request-id.interceptor';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
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

  const configService = app.get(ConfigService);
  const port = configService.get<number>('app.port') ?? 3000;

  await app.listen(port);
}

void bootstrap();
