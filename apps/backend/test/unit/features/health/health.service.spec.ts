import { ConfigService } from '@nestjs/config';

import { HealthService } from 'src/features/health/health.service';

describe('HealthService', () => {
  it('returns a healthy payload', () => {
    const configService = {
      get: vi.fn().mockReturnValue('test'),
    } as unknown as ConfigService;
    const service = new HealthService(configService);

    const result = service.getHealth();

    expect(result.status).toBe('ok');
    expect(result.service).toBe('subflix-back');
    expect(result.environment).toBe('test');
    expect(result.timestamp).toEqual(expect.any(String));
  });
});
