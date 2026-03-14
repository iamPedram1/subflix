import { Controller, Get } from '@nestjs/common';

import { SkipRateLimit } from 'common/rate-limit/rate-limit.decorator';

import { HealthService } from 'features/health/health.service';

@Controller('health')
@SkipRateLimit()
/** Exposes the public readiness endpoint for health checks and smoke tests. */
export class HealthController {
  constructor(private readonly healthService: HealthService) {}

  /** Returns the current lightweight health payload. */
  @Get()
  getHealth() {
    return this.healthService.getHealth();
  }
}
