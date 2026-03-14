export type DomainErrorOptions = {
  statusCode: number;
  code: string;
  message: string;
  details?: unknown;
  i18n?: {
    key: string;
    args?: Record<string, string | number>;
  };
};

export class DomainError extends Error {
  readonly statusCode: number;
  readonly code: string;
  readonly details?: unknown;
  readonly i18nKey?: string;
  readonly i18nArgs?: Record<string, string | number>;

  constructor(options: DomainErrorOptions) {
    super(options.message);
    this.name = 'DomainError';
    this.statusCode = options.statusCode;
    this.code = options.code;
    this.details = options.details;
    this.i18nKey = options.i18n?.key;
    this.i18nArgs = options.i18n?.args;
  }
}

export class ValidationDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 400,
      code: 'validation_failed',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}

export class NotFoundDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 404,
      code: 'not_found',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}

export class ConflictDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 409,
      code: 'conflict',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}

export class ForbiddenDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 403,
      code: 'forbidden',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}

export class TooManyRequestsDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 429,
      code: 'rate_limited',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}

export class ServiceUnavailableDomainError extends DomainError {
  constructor(
    message: string,
    details?: unknown,
    i18n?: { key: string; args?: Record<string, string | number> },
  ) {
    super({
      statusCode: 503,
      code: 'service_unavailable',
      message,
      details,
      ...(i18n ? { i18n } : {}),
    });
  }
}
