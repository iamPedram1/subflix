import { createVitestConfig } from './vitest.shared';

export default createVitestConfig({
  include: ['test/e2e/**/*.spec.ts'],
  fileParallelism: false,
});
