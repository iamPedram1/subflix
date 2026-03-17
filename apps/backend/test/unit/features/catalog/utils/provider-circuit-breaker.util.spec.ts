import {
  applyFailure,
  applySuccess,
  CircuitBreakerPolicy,
  createInitialHealthState,
  isCircuitAllowed,
  ProviderHealthState,
  resolveHealthState,
} from 'features/catalog/utils/provider-circuit-breaker.util';

const policy: CircuitBreakerPolicy = { failureThreshold: 3, cooldownMs: 60_000 };
const T0 = 1_000_000;

describe('createInitialHealthState', () => {
  it('starts closed with zero consecutive failures', () => {
    const state = createInitialHealthState();
    expect(state.circuitState).toBe('closed');
    expect(state.consecutiveFailures).toBe(0);
  });
});

describe('isCircuitAllowed', () => {
  it('allows closed circuit', () => {
    expect(isCircuitAllowed({ circuitState: 'closed', consecutiveFailures: 0 })).toBe(true);
  });

  it('allows half_open circuit', () => {
    expect(isCircuitAllowed({ circuitState: 'half_open', consecutiveFailures: 2 })).toBe(true);
  });

  it('blocks open circuit', () => {
    expect(isCircuitAllowed({ circuitState: 'open', consecutiveFailures: 3 })).toBe(false);
  });
});

describe('resolveHealthState', () => {
  it('does not transition a closed circuit', () => {
    const state = createInitialHealthState();
    const { state: resolved, transitionedToHalfOpen } = resolveHealthState(state, T0);
    expect(resolved.circuitState).toBe('closed');
    expect(transitionedToHalfOpen).toBe(false);
  });

  it('does not transition an open circuit before cooldown elapses', () => {
    const state: ProviderHealthState = {
      circuitState: 'open',
      consecutiveFailures: 3,
      cooldownUntil: T0 + 60_000,
    };
    const { state: resolved, transitionedToHalfOpen } = resolveHealthState(
      state,
      T0 + 59_999,
    );
    expect(resolved.circuitState).toBe('open');
    expect(transitionedToHalfOpen).toBe(false);
  });

  it('transitions open → half_open exactly when cooldown elapses', () => {
    const state: ProviderHealthState = {
      circuitState: 'open',
      consecutiveFailures: 3,
      cooldownUntil: T0 + 60_000,
    };
    const { state: resolved, transitionedToHalfOpen } = resolveHealthState(
      state,
      T0 + 60_000,
    );
    expect(resolved.circuitState).toBe('half_open');
    expect(resolved.cooldownUntil).toBeUndefined();
    expect(transitionedToHalfOpen).toBe(true);
  });
});

describe('applySuccess', () => {
  it('resets consecutive failures and closes the circuit', () => {
    const state: ProviderHealthState = {
      circuitState: 'half_open',
      consecutiveFailures: 3,
      lastFailureAt: T0 - 1000,
    };
    const next = applySuccess(state, T0);
    expect(next.circuitState).toBe('closed');
    expect(next.consecutiveFailures).toBe(0);
    expect(next.lastSuccessAt).toBe(T0);
    expect(next.lastFailureAt).toBe(T0 - 1000);
  });

  it('preserves lastFailureAt from the previous state', () => {
    const state: ProviderHealthState = {
      circuitState: 'open',
      consecutiveFailures: 3,
      lastFailureAt: T0 - 5000,
    };
    const next = applySuccess(state, T0);
    expect(next.lastFailureAt).toBe(T0 - 5000);
  });
});

describe('applyFailure', () => {
  it('increments consecutive failures without opening the circuit below threshold', () => {
    const state = createInitialHealthState();
    const { state: next, circuitJustOpened } = applyFailure(state, policy, T0);
    expect(next.consecutiveFailures).toBe(1);
    expect(next.circuitState).toBe('closed');
    expect(circuitJustOpened).toBe(false);
  });

  it('opens the circuit exactly at the failure threshold', () => {
    let state = createInitialHealthState();
    for (let i = 0; i < policy.failureThreshold - 1; i++) {
      ({ state } = applyFailure(state, policy, T0 + i));
    }
    const { state: next, circuitJustOpened } = applyFailure(state, policy, T0 + 99);
    expect(next.circuitState).toBe('open');
    expect(next.cooldownUntil).toBe(T0 + 99 + policy.cooldownMs);
    expect(circuitJustOpened).toBe(true);
  });

  it('sets circuitJustOpened=false when the circuit was already open', () => {
    const openState: ProviderHealthState = {
      circuitState: 'open',
      consecutiveFailures: 3,
      cooldownUntil: T0 + 60_000,
    };
    const { circuitJustOpened } = applyFailure(openState, policy, T0 + 1);
    expect(circuitJustOpened).toBe(false);
  });

  it('reopens the circuit immediately on half_open failure', () => {
    const halfOpenState: ProviderHealthState = {
      circuitState: 'half_open',
      consecutiveFailures: 3,
    };
    const { state: next, circuitJustOpened } = applyFailure(
      halfOpenState,
      policy,
      T0,
    );
    expect(next.circuitState).toBe('open');
    expect(next.cooldownUntil).toBe(T0 + policy.cooldownMs);
    expect(circuitJustOpened).toBe(true);
  });

  it('records lastFailureAt on every failure', () => {
    const state = createInitialHealthState();
    const { state: next } = applyFailure(state, policy, T0);
    expect(next.lastFailureAt).toBe(T0);
  });
});
