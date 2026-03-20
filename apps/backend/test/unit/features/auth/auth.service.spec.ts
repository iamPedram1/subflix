import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { AuthProvider } from '@prisma/client';
import type { User } from '@prisma/client';

import {
  ConflictDomainError,
  ForbiddenDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { AuthRepository } from 'features/auth/auth.repository';
import { FirebaseAuthService } from 'features/auth/firebase-auth.service';
import { AuthService } from 'features/auth/auth.service';

// ---------------------------------------------------------------------------
// Factories
// ---------------------------------------------------------------------------

const makeUser = (overrides: Partial<User> = {}): User => ({
  id: 'user-1',
  email: 'alice@example.com',
  passwordHash: null,
  displayName: 'Alice',
  photoUrl: null,
  emailVerified: true,
  createdAt: new Date('2026-01-01T00:00:00.000Z'),
  updatedAt: new Date('2026-01-01T00:00:00.000Z'),
  ...overrides,
});

const makeRefreshRecord = (overrides: Record<string, unknown> = {}) => ({
  id: 'refresh-rec-1',
  userId: 'user-1',
  tokenHash: 'hash-abc',
  expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60_000),
  revokedAt: null,
  lastUsedAt: null,
  createdAt: new Date(),
  ipAddress: null,
  userAgent: null,
  ...overrides,
});

// ---------------------------------------------------------------------------
// Service builder helpers
// ---------------------------------------------------------------------------

type AuthRepositoryMock = {
  [K in keyof AuthRepository]: ReturnType<typeof vi.fn>;
};

const makeAuthRepository = (overrides: Partial<AuthRepositoryMock> = {}): AuthRepository => {
  const base: AuthRepositoryMock = {
    findUserByEmail: vi.fn().mockResolvedValue(null),
    findUserById: vi.fn().mockResolvedValue(null),
    findSessionById: vi.fn().mockResolvedValue(null),
    createUser: vi.fn().mockResolvedValue(makeUser()),
    updateUser: vi.fn().mockResolvedValue(makeUser()),
    findIdentity: vi.fn().mockResolvedValue(null),
    createIdentity: vi.fn().mockResolvedValue({}),
    createRefreshToken: vi.fn().mockResolvedValue(makeRefreshRecord()),
    findRefreshTokenByHash: vi.fn().mockResolvedValue(null),
    rotateRefreshToken: vi
      .fn()
      .mockResolvedValue({ user: makeUser(), refreshRecord: makeRefreshRecord() }),
    revokeRefreshToken: vi.fn().mockResolvedValue({}),
    touchRefreshToken: vi.fn().mockResolvedValue({}),
    revokeAllRefreshTokensForUser: vi.fn().mockResolvedValue(undefined),
    clearEmailVerificationTokens: vi.fn().mockResolvedValue(undefined),
    createEmailVerificationToken: vi.fn().mockResolvedValue({}),
    findEmailVerificationTokenByHash: vi.fn().mockResolvedValue(null),
    confirmEmailByTokenHash: vi.fn().mockResolvedValue('invalid'),
    consumeEmailVerificationToken: vi.fn().mockResolvedValue({}),
    clearPasswordResetTokens: vi.fn().mockResolvedValue(undefined),
    createPasswordResetToken: vi.fn().mockResolvedValue({}),
    findPasswordResetTokenByHash: vi.fn().mockResolvedValue(null),
    resetPasswordByTokenHash: vi.fn().mockResolvedValue('invalid'),
    consumePasswordResetToken: vi.fn().mockResolvedValue({}),
  };
  return { ...base, ...overrides } as unknown as AuthRepository;
};

const makeConfigService = (
  nodeEnv = 'test',
  debugTokenEchoEnabled = nodeEnv === 'test',
): ConfigService => {
  const config: Record<string, unknown> = {
    'app.nodeEnv': nodeEnv,
    'auth.debugTokenEchoEnabled': debugTokenEchoEnabled,
    'auth.accessTokenTtlSeconds': 900,
    'auth.refreshTokenTtlDays': 30,
    'auth.emailVerificationTokenTtlHours': 24,
    'auth.passwordResetTokenTtlHours': 2,
    'auth.bcryptSaltRounds': 1, // minimal rounds for fast tests
  };
  return { get: vi.fn((key: string) => config[key]) } as unknown as ConfigService;
};

const makeJwtService = (): JwtService =>
  ({ sign: vi.fn().mockReturnValue('signed.jwt.token') }) as unknown as JwtService;

const makeFirebaseAuthService = (): FirebaseAuthService =>
  ({ verifyIdToken: vi.fn() }) as unknown as FirebaseAuthService;

