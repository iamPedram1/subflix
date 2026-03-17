import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { StructuredLogger } from 'common/utils/structured-logger';
import { SubtitleSourceProviderName } from 'features/catalog/models/subtitle-source-provider-name.model';
import {
  CircuitBreakerPolicy,
  CircuitState,
  ProviderHealthState,
  applyFailure,
  applySuccess,
  createInitialHealthState,
  isCircuitAllowed,
  resolveHealthState,
} from 'features/catalog/utils/provider-circuit-breaker.util';

export type { CircuitState };

export interface ProviderHealthSummary {
  provider: SubtitleSourceProviderName;
  circuitState: CircuitState;
  consecutiveFailures: number;
  lastFailureAt?: Date;
  lastSuccessAt?: Date;
  cooldownUntil?: Date;
}

@Injectable()
export class SubtitleProviderHealthService {
  private readonly log = new StructuredLogger(
    SubtitleProviderHealthService.name,
  );

  private readonly states = new Map<
    SubtitleSourceProviderName,
    ProviderHealthState
  >();

  private readonly policy: CircuitBreakerPolicy;

  constructor(configService: ConfigService) {
    this.policy = {
      failureThreshold:
        configService.get<number>(
          'subtitleSources.providerFailureThreshold',
        ) ?? 3,
      cooldownMs:
        configService.get<number>('subtitleSources.providerCooldownMs') ??
        60_000,
    };
  }

  /**
   * Returns true if the provider is allowed to be called right now.
   * Silently advances the circuit from open → half_open when the cooldown has
   * elapsed (logged here so the transition is visible in structured logs).
   */
  isAllowed(provider: SubtitleSourceProviderName): boolean {
    const now = Date.now();
    const current = this.getOrCreate(provider);
    const { state, transitionedToHalfOpen } = resolveHealthState(current, now);

    if (transitionedToHalfOpen) {
      this.states.set(provider, state);
      this.log.info('subtitle.discovery.provider.half_open', {
        provider,
        consecutiveFailures: state.consecutiveFailures,
      });
    }

    return isCircuitAllowed(state);
  }

  recordSuccess(provider: SubtitleSourceProviderName): void {
    const state = this.getOrCreate(provider);

    // Skip the map write on the common happy path — provider already healthy.
    if (state.circuitState === 'closed' && state.consecutiveFailures === 0) {
      return;
    }

    const wasUnhealthy = state.circuitState !== 'closed';
    this.states.set(provider, applySuccess(state, Date.now()));

    if (wasUnhealthy) {
      this.log.info('subtitle.discovery.provider.recovered', { provider });
    }
  }

  recordFailure(provider: SubtitleSourceProviderName): void {
    const now = Date.now();
    const state = this.getOrCreate(provider);
    const { state: nextState, circuitJustOpened } = applyFailure(
      state,
      this.policy,
      now,
    );

    this.states.set(provider, nextState);

    if (circuitJustOpened) {
      this.log.warn('subtitle.discovery.provider.marked_unhealthy', {
        provider,
        consecutiveFailures: nextState.consecutiveFailures,
        cooldownUntil: nextState.cooldownUntil,
      });
    }
  }

  getHealthSummary(): ProviderHealthSummary[] {
    return Array.from(this.states.entries()).map(([provider, state]) => ({
      provider,
      circuitState: state.circuitState,
      consecutiveFailures: state.consecutiveFailures,
      lastFailureAt: state.lastFailureAt
        ? new Date(state.lastFailureAt)
        : undefined,
      lastSuccessAt: state.lastSuccessAt
        ? new Date(state.lastSuccessAt)
        : undefined,
      cooldownUntil: state.cooldownUntil
        ? new Date(state.cooldownUntil)
        : undefined,
    }));
  }

  private getOrCreate(
    provider: SubtitleSourceProviderName,
  ): ProviderHealthState {
    const existing = this.states.get(provider);
    if (existing) return existing;
    const initial = createInitialHealthState();
    this.states.set(provider, initial);
    return initial;
  }
}
