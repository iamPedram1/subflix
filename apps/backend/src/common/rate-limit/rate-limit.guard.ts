import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Reflector } from '@nestjs/core';
import type { Request, Response } from 'express';

import { TooManyRequestsDomainError } from 'common/domain/errors/domain.error';

import {
  RATE_LIMIT_METADATA_KEY,
  SKIP_RATE_LIMIT_METADATA_KEY,
} from 'common/rate-limit/rate-limit.constants';
import type { RateLimitOptions } from 'common/rate-limit/rate-limit.decorator';
import {
  RateLimitService,
  type RateLimitDecision,
} from 'common/rate-limit/rate-limit.service';
import { resolveRateLimitActors } from 'common/rate-limit/rate-limit.util';

/** Applies global and per-route request throttling using an in-memory fixed-window store. */
@Injectable()
export class RateLimitGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly configService: ConfigService,
    private readonly rateLimitService: RateLimitService,
  ) {}

  canActivate(context: ExecutionContext): boolean {
    const shouldSkip = this.reflector.getAllAndOverride<boolean>(
      SKIP_RATE_LIMIT_METADATA_KEY,
      [context.getHandler(), context.getClass()],
    );
    if (shouldSkip) {
      return true;
    }

    const request = context.switchToHttp().getRequest<Request>();
    const response = context.switchToHttp().getResponse<Response>();
    const options = this.resolveOptions(context);
    const scope = options.key ?? this.buildScopeKey(context);
    const decisions = resolveRateLimitActors(request).map((actor) =>
      this.rateLimitService.consume({
        key: `${scope}:${actor}`,
        limit: options.limit,
        windowMs: options.windowMs,
      }),
    );
    const blockedDecision = decisions.find((decision) => !decision.allowed);
    const headerDecision = this.pickHeaderDecision(decisions);

    this.applyHeaders(response, headerDecision);

    if (blockedDecision) {
      throw new TooManyRequestsDomainError(
        'Too many requests. Please try again later.',
        {
          limit: blockedDecision.limit,
          retryAfterSeconds: blockedDecision.retryAfterSeconds,
          resetAt: new Date(blockedDecision.resetAt).toISOString(),
          scope,
        },
        {
          key: 'errors.rate_limited',
        },
      );
    }

    return true;
  }

  private resolveOptions(context: ExecutionContext): RateLimitOptions {
    const routeOptions =
      this.reflector.getAllAndOverride<RateLimitOptions>(
        RATE_LIMIT_METADATA_KEY,
        [context.getHandler(), context.getClass()],
      ) ?? ({} as Partial<RateLimitOptions>);

    return {
      limit:
        routeOptions.limit ??
        this.configService.get<number>('app.rateLimitDefaultLimit') ??
        120,
      windowMs:
        routeOptions.windowMs ??
        this.configService.get<number>('app.rateLimitDefaultWindowMs') ??
        60_000,
      ...(routeOptions.key ? { key: routeOptions.key } : {}),
    };
  }

  private buildScopeKey(context: ExecutionContext): string {
    return `${context.getClass().name}:${context.getHandler().name}`;
  }

  private pickHeaderDecision(
    decisions: RateLimitDecision[],
  ): RateLimitDecision {
    return decisions.reduce((lowest, decision) =>
      decision.remaining < lowest.remaining ? decision : lowest,
    );
  }

  private applyHeaders(response: Response, decision: RateLimitDecision): void {
    response.setHeader('RateLimit-Limit', String(decision.limit));
    response.setHeader('RateLimit-Remaining', String(decision.remaining));
    response.setHeader(
      'RateLimit-Reset',
      String(Math.ceil(decision.resetAt / 1000)),
    );

    if (!decision.allowed) {
      response.setHeader('Retry-After', String(decision.retryAfterSeconds));
    }
  }
}
