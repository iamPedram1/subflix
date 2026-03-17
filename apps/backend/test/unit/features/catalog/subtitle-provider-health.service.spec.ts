import { ConfigService } from '@nestjs/config';

import { SubtitleProviderHealthService } from 'features/catalog/subtitle-provider-health.service';

const THRESHOLD = 3;
const COOLDOWN_MS = 60_000;
const T0 = new Date('2024-01-01T00:00:00.000Z').getTime();

const createConfigService = () =>
  ({
    get: vi.fn((key: string) => {
      const map: Record<string, unknown> = {
        'subtitleSources.providerFailureThreshold': THRESHOLD,
        'subtitleSources.providerCooldownMs': COOLDOWN_MS,
      };
      return map[key];
    }),
  }) as unknown as ConfigService;

const createService = () =>
  new SubtitleProviderHealthService(createConfigService());

describe('SubtitleProviderHealthService', () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.setSystemTime(T0);
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  describe('isAllowed', () => {
    it('allows a fresh provider', () => {
      const svc = createService();
      expect(svc.isAllowed('subdl')).toBe(true);
    });

    it('still allows after fewer failures than the threshold', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD - 1; i++) {
        svc.recordFailure('subdl');
      }
      expect(svc.isAllowed('subdl')).toBe(true);
    });

    it('blocks after reaching the failure threshold', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) {
        svc.recordFailure('subdl');
      }
      expect(svc.isAllowed('subdl')).toBe(false);
    });

    it('keeps blocking before the cooldown elapses', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      vi.setSystemTime(T0 + COOLDOWN_MS - 1);
      expect(svc.isAllowed('subdl')).toBe(false);
    });

    it('allows again (half_open) exactly when the cooldown elapses', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      vi.setSystemTime(T0 + COOLDOWN_MS);
      expect(svc.isAllowed('subdl')).toBe(true);
    });

    it('does not affect other providers', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      expect(svc.isAllowed('podnapisi')).toBe(true);
    });
  });

  describe('recordSuccess', () => {
    it('resets consecutive failures so the provider is usable again', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD - 1; i++) svc.recordFailure('subdl');
      svc.recordSuccess('subdl');
      // Reaching threshold again requires a fresh run of failures.
      for (let i = 0; i < THRESHOLD - 1; i++) svc.recordFailure('subdl');
      expect(svc.isAllowed('subdl')).toBe(true);
    });

    it('recovers a half_open provider after a successful trial', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      vi.setSystemTime(T0 + COOLDOWN_MS); // advance past cooldown
      svc.isAllowed('subdl'); // triggers open → half_open
      svc.recordSuccess('subdl');
      expect(svc.isAllowed('subdl')).toBe(true);
    });
  });

  describe('recordFailure', () => {
    it('reopens the circuit immediately on a half_open failure', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      vi.setSystemTime(T0 + COOLDOWN_MS);
      svc.isAllowed('subdl'); // open → half_open
      svc.recordFailure('subdl');
      expect(svc.isAllowed('subdl')).toBe(false);
    });
  });

  describe('getHealthSummary', () => {
    it('returns empty when no providers have been touched', () => {
      expect(createService().getHealthSummary()).toEqual([]);
    });

    it('reflects the current state of each provider', () => {
      const svc = createService();
      for (let i = 0; i < THRESHOLD; i++) svc.recordFailure('subdl');
      svc.recordFailure('podnapisi');

      const summary = svc.getHealthSummary();
      const subdl = summary.find((s) => s.provider === 'subdl');
      const podnapisi = summary.find((s) => s.provider === 'podnapisi');

      expect(subdl?.circuitState).toBe('open');
      expect(subdl?.consecutiveFailures).toBe(THRESHOLD);
      expect(podnapisi?.circuitState).toBe('closed');
      expect(podnapisi?.consecutiveFailures).toBe(1);
    });
  });
});
