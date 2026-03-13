import { Prisma } from '@prisma/client';

import {
  ConflictDomainError,
  DomainError,
  ValidationDomainError,
} from 'src/common/domain/errors/domain.error';

export const normalizeDatabaseError = (error: unknown): never => {
  if (error instanceof DomainError) {
    throw error;
  }

  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    if (error.code === 'P2002') {
      throw new ConflictDomainError(
        'A unique record constraint was violated.',
        {
          target: error.meta?.target,
        },
      );
    }

    if (error.code === 'P2003') {
      throw new ValidationDomainError(
        'A related record reference is invalid.',
        {
          field: error.meta?.field_name,
        },
      );
    }
  }

  throw error;
};
