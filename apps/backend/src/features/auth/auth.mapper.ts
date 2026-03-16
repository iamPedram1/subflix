import { User } from '@prisma/client';

import type { AuthUser } from 'features/auth/auth.types';

export const toAuthUser = (user: User): AuthUser => ({
  id: user.id,
  email: user.email,
  displayName: user.displayName ?? null,
  photoUrl: user.photoUrl ?? null,
  emailVerified: user.emailVerified,
  createdAt: user.createdAt,
  updatedAt: user.updatedAt,
});
