import type { Server } from 'node:http';

import type { INestApplication } from '@nestjs/common';
import request from 'supertest';

export const createDeviceHeaders = (deviceId = 'device-test-001') => ({
  'x-device-id': deviceId,
});

export const createApiRequest = (app: INestApplication) =>
  request(app.getHttpServer() as Server);
