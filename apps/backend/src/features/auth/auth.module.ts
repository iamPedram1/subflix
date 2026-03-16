import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

import { PrismaModule } from 'common/database/prisma/prisma.module';
import { AuthController } from 'features/auth/auth.controller';
import { AuthRepository } from 'features/auth/auth.repository';
import { AuthService } from 'features/auth/auth.service';
import { FirebaseAuthService } from 'features/auth/firebase-auth.service';
import { AccessTokenGuard } from 'features/auth/guards/access-token.guard';

@Module({
  imports: [
    PrismaModule,
    JwtModule.registerAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get<string>('auth.jwtSecret') ?? '',
      }),
    }),
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    AuthRepository,
    FirebaseAuthService,
    AccessTokenGuard,
  ],
  exports: [AuthService, AccessTokenGuard],
})
export class AuthModule {}
