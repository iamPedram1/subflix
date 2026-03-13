import { createVitestConfig } from './vitest.shared';

export default createVitestConfig({
  include: ['test/integration/**/*.spec.ts'],
  fileParallelism: false,
});
