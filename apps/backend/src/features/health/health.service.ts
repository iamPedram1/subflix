import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
/** Provides the lightweight readiness payload exposed by the health endpoint. */
export class HealthService {
  constructor(private readonly configService: ConfigService) {}

  /** Builds the public service health response. */
  getHealth() {
    return {
      status: 'ok',
      service: 'subflix-back',
      environment: this.configService.get<string>('app.nodeEnv'),
      timestamp: new Date().toISOString(),
    };
  }
}
