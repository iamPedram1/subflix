import { Controller, Get } from '@nestjs/common';

import { HealthService } from './health.service';

@Controller('health')
/** Exposes the public readiness endpoint for health checks and smoke tests. */
export class HealthController {
  constructor(private readonly healthService: HealthService) {}

  /** Returns the current lightweight health payload. */
  @Get()
  getHealth() {
    return this.healthService.getHealth();
  }
}
