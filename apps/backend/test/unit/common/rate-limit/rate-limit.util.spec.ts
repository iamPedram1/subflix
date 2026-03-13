import type { Request } from 'express';

import { resolveRateLimitActors } from 'src/common/rate-limit/rate-limit.util';

describe('resolveRateLimitActors', () => {
  it('returns both ip and device actor keys when a valid device header exists', () => {
    const actors = resolveRateLimitActors({
      ip: '127.0.0.1',
      socket: { remoteAddress: '127.0.0.1' },
      header: (name: string) =>
        name === 'x-device-id' ? 'device-test-001' : undefined,
    } as unknown as Request);

    expect(actors).toHaveLength(2);
    expect(actors[0]).toMatch(/^ip:/);
    expect(actors[1]).toMatch(/^device:/);
    expect(actors[1]).not.toContain('device-test-001');
  });

  it('falls back to ip-only throttling when the device header is missing or invalid', () => {
    const actors = resolveRateLimitActors({
      ip: '127.0.0.1',
      socket: { remoteAddress: '127.0.0.1' },
      header: () => 'bad device id!',
    } as unknown as Request);

    expect(actors).toHaveLength(1);
    expect(actors[0]).toMatch(/^ip:/);
  });
});
