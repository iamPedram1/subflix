/**
 * Measures the wall-clock duration of a single async operation.
 *
 * Returns both the resolved value and the elapsed time in milliseconds so
 * callers can include durationMs in structured log entries without extra
 * boilerplate.
 *
 * Usage:
 *   const { result, durationMs } = await timed(() => provider.searchSources(input));
 *   this.log.info('provider.success', { durationMs, resultCount: result.length });
 */
export async function timed<T>(
  fn: () => Promise<T>,
): Promise<{ result: T; durationMs: number }> {
  const start = Date.now();
  const result = await fn();
  return { result, durationMs: Date.now() - start };
}
