import type { Server } from 'node:http';

import type { INestApplication } from '@nestjs/common';
import request from 'supertest';

/** Creates the ownership header used by device-scoped endpoints in tests. */
export const createDeviceHeaders = (deviceId = 'device-test-001') => ({
  'x-device-id': deviceId,
});

/** Creates a typed Supertest client for the provided Nest application instance. */
export const createApiRequest = (app: INestApplication) =>
  request(app.getHttpServer() as Server);
