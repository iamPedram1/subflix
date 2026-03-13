export const hasDatabaseUrl = (): boolean =>
  Boolean(process.env.DATABASE_URL?.trim());

export const describeIfDatabase = hasDatabaseUrl() ? describe : describe.skip;
