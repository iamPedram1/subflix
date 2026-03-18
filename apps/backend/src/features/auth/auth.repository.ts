import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import type { AuthProvider, RefreshToken } from '@prisma/client';

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
}
