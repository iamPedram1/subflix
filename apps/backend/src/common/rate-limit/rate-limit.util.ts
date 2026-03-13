import { createHash } from 'node:crypto';

import type { Request } from 'express';

import { DEVICE_ID_HEADER } from 'src/common/http/constants/request-context.constants';
import { requireSafeDeviceId } from 'src/common/http/utils/request-header.util';

const normalizeIpValue = (value: string | undefined): string | null => {
  const candidate = value?.trim();
  return candidate ? candidate.slice(0, 256) : null;
};

const hashActorPart = (value: string): string =>
  createHash('sha256').update(value).digest('hex');

/** Resolves stable actor keys for rate limiting from both client IP and device identity when available. */
export const resolveRateLimitActors = (request: Request): string[] => {
  const ip =
    normalizeIpValue(request.ip) ??
    normalizeIpValue(request.socket.remoteAddress) ??
    'unknown';
  const actors = [`ip:${hashActorPart(ip)}`];

  try {
    const deviceId = requireSafeDeviceId(request.header(DEVICE_ID_HEADER));
    actors.push(`device:${hashActorPart(deviceId)}`);
  } catch {
    // Public routes or malformed ownership headers fall back to IP throttling only.
  }

  return actors;
};
