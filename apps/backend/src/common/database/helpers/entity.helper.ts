import { NotFoundDomainError } from 'src/common/domain/errors/domain.error';

/**
 * Ensures a nullable persistence result exists before the caller proceeds.
 */
export const requireEntity = <T>(
  entity: T | null | undefined,
  message: string,
): T => {
  if (entity == null) {
    throw new NotFoundDomainError(message);
  }

  return entity;
};
