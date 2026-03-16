export type AuthTokenPayload = {
  sub: string;
  email: string;
  tokenType: 'access';
  sessionId: string;
};

export type AuthUser = {
  id: string;
  email: string;
  displayName: string | null;
  photoUrl: string | null;
  emailVerified: boolean;
  createdAt: Date;
  updatedAt: Date;
};

export type AuthTokens = {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  tokenType: 'Bearer';
};

export type AuthResponse = {
  user: AuthUser;
} & AuthTokens;

export type RequestMeta = {
  ipAddress?: string;
  userAgent?: string;
};
