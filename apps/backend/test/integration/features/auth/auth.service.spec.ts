import { Test } from '@nestjs/testing';
import { JwtModule } from '@nestjs/jwt';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import {
  ConflictDomainError,
  ForbiddenDomainError,
} from 'common/domain/errors/domain.error';
import { AuthRepository } from 'features/auth/auth.repository';
import { AuthService } from 'features/auth/auth.service';
import { FirebaseAuthService } from 'features/auth/firebase-auth.service';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

const meta = { ipAddress: '127.0.0.1', userAgent: 'Integration/Test' };

describeIfDatabase('AuthService integration', () => {
  let prisma: PrismaService;
  let service: AuthService;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [
        AppConfigModule,
        PrismaModule,
        JwtModule.register({ secret: 'test-jwt-secret-integration' }),
      ],
      providers: [AuthService, AuthRepository, FirebaseAuthService],
    }).compile();

    prisma = moduleRef.get(PrismaService);
    service = moduleRef.get(AuthService);
  });

  beforeEach(async () => {
    await resetDatabase(prisma);
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  // -------------------------------------------------------------------------
  // signUp
  // -------------------------------------------------------------------------

  it('registers a new user, requires email verification, and returns a token in non-production', async () => {
    const result = await service.signUp(
      { email: 'alice@example.com', password: 'Password1!', displayName: 'Alice' },
    );

    expect(result.verificationRequired).toBe(true);
    expect(typeof result.verificationToken).toBe('string');
    expect(result.user.email).toBe('alice@example.com');
    expect(result.user.displayName).toBe('Alice');
    expect(result.user.emailVerified).toBe(false);
  });

  it('normalizes the email to lowercase before persisting', async () => {
    await service.signUp({ email: '  ALICE@EXAMPLE.COM  ', password: 'Password1!' });

    const user = await prisma.user.findUnique({ where: { email: 'alice@example.com' } });
    expect(user).not.toBeNull();
  });

  it('throws ConflictDomainError when the email is already registered', async () => {
    await service.signUp({ email: 'bob@example.com', password: 'Password1!' });

    await expect(
      service.signUp({ email: 'bob@example.com', password: 'Password1!' }),
    ).rejects.toBeInstanceOf(ConflictDomainError);
  });

  // -------------------------------------------------------------------------
  // confirmEmail
  // -------------------------------------------------------------------------

  it('marks the user as verified after confirming the email token', async () => {
    const signUpResult = await service.signUp(
      { email: 'carol@example.com', password: 'Password1!' },
    );
    const token = signUpResult.verificationToken!;

    const confirmResult = await service.confirmEmail({ token });

    expect(confirmResult.verified).toBe(true);

    const user = await prisma.user.findUnique({ where: { email: 'carol@example.com' } });
    expect(user!.emailVerified).toBe(true);
  });

  it('rejects a verification token that has already been consumed', async () => {
    const signUpResult = await service.signUp(
      { email: 'dave@example.com', password: 'Password1!' },
    );
    const token = signUpResult.verificationToken!;

    await service.confirmEmail({ token });

    await expect(service.confirmEmail({ token })).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  it('allows only one concurrent email confirmation for the same token', async () => {
    const signUpResult = await service.signUp(
      { email: 'dave-race@example.com', password: 'Password1!' },
    );
    const token = signUpResult.verificationToken!;

    const results = await Promise.allSettled([
      service.confirmEmail({ token }),
      service.confirmEmail({ token }),
    ]);

    expect(results.filter((result) => result.status === 'fulfilled')).toHaveLength(1);
    expect(results.filter((result) => result.status === 'rejected')).toHaveLength(1);
  });

  // -------------------------------------------------------------------------
  // signIn
  // -------------------------------------------------------------------------

  it('throws ForbiddenDomainError when signing in before email verification', async () => {
    await service.signUp({ email: 'eve@example.com', password: 'Password1!' });

    await expect(
      service.signIn({ email: 'eve@example.com', password: 'Password1!' }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  it('issues access and refresh tokens after email verification', async () => {
    const signUpResult = await service.signUp(
      { email: 'frank@example.com', password: 'Password1!' },
    );
    await service.confirmEmail({ token: signUpResult.verificationToken! });

    const signInResult = await service.signIn(
      { email: 'frank@example.com', password: 'Password1!' },
      meta,
    );

    expect(signInResult.accessToken).toBeTruthy();
    expect(signInResult.refreshToken).toBeTruthy();
    expect(signInResult.user.email).toBe('frank@example.com');
    expect(signInResult.tokenType).toBe('Bearer');
  });

  it('throws ForbiddenDomainError for an incorrect password', async () => {
    const signUpResult = await service.signUp(
      { email: 'grace@example.com', password: 'Password1!' },
    );
    await service.confirmEmail({ token: signUpResult.verificationToken! });

    await expect(
      service.signIn({ email: 'grace@example.com', password: 'WrongPass9!' }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  // -------------------------------------------------------------------------
  // refresh
  // -------------------------------------------------------------------------

  it('rotates the refresh token on use and rejects the old one', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'henry@example.com', password: 'Password1!' },
    );
    await service.confirmEmail({ token: verificationToken! });
    const { refreshToken: originalToken } = await service.signIn(
      { email: 'henry@example.com', password: 'Password1!' },
      meta,
    );

    const refreshResult = await service.refresh({ refreshToken: originalToken }, meta);

    expect(refreshResult.refreshToken).not.toBe(originalToken);
    expect(refreshResult.accessToken).toBeTruthy();

    await expect(
      service.refresh({ refreshToken: originalToken }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  it('allows only one concurrent refresh for the same refresh token', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'henry-race@example.com', password: 'Password1!' },
    );
    await service.confirmEmail({ token: verificationToken! });
    const { refreshToken } = await service.signIn(
      { email: 'henry-race@example.com', password: 'Password1!' },
      meta,
    );

    const results = await Promise.allSettled([
      service.refresh({ refreshToken }, meta),
      service.refresh({ refreshToken }, meta),
    ]);

    expect(results.filter((result) => result.status === 'fulfilled')).toHaveLength(1);
    expect(results.filter((result) => result.status === 'rejected')).toHaveLength(1);
  });

  // -------------------------------------------------------------------------
  // signOut
  // -------------------------------------------------------------------------

  it('revokes the refresh token on sign-out so it cannot be reused', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'iris@example.com', password: 'Password1!' },
    );
    await service.confirmEmail({ token: verificationToken! });
    const { refreshToken } = await service.signIn(
      { email: 'iris@example.com', password: 'Password1!' },
      meta,
    );

    const signOutResult = await service.signOut({ refreshToken });
    expect(signOutResult.revoked).toBe(true);

    await expect(
      service.refresh({ refreshToken }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  it('returns { revoked: false } when signing out with an unknown token', async () => {
    const result = await service.signOut({ refreshToken: 'completely-unknown-token' });
    expect(result.revoked).toBe(false);
  });

  // -------------------------------------------------------------------------
  // forgotPassword / resetPassword
  // -------------------------------------------------------------------------

  it('returns sent:true without error for an unknown email (prevents user enumeration)', async () => {
    const result = await service.forgotPassword({ email: 'nobody@example.com' });
    expect(result.sent).toBe(true);
    expect(result.resetToken).toBeUndefined();
  });

  it('allows signing in with a new password after a successful reset', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'jake@example.com', password: 'OldPass1!' },
    );
    await service.confirmEmail({ token: verificationToken! });

    const { resetToken } = await service.forgotPassword({ email: 'jake@example.com' });
    expect(resetToken).toBeTruthy();

    await service.resetPassword({ token: resetToken!, password: 'NewPass2!' });

    // old password no longer works
    await expect(
      service.signIn({ email: 'jake@example.com', password: 'OldPass1!' }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);

    // new password works
    const signInResult = await service.signIn(
      { email: 'jake@example.com', password: 'NewPass2!' },
      meta,
    );
    expect(signInResult.accessToken).toBeTruthy();
  });

  it('allows only one concurrent password reset for the same token', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'jake-race@example.com', password: 'OldPass1!' },
    );
    await service.confirmEmail({ token: verificationToken! });

    const { resetToken } = await service.forgotPassword({
      email: 'jake-race@example.com',
    });
    expect(resetToken).toBeTruthy();

    const results = await Promise.allSettled([
      service.resetPassword({ token: resetToken!, password: 'NewPass2!' }),
      service.resetPassword({ token: resetToken!, password: 'OtherPass3!' }),
    ]);

    expect(results.filter((result) => result.status === 'fulfilled')).toHaveLength(1);
    expect(results.filter((result) => result.status === 'rejected')).toHaveLength(1);
  });

  it('revokes all active sessions when the password is reset', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'karen@example.com', password: 'OldPass1!' },
    );
    await service.confirmEmail({ token: verificationToken! });

    const { refreshToken } = await service.signIn(
      { email: 'karen@example.com', password: 'OldPass1!' },
      meta,
    );

    const { resetToken } = await service.forgotPassword({ email: 'karen@example.com' });
    await service.resetPassword({ token: resetToken!, password: 'NewPass2!' });

    // the refresh token issued before the reset should now be invalid
    await expect(
      service.refresh({ refreshToken }, meta),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });

  it('rejects a password reset token that has already been consumed', async () => {
    const { verificationToken } = await service.signUp(
      { email: 'lena@example.com', password: 'OldPass1!' },
    );
    await service.confirmEmail({ token: verificationToken! });

    const { resetToken } = await service.forgotPassword({ email: 'lena@example.com' });
    await service.resetPassword({ token: resetToken!, password: 'NewPass2!' });

    await expect(
      service.resetPassword({ token: resetToken!, password: 'AnotherPass3!' }),
    ).rejects.toBeInstanceOf(ForbiddenDomainError);
  });
});
