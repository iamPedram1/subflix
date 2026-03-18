import { normalizeDatabaseError } from 'common/database/helpers/database-error.helper';

/**
 * Provides a single shared error-normalization path for all Prisma write
 * operations. Subclasses call `this.dbCall(() => this.prisma.x.method(args))`
 * instead of wrapping every operation in an identical try/catch block.
 *
 * Read-only queries that cannot throw domain-relevant errors (findUnique,
 * findFirst, findMany) do not need wrapping — call Prisma directly.
 */
export abstract class BaseRepository {
  protected dbCall<T>(fn: () => Promise<T>): Promise<T> {
    return fn().catch(normalizeDatabaseError);
  }
}
