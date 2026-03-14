import { Global, Module } from '@nestjs/common';

import { AppCacheService } from 'common/cache/app-cache.service';

@Global()
@Module({
  providers: [AppCacheService],
  exports: [AppCacheService],
})
export class CacheModule {}
