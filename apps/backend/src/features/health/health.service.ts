import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class HealthService {
  constructor(private readonly configService: ConfigService) {}

  getHealth() {
    return {
      status: 'ok',
      service: 'subflix-back',
      environment: this.configService.get<string>('app.nodeEnv'),
      timestamp: new Date().toISOString(),
    };
  }
}
