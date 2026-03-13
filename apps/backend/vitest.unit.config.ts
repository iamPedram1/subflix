import { createVitestConfig } from './vitest.shared';

export default createVitestConfig({
  include: ['test/unit/**/*.spec.ts'],
});
