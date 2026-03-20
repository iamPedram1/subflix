import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

import { PrismaModule } from 'common/database/prisma/prisma.module';
import { AuthController } from 'features/auth/auth.controller';
import { AuthRepository } from 'features/auth/auth.repository';
import { AuthService } from 'features/auth/auth.service';
import { FirebaseAuthService } from 'features/auth/firebase-auth.service';
import { AccessTokenGuard } from 'features/auth/guards/access-token.guard';

const MINIMUM_JWT_SECRET_LENGTH = 32;

@Module({
  imports: [
    PrismaModule,
    JwtModule.registerAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        secret: (() => {
          const secret = configService.get<string>('auth.jwtSecret') ?? '';
          const nodeEnv = configService.get<string>('app.nodeEnv') ?? 'development';

          if (nodeEnv !== 'test' && secret.trim().length < MINIMUM_JWT_SECRET_LENGTH) {
            throw new Error(
              `AUTH_JWT_SECRET must be at least ${MINIMUM_JWT_SECRET_LENGTH} characters outside test mode.`,
            );
          }

          return secret;
        })(),
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
