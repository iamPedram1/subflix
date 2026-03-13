import {
  BadRequestException,
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';

import { DevicesService } from 'src/features/devices/devices.service';

import { DEVICE_ID_HEADER } from '../constants/request-context.constants';
import { RequestWithContext } from '../types/request-context';
import { requireSafeDeviceId } from '../utils/request-header.util';

@Injectable()
/** Resolves the required device header and attaches the owning device to the request. */
export class DeviceContextGuard implements CanActivate {
  constructor(private readonly devicesService: DevicesService) {}

  /** Validates the ownership header before a device-scoped route executes. */
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const rawDeviceId = request.header(DEVICE_ID_HEADER);

    if (!rawDeviceId?.trim()) {
      throw new UnauthorizedException(
        `Missing required ${DEVICE_ID_HEADER} header.`,
      );
    }

    let deviceId: string;
    try {
      deviceId = requireSafeDeviceId(rawDeviceId);
    } catch (error) {
      if (error instanceof BadRequestException) {
        throw error;
      }

      throw new BadRequestException(`Invalid ${DEVICE_ID_HEADER} header.`);
    }

    request.device = await this.devicesService.resolveDevice(deviceId);
    return true;
  }
}
