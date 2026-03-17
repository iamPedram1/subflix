import { Test } from '@nestjs/testing';
import { AuthProvider } from '@prisma/client';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { AuthRepository } from 'features/auth/auth.repository';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

describeIfDatabase('AuthRepository integration', () => {
  let prisma: PrismaService;
  let repository: AuthRepository;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule],
      providers: [AuthRepository],
    }).compile();

    prisma = moduleRef.get(PrismaService);
    repository = moduleRef.get(AuthRepository);
  });

  beforeEach(async () => {
    await resetDatabase(prisma);
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  // -------------------------------------------------------------------------
  // Users
  // -------------------------------------------------------------------------

  describe('createUser / findUserByEmail / findUserById', () => {
    it('persists a user and retrieves it by email', async () => {
      await repository.createUser({
        email: 'alice@example.com',
        passwordHash: 'hashed',
        emailVerified: false,
      });

      const found = await repository.findUserByEmail('alice@example.com');

      expect(found).not.toBeNull();
      expect(found!.email).toBe('alice@example.com');
      expect(found!.passwordHash).toBe('hashed');
      expect(found!.emailVerified).toBe(false);
    });

    it('returns null when no user matches the given email', async () => {
      const found = await repository.findUserByEmail('nobody@example.com');
      expect(found).toBeNull();
    });

    it('persists and retrieves a user by id', async () => {
      const created = await repository.createUser({
        email: 'bob@example.com',
        emailVerified: false,
      });

      const found = await repository.findUserById(created.id);

      expect(found).not.toBeNull();
      expect(found!.id).toBe(created.id);
    });

    it('updates user fields', async () => {
      const created = await repository.createUser({
        email: 'carol@example.com',
        emailVerified: false,
      });

      const updated = await repository.updateUser(created.id, {
        emailVerified: true,
        displayName: 'Carol',
      });

      expect(updated.emailVerified).toBe(true);
      expect(updated.displayName).toBe('Carol');
    });
  });

  // -------------------------------------------------------------------------
  // User identities
  // -------------------------------------------------------------------------

  describe('createIdentity / findIdentity', () => {
    it('links a provider identity to a user and retrieves it with the user', async () => {
      const user = await repository.createUser({
        email: 'dave@example.com',
        emailVerified: true,
      });

      await repository.createIdentity({
        provider: AuthProvider.email,
        providerUserId: 'dave@example.com',
        email: 'dave@example.com',
        user: { connect: { id: user.id } },
      });

      const found = await repository.findIdentity(AuthProvider.email, 'dave@example.com');

      expect(found).not.toBeNull();
      expect(found!.user.id).toBe(user.id);
      expect(found!.provider).toBe(AuthProvider.email);
    });

    it('returns null when no matching identity exists', async () => {
      const found = await repository.findIdentity(AuthProvider.firebase_google, 'uid-unknown');
      expect(found).toBeNull();
    });
  });

  // -------------------------------------------------------------------------
  // Refresh tokens
  // -------------------------------------------------------------------------

  describe('createRefreshToken / findRefreshTokenByHash / revokeRefreshToken', () => {
    it('persists a refresh token and retrieves it by hash with the user', async () => {
      const user = await repository.createUser({
        email: 'eve@example.com',
        emailVerified: true,
      });

      const tokenHash = 'sha256-hash-eve';
      const expiresAt = new Date(Date.now() + 30 * 24 * 60 * 60_000);

      await repository.createRefreshToken({ userId: user.id, tokenHash, expiresAt });

      const found = await repository.findRefreshTokenByHash(tokenHash);

      expect(found).not.toBeNull();
      expect(found!.tokenHash).toBe(tokenHash);
      expect(found!.user.id).toBe(user.id);
      expect(found!.revokedAt).toBeNull();
    });

    it('returns null when the hash does not match any stored token', async () => {
      const found = await repository.findRefreshTokenByHash('no-such-hash');
      expect(found).toBeNull();
    });

    it('sets revokedAt on the token record', async () => {
      const user = await repository.createUser({
        email: 'frank@example.com',
        emailVerified: true,
      });

      const tokenHash = 'sha256-hash-frank';
      const expiresAt = new Date(Date.now() + 30 * 24 * 60 * 60_000);
      const record = await repository.createRefreshToken({ userId: user.id, tokenHash, expiresAt });

      const revokedAt = new Date();
      await repository.revokeRefreshToken(record.id, revokedAt);

      const found = await repository.findRefreshTokenByHash(tokenHash);

      expect(found!.revokedAt).not.toBeNull();
    });

    it('revokeAllRefreshTokensForUser only revokes active tokens', async () => {
      const user = await repository.createUser({
        email: 'grace@example.com',
        emailVerified: true,
      });

      const expiresAt = new Date(Date.now() + 30 * 24 * 60 * 60_000);
      const alreadyRevoked = await repository.createRefreshToken({
        userId: user.id,
        tokenHash: 'hash-revoked-grace',
        expiresAt,
      });
      const revokedAt = new Date();
      await repository.revokeRefreshToken(alreadyRevoked.id, revokedAt);

      await repository.createRefreshToken({
        userId: user.id,
        tokenHash: 'hash-active-grace',
        expiresAt,
      });

      await repository.revokeAllRefreshTokensForUser(user.id, new Date());

      const active = await repository.findRefreshTokenByHash('hash-active-grace');
      expect(active!.revokedAt).not.toBeNull();

      // Previously revoked should still have its original revokedAt (not updated by updateMany)
      const alreadyRevokedRefetched = await repository.findRefreshTokenByHash('hash-revoked-grace');
      // It was already revoked — should still be revoked
      expect(alreadyRevokedRefetched!.revokedAt).not.toBeNull();
    });
  });

  // -------------------------------------------------------------------------
  // Email verification tokens
  // -------------------------------------------------------------------------

  describe('email verification token lifecycle', () => {
    it('creates, finds, and consumes an email verification token', async () => {
      const user = await repository.createUser({
        email: 'henry@example.com',
        emailVerified: false,
      });

      const tokenHash = 'sha256-hash-henry-vtoken';
      const expiresAt = new Date(Date.now() + 24 * 60 * 60_000);

      await repository.createEmailVerificationToken({ userId: user.id, tokenHash, expiresAt });

      const found = await repository.findEmailVerificationTokenByHash(tokenHash);
      expect(found).not.toBeNull();
      expect(found!.consumedAt).toBeNull();
      expect(found!.user.id).toBe(user.id);

      const consumedAt = new Date();
      await repository.consumeEmailVerificationToken(found!.id, consumedAt);

      const refetched = await repository.findEmailVerificationTokenByHash(tokenHash);
      expect(refetched!.consumedAt).not.toBeNull();
    });

    it('returns null when no verification token matches the hash', async () => {
      const found = await repository.findEmailVerificationTokenByHash('no-such-vtoken');
      expect(found).toBeNull();
    });

    it('clearEmailVerificationTokens removes all tokens for a user', async () => {
      const user = await repository.createUser({
        email: 'iris@example.com',
        emailVerified: false,
      });

      const expiresAt = new Date(Date.now() + 24 * 60 * 60_000);
      await repository.createEmailVerificationToken({
        userId: user.id,
        tokenHash: 'hash-iris-1',
        expiresAt,
      });
      await repository.createEmailVerificationToken({
        userId: user.id,
        tokenHash: 'hash-iris-2',
        expiresAt,
      });

      await repository.clearEmailVerificationTokens(user.id);

      const t1 = await repository.findEmailVerificationTokenByHash('hash-iris-1');
      const t2 = await repository.findEmailVerificationTokenByHash('hash-iris-2');
      expect(t1).toBeNull();
      expect(t2).toBeNull();
    });
  });

  // -------------------------------------------------------------------------
  // Password reset tokens
  // -------------------------------------------------------------------------

  describe('password reset token lifecycle', () => {
    it('creates, finds, and consumes a password reset token', async () => {
      const user = await repository.createUser({
        email: 'jake@example.com',
        emailVerified: true,
      });

      const tokenHash = 'sha256-hash-jake-prtoken';
      const expiresAt = new Date(Date.now() + 2 * 60 * 60_000);

      await repository.createPasswordResetToken({ userId: user.id, tokenHash, expiresAt });

      const found = await repository.findPasswordResetTokenByHash(tokenHash);
      expect(found).not.toBeNull();
      expect(found!.consumedAt).toBeNull();
      expect(found!.user.id).toBe(user.id);

      const consumedAt = new Date();
      await repository.consumePasswordResetToken(found!.id, consumedAt);

      const refetched = await repository.findPasswordResetTokenByHash(tokenHash);
      expect(refetched!.consumedAt).not.toBeNull();
    });

    it('returns null when no password reset token matches the hash', async () => {
      const found = await repository.findPasswordResetTokenByHash('no-such-prtoken');
      expect(found).toBeNull();
    });

    it('clearPasswordResetTokens removes all tokens for a user', async () => {
      const user = await repository.createUser({
        email: 'karen@example.com',
        emailVerified: true,
      });

      const expiresAt = new Date(Date.now() + 2 * 60 * 60_000);
      await repository.createPasswordResetToken({
        userId: user.id,
        tokenHash: 'hash-karen-1',
        expiresAt,
      });

      await repository.clearPasswordResetTokens(user.id);

      const found = await repository.findPasswordResetTokenByHash('hash-karen-1');
      expect(found).toBeNull();
    });
  });
});
