import { ClientDevice } from '@prisma/client';
import { Request } from 'express';

export type RequestWithContext = Request & {
  requestId?: string;
  device?: ClientDevice;
};
