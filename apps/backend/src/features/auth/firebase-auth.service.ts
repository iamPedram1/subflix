import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { initializeApp, cert, getApps, type App } from 'firebase-admin/app';
import { getAuth, type DecodedIdToken } from 'firebase-admin/auth';

import {
  ForbiddenDomainError,
  ServiceUnavailableDomainError,
} from 'common/domain/errors/domain.error';

const FIREBASE_APP_NAME = 'subflix-auth';

@Injectable()
/** Handles Firebase token verification for OAuth sign-in. */
export class FirebaseAuthService {
  private app: App | null = null;

  constructor(private readonly configService: ConfigService) {}

  async verifyIdToken(idToken: string): Promise<DecodedIdToken> {
    try {
      const auth = getAuth(this.getApp());
      return await auth.verifyIdToken(idToken);
    } catch (error) {
      if (error instanceof ServiceUnavailableDomainError) {
        throw error;
      }
      throw new ForbiddenDomainError('Invalid OAuth token.');
    }
  }

  private getApp(): App {
    if (this.app) {
      return this.app;
    }

    const existing = getApps().find((app) => app.name === FIREBASE_APP_NAME);
    if (existing) {
      this.app = existing;
      return existing;
    }

    const serviceAccountJson =
      this.configService.get<string>('firebase.serviceAccountJson') ?? '';
    let projectId = this.configService.get<string>('firebase.projectId') ?? '';
    let clientEmail =
      this.configService.get<string>('firebase.clientEmail') ?? '';
    let privateKey = this.configService.get<string>('firebase.privateKey') ?? '';

    if (serviceAccountJson.trim()) {
      try {
        const parsed = JSON.parse(serviceAccountJson);
        projectId = parsed.project_id ?? projectId;
        clientEmail = parsed.client_email ?? clientEmail;
        privateKey = parsed.private_key ?? privateKey;
      } catch {
        throw new ServiceUnavailableDomainError(
          'Firebase auth configuration is invalid.',
        );
      }
    }

    if (!projectId || !clientEmail || !privateKey) {
      throw new ServiceUnavailableDomainError(
        'Firebase auth is not configured.',
      );
    }

    const normalizedPrivateKey = privateKey.replace(/\\n/g, '\n');
    this.app = initializeApp(
      {
        credential: cert({
          projectId,
          clientEmail,
          privateKey: normalizedPrivateKey,
        }),
      },
      FIREBASE_APP_NAME,
    );

    return this.app;
  }
}
