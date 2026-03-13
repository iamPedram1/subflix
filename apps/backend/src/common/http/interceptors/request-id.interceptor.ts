import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { randomUUID } from 'node:crypto';

import {
  REQUEST_ID_HEADER,
} from '../constants/request-context.constants';
import { RequestWithContext } from '../types/request-context';

@Injectable()
export class RequestIdInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const response = context.switchToHttp().getResponse();
    const requestId = request.header(REQUEST_ID_HEADER) ?? randomUUID();

    request.requestId = requestId;
    response.setHeader(REQUEST_ID_HEADER, requestId);

    return next.handle();
  }
}
