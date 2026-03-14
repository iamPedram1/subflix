import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { RequestWithContext } from 'common/http/types/request-context';

export const CurrentDevice = createParamDecorator(
  (_data: unknown, context: ExecutionContext): ClientDevice => {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    return request.device!;
  },
);
