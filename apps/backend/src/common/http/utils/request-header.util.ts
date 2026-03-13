import { BadRequestException } from '@nestjs/common';
import { randomUUID } from 'node:crypto';

import {
  DEVICE_ID_HEADER,
  HEADER_TOKEN_PATTERN,
  MAX_DEVICE_ID_LENGTH,
  MAX_REQUEST_ID_LENGTH,
} from '../constants/request-context.constants';

const normalizeHeaderToken = (value: string | undefined): string | null => {
  const candidate = value?.trim();

  if (!candidate) {
    return null;
  }

  if (
    candidate.length > MAX_REQUEST_ID_LENGTH ||
    !HEADER_TOKEN_PATTERN.test(candidate)
  ) {
    return null;
  }

  return candidate;
};

/** Returns a safe request id or generates a new one when the incoming value is invalid. */
export const getSafeRequestId = (value: string | undefined): string =>
  normalizeHeaderToken(value) ?? randomUUID();

/** Validates and returns a safe device identifier for request ownership. */
export const requireSafeDeviceId = (value: string | undefined): string => {
  const candidate = value?.trim();

  if (!candidate) {
    throw new BadRequestException(
      `Missing required ${DEVICE_ID_HEADER} header.`,
    );
  }

  if (
    candidate.length > MAX_DEVICE_ID_LENGTH ||
    !HEADER_TOKEN_PATTERN.test(candidate)
  ) {
    throw new BadRequestException(`Invalid ${DEVICE_ID_HEADER} header.`);
  }

  return candidate;
};
