import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';

import { AppModule } from 'src/app.module';
import { configureApp } from 'src/app.bootstrap';

export const createE2eApp = async (): Promise<INestApplication> => {
  const moduleFixture = await Test.createTestingModule({
    imports: [AppModule],
  }).compile();

  const app = moduleFixture.createNestApplication();
  configureApp(app);
  await app.init();

  return app;
};
