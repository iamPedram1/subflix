import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { AuthProvider } from '@prisma/client';
import { compare, hash } from 'bcryptjs';
import { createHash, randomBytes } from 'node:crypto';

import {
  ConflictDomainError,
  ForbiddenDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';

import { AuthRepository } from 'features/auth/auth.repository';
import { toAuthUser } from 'features/auth/auth.mapper';
import { FirebaseAuthService } from 'features/auth/firebase-auth.service';
import type {
  AuthResponse,
  AuthForgotPasswordResponse,
  AuthSignUpResponse,
  AuthTokenPayload,
  RequestMeta,
} from 'features/auth/auth.types';
import { AuthSignInDto } from 'features/auth/dto/auth-signin.dto';
import { AuthSignUpDto } from 'features/auth/dto/auth-signup.dto';
import { AuthRefreshDto } from 'features/auth/dto/auth-refresh.dto';
import { AuthFirebaseDto } from 'features/auth/dto/auth-firebase.dto';
import { AuthConfirmEmailDto } from 'features/auth/dto/auth-confirm-email.dto';
import { AuthForgotPasswordDto } from 'features/auth/dto/auth-forgot-password.dto';
import { AuthResetPasswordDto } from 'features/auth/dto/auth-reset-password.dto';
import type { User } from '@prisma/client';

const FIREBASE_PROVIDER_MAP: Record<string, AuthProvider> = {
  'google.com': AuthProvider.firebase_google,
  'facebook.com': AuthProvider.firebase_facebook,
  'apple.com': AuthProvider.firebase_apple,
};

@Injectable()
/** Orchestrates email/password and Firebase OAuth authentication flows. */
export class AuthService {
  private readonly accessTokenTtlSeconds: number;
  private readonly refreshTokenTtlDays: number;
  private readonly bcryptSaltRounds: number;
  private readonly emailVerificationTokenTtlHours: number;
  private readonly passwordResetTokenTtlHours: number;
  private readonly nodeEnv: string;

  constructor(
    private readonly authRepository: AuthRepository,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
    private readonly firebaseAuthService: FirebaseAuthService,
  ) {
    this.accessTokenTtlSeconds =
      this.configService.get<number>('auth.accessTokenTtlSeconds') ?? 900;
    this.refreshTokenTtlDays =
      this.configService.get<number>('auth.refreshTokenTtlDays') ?? 30;
    this.emailVerificationTokenTtlHours =
      this.configService.get<number>('auth.emailVerificationTokenTtlHours') ??
      24;
    this.passwordResetTokenTtlHours =
      this.configService.get<number>('auth.passwordResetTokenTtlHours') ?? 2;
    this.bcryptSaltRounds =
      this.configService.get<number>('auth.bcryptSaltRounds') ?? 12;
    this.nodeEnv = this.configService.get<string>('app.nodeEnv') ?? 'development';
  }

  /** Registers a new user with email and password. */
  async signUp(
    input: AuthSignUpDto,
    _meta: RequestMeta,
  ): Promise<AuthSignUpResponse> {
    const email = this.normalizeEmail(input.email);
    const existing = await this.authRepository.findUserByEmail(email);
    if (existing) {
      throw new ConflictDomainError('Email is already registered.');
    }

    const passwordHash = await hash(input.password, this.bcryptSaltRounds);
    const displayName = input.displayName?.trim();

    const user = await this.authRepository.createUser({
      email,
      passwordHash,
      ...(displayName ? { displayName } : {}),
      emailVerified: false,
    });

    await this.authRepository.createIdentity({
      provider: AuthProvider.email,
      providerUserId: email,
      email,
      user: { connect: { id: user.id } },
    });

    const verificationToken = await this.issueEmailVerification(user);

    return {
      user: toAuthUser(user),
      verificationRequired: true,
      ...(verificationToken ? { verificationToken } : {}),
    };
  }

  /** Signs in a user using email and password. */
  async signIn(input: AuthSignInDto, meta: RequestMeta): Promise<AuthResponse> {
    const email = this.normalizeEmail(input.email);
    const user = await this.authRepository.findUserByEmail(email);

    if (!user?.passwordHash) {
      throw new ForbiddenDomainError('Invalid email or password.');
    }

    if (!user.emailVerified) {
      throw new ForbiddenDomainError('Email is not verified.');
    }

    const passwordMatches = await compare(input.password, user.passwordHash);
    if (!passwordMatches) {
      throw new ForbiddenDomainError('Invalid email or password.');
    }

    return this.issueTokens(user, meta);
  }

  /** Signs in or registers a user using a Firebase OAuth id token. */
  async signInWithFirebase(
    input: AuthFirebaseDto,
    meta: RequestMeta,
  ): Promise<AuthResponse> {
    const decoded = await this.firebaseAuthService.verifyIdToken(input.idToken);
    const providerKey = decoded.firebase?.sign_in_provider ?? '';
    const provider = FIREBASE_PROVIDER_MAP[providerKey];

    if (!provider) {
      throw new ValidationDomainError('Unsupported OAuth provider.');
    }

    const email = decoded.email ? this.normalizeEmail(decoded.email) : '';
    if (!email) {
      throw new ValidationDomainError('OAuth profile did not include an email.');
    }

    if (decoded.email_verified === false) {
      throw new ForbiddenDomainError('OAuth email is not verified.');
    }

    const existingIdentity = await this.authRepository.findIdentity(
      provider,
      decoded.uid,
    );

    if (existingIdentity) {
      const user = existingIdentity.user;
      if (decoded.email_verified && !user.emailVerified) {
        await this.authRepository.updateUser(user.id, { emailVerified: true });
      }
      return this.issueTokens(user, meta);
    }

    let user = await this.authRepository.findUserByEmail(email);
    if (!user) {
      user = await this.authRepository.createUser({
        email,
        displayName: decoded.name ?? undefined,
        photoUrl: decoded.picture ?? undefined,
        emailVerified: decoded.email_verified ?? false,
      });
    } else if (decoded.email_verified && !user.emailVerified) {
      user = await this.authRepository.updateUser(user.id, {
        emailVerified: true,
      });
    }

    await this.authRepository.createIdentity({
      provider,
      providerUserId: decoded.uid,
      email,
      user: { connect: { id: user.id } },
    });

    return this.issueTokens(user, meta);
  }

  /** Confirms a user's email using a verification token. */
  async confirmEmail(input: AuthConfirmEmailDto): Promise<{ verified: boolean }> {
    const tokenHash = this.hashToken(input.token);
    const record =
      await this.authRepository.findEmailVerificationTokenByHash(tokenHash);

    if (!record || record.consumedAt) {
      throw new ForbiddenDomainError('Invalid verification token.');
    }

    const now = new Date();
    if (record.expiresAt <= now) {
      throw new ForbiddenDomainError('Verification token has expired.');
    }

    const user = record.user;
    if (!user) {
      throw new ForbiddenDomainError('Invalid verification token.');
    }

    if (!user.emailVerified) {
      await this.authRepository.updateUser(user.id, { emailVerified: true });
    }
    await this.authRepository.consumeEmailVerificationToken(record.id, now);

    return { verified: true };
  }

  /** Starts the password reset flow for a user. */
  async forgotPassword(
    input: AuthForgotPasswordDto,
  ): Promise<AuthForgotPasswordResponse> {
    const email = this.normalizeEmail(input.email);
    const user = await this.authRepository.findUserByEmail(email);

    if (!user) {
      return { sent: true };
    }

    const resetToken = await this.issuePasswordReset(user);
    return {
      sent: true,
      ...(resetToken ? { resetToken } : {}),
    };
  }

  /** Resets a user's password using a reset token. */
  async resetPassword(input: AuthResetPasswordDto): Promise<{ reset: boolean }> {
    const tokenHash = this.hashToken(input.token);
    const record =
      await this.authRepository.findPasswordResetTokenByHash(tokenHash);

    if (!record || record.consumedAt) {
      throw new ForbiddenDomainError('Invalid reset token.');
    }

    const now = new Date();
    if (record.expiresAt <= now) {
      throw new ForbiddenDomainError('Reset token has expired.');
    }

    const user = record.user;
    if (!user) {
      throw new ForbiddenDomainError('Invalid reset token.');
    }

    const passwordHash = await hash(input.password, this.bcryptSaltRounds);
    await this.authRepository.updateUser(user.id, { passwordHash });
    await this.authRepository.consumePasswordResetToken(record.id, now);
    await this.authRepository.revokeAllRefreshTokensForUser(user.id, now);

    return { reset: true };
  }

  /** Refreshes the access token using a valid refresh token. */
  async refresh(input: AuthRefreshDto, meta: RequestMeta): Promise<AuthResponse> {
    const tokenHash = this.hashToken(input.refreshToken);
    const record = await this.authRepository.findRefreshTokenByHash(tokenHash);

    if (!record || record.revokedAt) {
      throw new ForbiddenDomainError('Invalid refresh token.');
    }

    const now = new Date();
    if (record.expiresAt <= now) {
      throw new ForbiddenDomainError('Refresh token has expired.');
    }

    const user = record.user;
    if (!user) {
      throw new ForbiddenDomainError('Invalid refresh token.');
    }

    const { refreshToken, refreshRecord } = await this.createRefreshToken(
      user,
      meta,
    );
    await this.authRepository.revokeRefreshToken(record.id, now);

    const accessToken = this.createAccessToken(user, refreshRecord.id);

    return {
      user: toAuthUser(user),
      accessToken,
      refreshToken,
      expiresIn: this.accessTokenTtlSeconds,
      tokenType: 'Bearer',
    };
  }

  /** Revokes a refresh token explicitly (logout). */
  async signOut(input: AuthRefreshDto): Promise<{ revoked: boolean }> {
    const tokenHash = this.hashToken(input.refreshToken);
    const record = await this.authRepository.findRefreshTokenByHash(tokenHash);

    if (!record || record.revokedAt) {
      return { revoked: false };
    }

    await this.authRepository.revokeRefreshToken(record.id, new Date());
    return { revoked: true };
  }

  private async issueTokens(user: User, meta: RequestMeta): Promise<AuthResponse> {
    const { refreshToken, refreshRecord } = await this.createRefreshToken(
      user,
      meta,
    );
    const accessToken = this.createAccessToken(user, refreshRecord.id);

    return {
      user: toAuthUser(user),
      accessToken,
      refreshToken,
      expiresIn: this.accessTokenTtlSeconds,
      tokenType: 'Bearer',
    };
  }

  private createAccessToken(user: User, sessionId: string): string {
    const payload: AuthTokenPayload = {
      sub: user.id,
      email: user.email,
      tokenType: 'access',
      sessionId,
    };

    return this.jwtService.sign(payload, {
      expiresIn: this.accessTokenTtlSeconds,
    });
  }

  private async createRefreshToken(user: User, meta: RequestMeta) {
    const refreshToken = randomBytes(64).toString('base64url');
    const tokenHash = this.hashToken(refreshToken);
    const expiresAt = new Date(
      Date.now() + this.refreshTokenTtlDays * 24 * 60 * 60_000,
    );

    const refreshRecord = await this.authRepository.createRefreshToken({
      userId: user.id,
      tokenHash,
      expiresAt,
      ...(meta.ipAddress ? { ipAddress: meta.ipAddress } : {}),
      ...(meta.userAgent ? { userAgent: meta.userAgent } : {}),
    });

    return { refreshToken, refreshRecord };
  }

  private normalizeEmail(value: string): string {
    const normalized = value.trim().toLowerCase();
    if (!normalized) {
      throw new ValidationDomainError('Email is required.');
    }

    return normalized;
  }

  private hashToken(value: string): string {
    return createHash('sha256').update(value).digest('hex');
  }

  private isProduction(): boolean {
    return this.nodeEnv === 'production';
  }

  private async issueEmailVerification(user: User): Promise<string | undefined> {
    await this.authRepository.clearEmailVerificationTokens(user.id);

    const token = randomBytes(32).toString('base64url');
    const tokenHash = this.hashToken(token);
    const expiresAt = new Date(
      Date.now() + this.emailVerificationTokenTtlHours * 60 * 60_000,
    );

    await this.authRepository.createEmailVerificationToken({
      userId: user.id,
      tokenHash,
      expiresAt,
    });

    return this.isProduction() ? undefined : token;
  }

  private async issuePasswordReset(user: User): Promise<string | undefined> {
    await this.authRepository.clearPasswordResetTokens(user.id);

    const token = randomBytes(32).toString('base64url');
    const tokenHash = this.hashToken(token);
    const expiresAt = new Date(
      Date.now() + this.passwordResetTokenTtlHours * 60 * 60_000,
    );

    await this.authRepository.createPasswordResetToken({
      userId: user.id,
      tokenHash,
      expiresAt,
    });

    return this.isProduction() ? undefined : token;
  }
}
