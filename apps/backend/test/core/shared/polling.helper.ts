type PollUntilParams<T> = {
  label: string;
  poll: () => Promise<T>;
  isDone: (value: T) => boolean;
  attempts?: number;
  intervalMs?: number;
};

/** Polls an async source until a completion predicate succeeds. */
export const pollUntil = async <T>({
  label,
  poll,
  isDone,
  attempts = 20,
  intervalMs = 200,
}: PollUntilParams<T>): Promise<T> => {
  for (let attempt = 0; attempt < attempts; attempt += 1) {
    const result = await poll();
    if (isDone(result)) {
      return result;
    }

    await new Promise((resolve) => setTimeout(resolve, intervalMs));
  }

  throw new Error(`${label} did not complete in time.`);
};
