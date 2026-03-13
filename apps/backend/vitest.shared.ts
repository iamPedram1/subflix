import swc from 'unplugin-swc';
import { defineConfig, mergeConfig } from 'vitest/config';

const sharedConfig = defineConfig({
  plugins: [
    swc.vite({
      jsc: {
        parser: {
          syntax: 'typescript',
          decorators: true,
        },
        transform: {
          decoratorMetadata: true,
        },
      },
    }),
  ],
  oxc: false,
  resolve: {
    tsconfigPaths: true,
  },
  test: {
    globals: true,
    environment: 'node',
    setupFiles: ['./test/vitest.setup.ts'],
    clearMocks: true,
    restoreMocks: true,
    mockReset: true,
    unstubEnvs: true,
    unstubGlobals: true,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html'],
      include: ['src/**/*.ts'],
      exclude: ['src/main.ts'],
    },
  },
});

export const createVitestConfig = (params: {
  include: string[];
  fileParallelism?: boolean;
}) =>
  mergeConfig(
    sharedConfig,
    defineConfig({
      test: {
        include: params.include,
        fileParallelism: params.fileParallelism ?? true,
      },
    }),
  );
