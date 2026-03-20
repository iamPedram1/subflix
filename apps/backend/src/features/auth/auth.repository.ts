import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import type { AuthProvider, RefreshToken, User } from '@prisma/client';

import { BaseRepository } from 'common/database/base.repository';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for users, identities, and refresh tokens. */
export class AuthRepository extends BaseRepository {
  constructor(private readonly prisma: PrismaService) {
    super();
  }

  findUserByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }

  findUserById(id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  createUser(data: Prisma.UserCreateInput) {
    return this.dbCall(() => this.prisma.user.create({ data }));
  }

  updateUser(id: string, data: Prisma.UserUpdateInput) {
    return this.dbCall(() => this.prisma.user.update({ where: { id }, data }));
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

  createIdentity(data: Prisma.UserIdentityCreateInput) {
    return this.dbCall(() => this.prisma.userIdentity.create({ data }));
  }

  createRefreshToken(data: Prisma.RefreshTokenUncheckedCreateInput) {
    return this.dbCall(() => this.prisma.refreshToken.create({ data }));
  }

  findRefreshTokenByHash(tokenHash: string) {
    return this.prisma.refreshToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  findSessionById(id: string) {
    return this.prisma.refreshToken.findUnique({
      where: { id },
      include: { user: true },
    });
  }

  revokeRefreshToken(id: string, revokedAt: Date): Promise<RefreshToken> {
    return this.dbCall(() =>
      this.prisma.refreshToken.update({
        where: { id },
        data: { revokedAt, lastUsedAt: revokedAt },
      }),
    );
  }

  touchRefreshToken(id: string, lastUsedAt: Date): Promise<RefreshToken> {
    return this.dbCall(() =>
      this.prisma.refreshToken.update({
        where: { id },
        data: { lastUsedAt },
      }),
    );
  }

  revokeAllRefreshTokensForUser(userId: string, revokedAt: Date): Promise<void> {
    return this.dbCall(async () => {
      await this.prisma.refreshToken.updateMany({
        where: { userId, revokedAt: null },
        data: { revokedAt, lastUsedAt: revokedAt },
      });
    });
  }

  clearEmailVerificationTokens(userId: string): Promise<void> {
    return this.dbCall(async () => {
      await this.prisma.emailVerificationToken.deleteMany({ where: { userId } });
    });
  }

  createEmailVerificationToken(
    data: Prisma.EmailVerificationTokenUncheckedCreateInput,
  ) {
    return this.dbCall(() => this.prisma.emailVerificationToken.create({ data }));
  }

  findEmailVerificationTokenByHash(tokenHash: string) {
    return this.prisma.emailVerificationToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  consumeEmailVerificationToken(id: string, consumedAt: Date) {
    return this.dbCall(() =>
      this.prisma.emailVerificationToken.update({
        where: { id },
        data: { consumedAt },
      }),
    );
  }

  clearPasswordResetTokens(userId: string): Promise<void> {
    return this.dbCall(async () => {
      await this.prisma.passwordResetToken.deleteMany({ where: { userId } });
    });
  }

  createPasswordResetToken(
    data: Prisma.PasswordResetTokenUncheckedCreateInput,
  ) {
    return this.dbCall(() => this.prisma.passwordResetToken.create({ data }));
  }

  findPasswordResetTokenByHash(tokenHash: string) {
    return this.prisma.passwordResetToken.findUnique({
      where: { tokenHash },
      include: { user: true },
    });
  }

  consumePasswordResetToken(id: string, consumedAt: Date) {
    return this.dbCall(() =>
      this.prisma.passwordResetToken.update({
        where: { id },
        data: { consumedAt },
      }),
    );
  }

  async rotateRefreshToken(params: {
    tokenHash: string;
    now: Date;
    nextRefreshToken: Omit<
      Prisma.RefreshTokenUncheckedCreateInput,
      'userId'
    >;
  }): Promise<{ user: User; refreshRecord: RefreshToken } | null> {
    return this.dbCall(() =>
      this.prisma.$transaction(async (tx) => {
        const record = await tx.refreshToken.findUnique({
          where: { tokenHash: params.tokenHash },
          include: { user: true },
        });

        if (
          !record ||
          record.revokedAt !== null ||
          record.expiresAt <= params.now ||
          !record.user
        ) {
          return null;
        }

        const revoked = await tx.refreshToken.updateMany({
          where: {
            id: record.id,
            revokedAt: null,
            expiresAt: { gt: params.now },
          },
          data: {
            revokedAt: params.now,
            lastUsedAt: params.now,
          },
        });

        if (revoked.count !== 1) {
          return null;
        }

        const refreshRecord = await tx.refreshToken.create({
          data: {
            userId: record.user.id,
            ...params.nextRefreshToken,
          },
        });

        return {
          user: record.user,
          refreshRecord,
        };
      }),
    );
  }

  async confirmEmailByTokenHash(
    tokenHash: string,
    now: Date,
  ): Promise<'confirmed' | 'invalid' | 'expired'> {
    return this.dbCall(() =>
      this.prisma.$transaction(async (tx) => {
        const record = await tx.emailVerificationToken.findUnique({
          where: { tokenHash },
          include: { user: true },
        });

        if (!record || record.consumedAt || !record.user) {
          return 'invalid';
        }

        if (record.expiresAt <= now) {
          return 'expired';
        }

        const consumed = await tx.emailVerificationToken.updateMany({
          where: {
            id: record.id,
            consumedAt: null,
            expiresAt: { gt: now },
          },
          data: { consumedAt: now },
        });

        if (consumed.count !== 1) {
          return 'invalid';
        }

        if (!record.user.emailVerified) {
          await tx.user.update({
            where: { id: record.user.id },
            data: { emailVerified: true },
          });
        }

        return 'confirmed';
      }),
    );
  }

  async resetPasswordByTokenHash(params: {
    tokenHash: string;
    passwordHash: string;
    now: Date;
  }): Promise<'reset' | 'invalid' | 'expired'> {
    return this.dbCall(() =>
      this.prisma.$transaction(async (tx) => {
        const record = await tx.passwordResetToken.findUnique({
          where: { tokenHash: params.tokenHash },
          include: { user: true },
        });

        if (!record || record.consumedAt || !record.user) {
          return 'invalid';
        }

        if (record.expiresAt <= params.now) {
          return 'expired';
        }

        const consumed = await tx.passwordResetToken.updateMany({
          where: {
            id: record.id,
            consumedAt: null,
            expiresAt: { gt: params.now },
          },
          data: { consumedAt: params.now },
        });

        if (consumed.count !== 1) {
          return 'invalid';
        }

        await tx.user.update({
          where: { id: record.user.id },
          data: { passwordHash: params.passwordHash },
        });

        await tx.refreshToken.updateMany({
          where: { userId: record.user.id, revokedAt: null },
          data: { revokedAt: params.now, lastUsedAt: params.now },
        });

        return 'reset';
      }),
    );
  }
}
