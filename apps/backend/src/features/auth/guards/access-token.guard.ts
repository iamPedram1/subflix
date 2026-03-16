import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

import { AUTHORIZATION_HEADER } from 'common/http/constants/request-context.constants';
import { RequestWithContext } from 'common/http/types/request-context';
import { AuthRepository } from 'features/auth/auth.repository';
import type { AuthTokenPayload } from 'features/auth/auth.types';

const BEARER_PREFIX = 'Bearer ';

@Injectable()
/** Validates access tokens and attaches the authenticated user to the request. */
export class AccessTokenGuard implements CanActivate {
  constructor(
    private readonly jwtService: JwtService,
    private readonly authRepository: AuthRepository,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const headerValue = request.header(AUTHORIZATION_HEADER);

    if (!headerValue?.startsWith(BEARER_PREFIX)) {
      throw new UnauthorizedException('Missing Authorization header.');
    }

    const token = headerValue.slice(BEARER_PREFIX.length).trim();
    if (!token) {
      throw new UnauthorizedException('Missing access token.');
    }

    let payload: AuthTokenPayload;
    try {
      payload = await this.jwtService.verifyAsync<AuthTokenPayload>(token);
    } catch {
      throw new UnauthorizedException('Invalid access token.');
    }

    if (payload.tokenType !== 'access' || !payload.sub) {
      throw new UnauthorizedException('Invalid access token.');
    }

    const user = await this.authRepository.findUserById(payload.sub);
    if (!user) {
      throw new UnauthorizedException('Invalid access token.');
    }

    request.user = user;
    return true;
  }
}
