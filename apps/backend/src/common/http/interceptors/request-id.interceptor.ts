import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Response } from 'express';
import { Observable } from 'rxjs';

import {
  CACHE_CONTROL_HEADER,
  REQUEST_ID_HEADER,
} from '../constants/request-context.constants';
import { RequestWithContext } from '../types/request-context';
import { getSafeRequestId } from '../utils/request-header.util';

@Injectable()
export class RequestIdInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const response = context.switchToHttp().getResponse<Response>();
    const requestId = getSafeRequestId(request.header(REQUEST_ID_HEADER));

    request.requestId = requestId;
    response.setHeader(REQUEST_ID_HEADER, requestId);
    response.setHeader(CACHE_CONTROL_HEADER, 'no-store, max-age=0');
    response.setHeader('Pragma', 'no-cache');

    return next.handle();
  }
}
