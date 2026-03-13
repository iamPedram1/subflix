import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';

import { AppModule } from 'src/app.module';
import { configureApp } from 'src/app.bootstrap';

/** Creates a fully initialized Nest application for end-to-end tests. */
export const createE2eApp = async (): Promise<INestApplication> => {
  const previousTmdbToken = process.env.TMDB_API_READ_TOKEN;
  if (process.env.SUBFLIX_E2E_USE_TMDB !== 'true') {
    process.env.TMDB_API_READ_TOKEN = '';
  }
  try {
    const moduleFixture = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    const app = moduleFixture.createNestApplication();
    configureApp(app);
    await app.init();

    return app;
  } finally {
    process.env.TMDB_API_READ_TOKEN = previousTmdbToken;
  }
};

/** Runs an e2e test body with an application instance and guarantees cleanup. */
export const withE2eApp = async <T>(
  run: (app: INestApplication) => Promise<T>,
): Promise<T> => {
  const app = await createE2eApp();

  try {
    return await run(app);
  } finally {
    await app.close();
  }
};
