import type { ClientDevice, User } from '@prisma/client';
import type { Request } from 'express';

export type RequestWithContext = Request & {
  requestId?: string;
  device?: ClientDevice;
  user?: User;
};
