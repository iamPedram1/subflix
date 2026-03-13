/**
 * Suspends execution for the provided duration.
 *
 * This stays intentionally tiny so async workflows can share one delay helper
 * instead of redefining the same promise wrapper in multiple files.
 */
export const delay = (milliseconds: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, milliseconds));
