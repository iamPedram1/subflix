export type CircuitState = 'closed' | 'open' | 'half_open';

export interface ProviderHealthState {
  circuitState: CircuitState;
  consecutiveFailures: number;
  lastFailureAt?: number;
  lastSuccessAt?: number;
  cooldownUntil?: number;
}

export interface CircuitBreakerPolicy {
  failureThreshold: number;
  cooldownMs: number;
}

export function createInitialHealthState(): ProviderHealthState {
  return { circuitState: 'closed', consecutiveFailures: 0 };
}

/**
 * Resolves any pending state transition (open → half_open) based on elapsed time.
 * Must be called before reading the circuit state to ensure it is up-to-date.
 */
export function resolveHealthState(
  state: ProviderHealthState,
  now: number,
): { state: ProviderHealthState; transitionedToHalfOpen: boolean } {
  if (
    state.circuitState === 'open' &&
    state.cooldownUntil !== undefined &&
    now >= state.cooldownUntil
  ) {
    return {
      state: { ...state, circuitState: 'half_open', cooldownUntil: undefined },
      transitionedToHalfOpen: true,
    };
  }

  return { state, transitionedToHalfOpen: false };
}

export function isCircuitAllowed(state: ProviderHealthState): boolean {
  return state.circuitState !== 'open';
}

export function applySuccess(
  state: ProviderHealthState,
  now: number,
): ProviderHealthState {
  return {
    circuitState: 'closed',
    consecutiveFailures: 0,
    lastSuccessAt: now,
    lastFailureAt: state.lastFailureAt,
  };
}

export function applyFailure(
  state: ProviderHealthState,
  policy: CircuitBreakerPolicy,
  now: number,
): { state: ProviderHealthState; circuitJustOpened: boolean } {
  const consecutiveFailures = state.consecutiveFailures + 1;

  // A failure in half_open always reopens the circuit immediately.
  const shouldOpen =
    consecutiveFailures >= policy.failureThreshold ||
    state.circuitState === 'half_open';

  if (shouldOpen) {
    return {
      state: {
        circuitState: 'open',
        consecutiveFailures,
        lastFailureAt: now,
        lastSuccessAt: state.lastSuccessAt,
        cooldownUntil: now + policy.cooldownMs,
      },
      circuitJustOpened: state.circuitState !== 'open',
    };
  }

  return {
    state: { ...state, consecutiveFailures, lastFailureAt: now },
    circuitJustOpened: false,
  };
}