const buildService = ({
  authRepository = makeAuthRepository(),
  jwtService = makeJwtService(),
  configService = makeConfigService(),
  firebaseAuthService = makeFirebaseAuthService(),
}: {
  authRepository?: AuthRepository;
  jwtService?: JwtService;
  configService?: ConfigService;
  firebaseAuthService?: FirebaseAuthService;
} = {}): AuthService =>
  new AuthService(authRepository, jwtService, configService, firebaseAuthService);

const meta = { ipAddress: '127.0.0.1', userAgent: 'TestAgent/1.0' };

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('AuthService', () => {
  // -------------------------------------------------------------------------
  // signUp
  // -------------------------------------------------------------------------
  describe('signUp', () => {
    it('normalizes the email before persisting it', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser({ email: 'alice@example.com' })),
      });

      const service = buildService({ authRepository });
      await service.signUp({ email: '  Alice@EXAMPLE.COM  ', password: 'Password1!' });

      expect(authRepository.findUserByEmail).toHaveBeenCalledWith('alice@example.com');
      expect(authRepository.createUser).toHaveBeenCalledWith(
        expect.objectContaining({ email: 'alice@example.com' }),
      );
    });

    it('throws ConflictDomainError when email is already registered', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({ authRepository });
      await expect(
        service.signUp({ email: 'alice@example.com', password: 'Password1!' }),
      ).rejects.toBeInstanceOf(ConflictDomainError);
    });

    it('creates an email identity and returns verificationRequired: true', async () => {
      const createdUser = makeUser({ emailVerified: false });
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(createdUser),
      });

      const service = buildService({ authRepository });
      const result = await service.signUp({ email: 'alice@example.com', password: 'Pass1234!' });

      expect(authRepository.createIdentity).toHaveBeenCalledWith(
        expect.objectContaining({ provider: AuthProvider.email }),
      );
      expect(result.verificationRequired).toBe(true);
      expect(result.user.id).toBe(createdUser.id);
    });

    it('includes verificationToken in non-production environments', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser({ emailVerified: false })),
      });

      const service = buildService({ authRepository, configService: makeConfigService('test') });
      const result = await service.signUp({ email: 'alice@example.com', password: 'Pass1234!' });

      expect(typeof result.verificationToken).toBe('string');
      expect(result.verificationToken!.length).toBeGreaterThan(10);
    });

    it('omits verificationToken in production', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser({ emailVerified: false })),
      });

      const service = buildService({
        authRepository,
        configService: makeConfigService('production', false),
      });
      const result = await service.signUp({ email: 'alice@example.com', password: 'Pass1234!' });

      expect(result.verificationToken).toBeUndefined();
    });

    it('omits verificationToken when debug token echo is disabled outside test mode', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser({ emailVerified: false })),
      });

      const service = buildService({
        authRepository,
        configService: makeConfigService('development', false),
      });
      const result = await service.signUp({ email: 'alice@example.com', password: 'Pass1234!' });

      expect(result.verificationToken).toBeUndefined();
    });

    it('hashes the password before persisting', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({ authRepository });
      await service.signUp({ email: 'alice@example.com', password: 'PlainText!' });

      const createUserCall = (authRepository.createUser as ReturnType<typeof vi.fn>).mock.calls[0][0];
      expect(createUserCall.passwordHash).toBeDefined();
      expect(createUserCall.passwordHash).not.toBe('PlainText!');
    });

    it('trims optional displayName before persisting', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({ authRepository });
      await service.signUp({
        email: 'alice@example.com',
        password: 'Pass1234!',
        displayName: '  Alice  ',
      });

      expect(authRepository.createUser).toHaveBeenCalledWith(
        expect.objectContaining({ displayName: 'Alice' }),
      );
    });
  });

  // -------------------------------------------------------------------------
  // signIn
  // -------------------------------------------------------------------------
  describe('signIn', () => {
    it('throws ForbiddenDomainError when user is not found', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      await expect(
        service.signIn({ email: 'unknown@example.com', password: 'Password1!' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when user has no password hash (OAuth-only account)', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(makeUser({ passwordHash: null })),
      });

      const service = buildService({ authRepository });
      await expect(
        service.signIn({ email: 'alice@example.com', password: 'Password1!' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when email is not verified', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(
          makeUser({ passwordHash: '$2a$01$invalid', emailVerified: false }),
        ),
      });

      const service = buildService({ authRepository });
      await expect(
        service.signIn({ email: 'alice@example.com', password: 'Password1!' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when password does not match', async () => {
      // Use a real bcrypt hash of 'Correct1!' with 1 salt round
      const { hash } = await import('bcryptjs');
      const passwordHash = await hash('Correct1!', 1);

      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(
          makeUser({ passwordHash, emailVerified: true }),
        ),
      });

      const service = buildService({ authRepository });
      await expect(
        service.signIn({ email: 'alice@example.com', password: 'Wrong1234!' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('returns access and refresh tokens on success', async () => {
      const { hash } = await import('bcryptjs');
      const password = 'Correct1!';
      const passwordHash = await hash(password, 1);

      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(
          makeUser({ passwordHash, emailVerified: true }),
        ),
        createRefreshToken: vi.fn().mockResolvedValue(makeRefreshRecord()),
      });

      const service = buildService({ authRepository });
      const result = await service.signIn({ email: 'alice@example.com', password }, meta);

      expect(result.accessToken).toBeTruthy();
      expect(result.refreshToken).toBeTruthy();
      expect(result.tokenType).toBe('Bearer');
    });
  });

  // -------------------------------------------------------------------------
  // signInWithFirebase
  // -------------------------------------------------------------------------
  describe('signInWithFirebase', () => {
    const makeDecodedToken = (overrides: Record<string, unknown> = {}) => ({
      uid: 'firebase-uid-1',
      email: 'alice@example.com',
      email_verified: true,
      name: 'Alice',
      picture: null,
      firebase: { sign_in_provider: 'google.com' },
      ...overrides,
    });

    it('throws ValidationDomainError for an unsupported OAuth provider', async () => {
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken({ firebase: { sign_in_provider: 'twitter.com' } }),
      );

      const service = buildService({ firebaseAuthService });
      await expect(
        service.signInWithFirebase({ idToken: 'valid-token' }, meta),
      ).rejects.toBeInstanceOf(ValidationDomainError);
    });

    it('throws ValidationDomainError when the OAuth profile has no email', async () => {
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken({ email: undefined }),
      );

      const service = buildService({ firebaseAuthService });
      await expect(
        service.signInWithFirebase({ idToken: 'valid-token' }, meta),
      ).rejects.toBeInstanceOf(ValidationDomainError);
    });

    it('throws ForbiddenDomainError when OAuth email is explicitly unverified', async () => {
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken({ email_verified: false }),
      );

      const service = buildService({ firebaseAuthService });
      await expect(
        service.signInWithFirebase({ idToken: 'valid-token' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('reuses the existing identity and issues tokens when already linked', async () => {
      const existingUser = makeUser();
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken(),
      );
      const authRepository = makeAuthRepository({
        findIdentity: vi.fn().mockResolvedValue({ user: existingUser }),
        createRefreshToken: vi.fn().mockResolvedValue(makeRefreshRecord()),
      });

      const service = buildService({ authRepository, firebaseAuthService });
      const result = await service.signInWithFirebase({ idToken: 'valid-token' }, meta);

      expect(authRepository.createUser).not.toHaveBeenCalled();
      expect(result.user.id).toBe(existingUser.id);
      expect(result.accessToken).toBeTruthy();
    });

    it('creates a new user and identity when no existing identity is found', async () => {
      const newUser = makeUser({ id: 'new-user-1' });
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken(),
      );
      const authRepository = makeAuthRepository({
        findIdentity: vi.fn().mockResolvedValue(null),
        findUserByEmail: vi.fn().mockResolvedValue(null),
        createUser: vi.fn().mockResolvedValue(newUser),
        createRefreshToken: vi.fn().mockResolvedValue(makeRefreshRecord()),
      });

      const service = buildService({ authRepository, firebaseAuthService });
      const result = await service.signInWithFirebase({ idToken: 'valid-token' }, meta);

      expect(authRepository.createUser).toHaveBeenCalledWith(
        expect.objectContaining({ email: 'alice@example.com', emailVerified: true }),
      );
      expect(authRepository.createIdentity).toHaveBeenCalledWith(
        expect.objectContaining({ provider: AuthProvider.firebase_google }),
      );
      expect(result.user.id).toBe(newUser.id);
    });

    it('links new identity to an existing email user', async () => {
      const existingEmailUser = makeUser({ emailVerified: false });
      const firebaseAuthService = makeFirebaseAuthService();
      (firebaseAuthService.verifyIdToken as ReturnType<typeof vi.fn>).mockResolvedValue(
        makeDecodedToken(),
      );
      const authRepository = makeAuthRepository({
        findIdentity: vi.fn().mockResolvedValue(null),
        findUserByEmail: vi.fn().mockResolvedValue(existingEmailUser),
        updateUser: vi.fn().mockResolvedValue({ ...existingEmailUser, emailVerified: true }),
        createRefreshToken: vi.fn().mockResolvedValue(makeRefreshRecord()),
      });

      const service = buildService({ authRepository, firebaseAuthService });
      await service.signInWithFirebase({ idToken: 'valid-token' }, meta);

      expect(authRepository.createUser).not.toHaveBeenCalled();
      expect(authRepository.updateUser).toHaveBeenCalledWith(
        existingEmailUser.id,
        { emailVerified: true },
      );
      expect(authRepository.createIdentity).toHaveBeenCalled();
    });
  });

  // -------------------------------------------------------------------------
  // confirmEmail
  // -------------------------------------------------------------------------
  describe('confirmEmail', () => {
    it('throws ForbiddenDomainError when token record is not found', async () => {
      const authRepository = makeAuthRepository({
        confirmEmailByTokenHash: vi.fn().mockResolvedValue('invalid'),
      });

      const service = buildService({ authRepository });
      await expect(service.confirmEmail({ token: 'bad-token' })).rejects.toBeInstanceOf(
        ForbiddenDomainError,
      );
    });

    it('throws ForbiddenDomainError when token has already been consumed', async () => {
      const authRepository = makeAuthRepository({
        confirmEmailByTokenHash: vi.fn().mockResolvedValue('invalid'),
      });

      const service = buildService({ authRepository });
      await expect(service.confirmEmail({ token: 'used-token' })).rejects.toBeInstanceOf(
        ForbiddenDomainError,
      );
    });

    it('throws ForbiddenDomainError when token has expired', async () => {
      const authRepository = makeAuthRepository({
        confirmEmailByTokenHash: vi.fn().mockResolvedValue('expired'),
      });

      const service = buildService({ authRepository });
      await expect(service.confirmEmail({ token: 'expired-token' })).rejects.toBeInstanceOf(
        ForbiddenDomainError,
      );
    });

    it('confirms the token through the repository transaction path', async () => {
      const authRepository = makeAuthRepository({
        confirmEmailByTokenHash: vi.fn().mockResolvedValue('confirmed'),
      });

      const service = buildService({ authRepository });
      const result = await service.confirmEmail({ token: 'valid-token' });

      expect(authRepository.confirmEmailByTokenHash).toHaveBeenCalledWith(
        expect.any(String),
        expect.any(Date),
      );
      expect(result.verified).toBe(true);
    });
  });

  // -------------------------------------------------------------------------
  // forgotPassword
  // -------------------------------------------------------------------------
  describe('forgotPassword', () => {
    it('returns { sent: true } without error when email is not registered', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      const result = await service.forgotPassword({ email: 'unknown@example.com' });

      expect(result.sent).toBe(true);
      expect(result.resetToken).toBeUndefined();
      expect(authRepository.createPasswordResetToken).not.toHaveBeenCalled();
    });

    it('issues a reset token for a known user in non-production', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({ authRepository, configService: makeConfigService('test') });
      const result = await service.forgotPassword({ email: 'alice@example.com' });

      expect(result.sent).toBe(true);
      expect(typeof result.resetToken).toBe('string');
      expect(authRepository.createPasswordResetToken).toHaveBeenCalled();
    });

    it('omits the reset token in production', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({
        authRepository,
        configService: makeConfigService('production', false),
      });
      const result = await service.forgotPassword({ email: 'alice@example.com' });

      expect(result.sent).toBe(true);
      expect(result.resetToken).toBeUndefined();
    });

    it('omits the reset token when debug token echo is disabled outside test mode', async () => {
      const authRepository = makeAuthRepository({
        findUserByEmail: vi.fn().mockResolvedValue(makeUser()),
      });

      const service = buildService({
        authRepository,
        configService: makeConfigService('development', false),
      });
      const result = await service.forgotPassword({ email: 'alice@example.com' });

      expect(result.sent).toBe(true);
      expect(result.resetToken).toBeUndefined();
    });
  });

  // -------------------------------------------------------------------------
  // resetPassword
  // -------------------------------------------------------------------------
  describe('resetPassword', () => {
    it('throws ForbiddenDomainError when token record is not found', async () => {
      const authRepository = makeAuthRepository({
        resetPasswordByTokenHash: vi.fn().mockResolvedValue('invalid'),
      });

      const service = buildService({ authRepository });
      await expect(
        service.resetPassword({ token: 'bad-token', password: 'NewPass1!' }),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when token has already been consumed', async () => {
      const authRepository = makeAuthRepository({
        resetPasswordByTokenHash: vi.fn().mockResolvedValue('invalid'),
      });

      const service = buildService({ authRepository });
      await expect(
        service.resetPassword({ token: 'used-token', password: 'NewPass1!' }),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when token has expired', async () => {
      const authRepository = makeAuthRepository({
        resetPasswordByTokenHash: vi.fn().mockResolvedValue('expired'),
      });

      const service = buildService({ authRepository });
      await expect(
        service.resetPassword({ token: 'expired-token', password: 'NewPass1!' }),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('resets the password through the repository transaction path', async () => {
      const authRepository = makeAuthRepository({
        resetPasswordByTokenHash: vi.fn().mockResolvedValue('reset'),
      });

      const service = buildService({ authRepository });
      const result = await service.resetPassword({ token: 'valid-token', password: 'NewPass1!' });

      expect(authRepository.resetPasswordByTokenHash).toHaveBeenCalledWith(
        expect.objectContaining({
          tokenHash: expect.any(String),
          passwordHash: expect.stringMatching(/^\$2/),
          now: expect.any(Date),
        }),
      );
      expect(result.reset).toBe(true);
    });
  });

  // -------------------------------------------------------------------------
  // refresh
  // -------------------------------------------------------------------------
  describe('refresh', () => {
    it('throws ForbiddenDomainError when the token record is not found', async () => {
      const authRepository = makeAuthRepository({
        rotateRefreshToken: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      await expect(
        service.refresh({ refreshToken: 'unknown-token' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when the refresh token has already been revoked', async () => {
      const authRepository = makeAuthRepository({
        rotateRefreshToken: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      await expect(
        service.refresh({ refreshToken: 'revoked-token' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('throws ForbiddenDomainError when the refresh token has expired', async () => {
      const authRepository = makeAuthRepository({
        rotateRefreshToken: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      await expect(
        service.refresh({ refreshToken: 'expired-token' }, meta),
      ).rejects.toBeInstanceOf(ForbiddenDomainError);
    });

    it('issues new tokens through the repository rotation path', async () => {
      const user = makeUser();
      const newRecord = { ...makeRefreshRecord({ id: 'refresh-rec-2' }) };

      const authRepository = makeAuthRepository({
        rotateRefreshToken: vi
          .fn()
          .mockResolvedValue({ user, refreshRecord: newRecord }),
      });

      const service = buildService({ authRepository });
      const result = await service.refresh({ refreshToken: 'valid-token' }, meta);

      expect(authRepository.rotateRefreshToken).toHaveBeenCalledWith(
        expect.objectContaining({
          tokenHash: expect.any(String),
          now: expect.any(Date),
          nextRefreshToken: expect.objectContaining({
            tokenHash: expect.any(String),
            expiresAt: expect.any(Date),
            ipAddress: meta.ipAddress,
            userAgent: meta.userAgent,
          }),
        }),
      );
      expect(result.accessToken).toBeTruthy();
      expect(result.refreshToken).toBeTruthy();
      expect(result.tokenType).toBe('Bearer');
    });
  });

  // -------------------------------------------------------------------------
  // signOut
  // -------------------------------------------------------------------------
  describe('signOut', () => {
    it('returns { revoked: false } when the token is not found', async () => {
      const authRepository = makeAuthRepository({
        findRefreshTokenByHash: vi.fn().mockResolvedValue(null),
      });

      const service = buildService({ authRepository });
      const result = await service.signOut({ refreshToken: 'unknown-token' });

      expect(result.revoked).toBe(false);
      expect(authRepository.revokeRefreshToken).not.toHaveBeenCalled();
    });

    it('returns { revoked: false } when the token is already revoked', async () => {
      const authRepository = makeAuthRepository({
        findRefreshTokenByHash: vi.fn().mockResolvedValue(
          makeRefreshRecord({ revokedAt: new Date() }),
        ),
      });

      const service = buildService({ authRepository });
      const result = await service.signOut({ refreshToken: 'already-revoked' });

      expect(result.revoked).toBe(false);
      expect(authRepository.revokeRefreshToken).not.toHaveBeenCalled();
    });

    it('revokes the token and returns { revoked: true }', async () => {
      const authRepository = makeAuthRepository({
        findRefreshTokenByHash: vi.fn().mockResolvedValue(makeRefreshRecord()),
      });

      const service = buildService({ authRepository });
      const result = await service.signOut({ refreshToken: 'active-token' });

      expect(authRepository.revokeRefreshToken).toHaveBeenCalledWith(
        'refresh-rec-1',
        expect.any(Date),
      );
      expect(result.revoked).toBe(true);
    });
  });
});
