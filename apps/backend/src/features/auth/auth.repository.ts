import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import type { AuthProvider, RefreshToken } from '@prisma/client';

import { normalizeDatabaseError } from 'common/database/helpers/database-error.helper';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for users, identities, and refresh tokens. */
export class AuthRepository {
  constructor(private readonly prisma: PrismaService) {}

  findUserByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }

  findUserById(id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  async createUser(data: Prisma.UserCreateInput) {
    try {
      return await this.prisma.user.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async updateUser(id: string, data: Prisma.UserUpdateInput) {
    try {
      return await this.prisma.user.update({ where: { id }, data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  findIdentity(provider: AuthProvider, providerUserId: string) {
    return this.prisma.userIdentity.findUnique({
      where: {
        provider_providerUserId: {
          provider,
          providerUserId,
        },
      },
      include: { user: true },
    });
  }

  async createIdentity(data: Prisma.UserIdentityCreateInput) {
    try {
      return await this.prisma.userIdentity.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async createRefreshToken(data: Prisma.RefreshTokenUncheckedCreateInput) {
    try {
      return await this.prisma.refreshToken.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  findRefreshTokenByHash(tokenHash: string) {
    return this.prisma.refreshToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  async revokeRefreshToken(id: string, revokedAt: Date): Promise<RefreshToken> {
    try {
      return await this.prisma.refreshToken.update({
        where: { id },
        data: { revokedAt, lastUsedAt: revokedAt },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async touchRefreshToken(id: string, lastUsedAt: Date): Promise<RefreshToken> {
    try {
      return await this.prisma.refreshToken.update({
        where: { id },
        data: { lastUsedAt },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async revokeAllRefreshTokensForUser(
    userId: string,
    revokedAt: Date,
  ): Promise<void> {
    try {
      await this.prisma.refreshToken.updateMany({
        where: { userId, revokedAt: null },
        data: { revokedAt, lastUsedAt: revokedAt },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async clearEmailVerificationTokens(userId: string): Promise<void> {
    try {
      await this.prisma.emailVerificationToken.deleteMany({
        where: { userId },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async createEmailVerificationToken(
    data: Prisma.EmailVerificationTokenUncheckedCreateInput,
  ) {
    try {
      return await this.prisma.emailVerificationToken.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  findEmailVerificationTokenByHash(tokenHash: string) {
    return this.prisma.emailVerificationToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  async consumeEmailVerificationToken(id: string, consumedAt: Date) {
    try {
      return await this.prisma.emailVerificationToken.update({
        where: { id },
        data: { consumedAt },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async clearPasswordResetTokens(userId: string): Promise<void> {
    try {
      await this.prisma.passwordResetToken.deleteMany({
        where: { userId },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async createPasswordResetToken(
    data: Prisma.PasswordResetTokenUncheckedCreateInput,
  ) {
    try {
      return await this.prisma.passwordResetToken.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  findPasswordResetTokenByHash(tokenHash: string) {
    return this.prisma.passwordResetToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  async consumePasswordResetToken(id: string, consumedAt: Date) {
    try {
      return await this.prisma.passwordResetToken.update({
        where: { id },
        data: { consumedAt },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }
}
