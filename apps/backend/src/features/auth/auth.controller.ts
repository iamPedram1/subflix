import {
  Body,
  Controller,
  Get,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import type { Request } from 'express';

import { RateLimit } from 'common/rate-limit/rate-limit.decorator';
import { CurrentUser } from 'common/http/decorators/current-user.decorator';

import { AuthService } from 'features/auth/auth.service';
import { AuthSignUpDto } from 'features/auth/dto/auth-signup.dto';
import { AuthSignInDto } from 'features/auth/dto/auth-signin.dto';
import { AuthRefreshDto } from 'features/auth/dto/auth-refresh.dto';
import { AuthFirebaseDto } from 'features/auth/dto/auth-firebase.dto';
import { AccessTokenGuard } from 'features/auth/guards/access-token.guard';
import { toAuthUser } from 'features/auth/auth.mapper';
import type { RequestMeta } from 'features/auth/auth.types';
import type { User } from '@prisma/client';

@Controller('auth')
/** Handles authentication routes for email/password and OAuth flows. */
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  /** Registers a new user with email and password. */
  @Post('signup')
  @RateLimit({ limit: 10, windowMs: 15 * 60_000, key: 'auth-signup' })
  signUp(@Body() body: AuthSignUpDto, @Req() request: Request) {
    return this.authService.signUp(body, this.getRequestMeta(request));
  }

  /** Signs in a user with email and password. */
  @Post('signin')
  @RateLimit({ limit: 20, windowMs: 10 * 60_000, key: 'auth-signin' })
  signIn(@Body() body: AuthSignInDto, @Req() request: Request) {
    return this.authService.signIn(body, this.getRequestMeta(request));
  }

  /** Issues a new access token using a refresh token. */
  @Post('refresh')
  @RateLimit({ limit: 30, windowMs: 10 * 60_000, key: 'auth-refresh' })
  refresh(@Body() body: AuthRefreshDto, @Req() request: Request) {
    return this.authService.refresh(body, this.getRequestMeta(request));
  }

  /** Signs in or registers a user using a Firebase id token. */
  @Post('oauth/firebase')
  @RateLimit({ limit: 20, windowMs: 10 * 60_000, key: 'auth-firebase' })
  signInWithFirebase(@Body() body: AuthFirebaseDto, @Req() request: Request) {
    return this.authService.signInWithFirebase(
      body,
      this.getRequestMeta(request),
    );
  }

  /** Revokes a refresh token (sign out). */
  @Post('signout')
  signOut(@Body() body: AuthRefreshDto) {
    return this.authService.signOut(body);
  }

  /** Returns the current authenticated user profile. */
  @Get('me')
  @UseGuards(AccessTokenGuard)
  getProfile(@CurrentUser() user: User) {
    return { user: toAuthUser(user) };
  }

  private getRequestMeta(request: Request): RequestMeta {
    return {
      ipAddress: request.ip ?? request.socket.remoteAddress ?? undefined,
      userAgent: request.header('user-agent') ?? undefined,
    };
  }
}
