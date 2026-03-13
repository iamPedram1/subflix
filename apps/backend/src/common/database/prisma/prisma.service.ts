import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient {
  constructor(configService: ConfigService) {
    super({
      datasourceUrl: configService.getOrThrow<string>('database.url'),
      log:
        configService.get<string>('app.nodeEnv') === 'development'
          ? ['error', 'warn']
          : ['error'],
    });
  }
}
