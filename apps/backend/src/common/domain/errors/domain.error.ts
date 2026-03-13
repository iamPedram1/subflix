export type DomainErrorOptions = {
  statusCode: number;
  code: string;
  message: string;
  details?: unknown;
};

export class DomainError extends Error {
  readonly statusCode: number;
  readonly code: string;
  readonly details?: unknown;

  constructor(options: DomainErrorOptions) {
    super(options.message);
    this.name = 'DomainError';
    this.statusCode = options.statusCode;
    this.code = options.code;
    this.details = options.details;
  }
}

export class ValidationDomainError extends DomainError {
  constructor(message: string, details?: unknown) {
    super({
      statusCode: 400,
      code: 'validation_failed',
      message,
      details,
    });
  }
}

export class NotFoundDomainError extends DomainError {
  constructor(message: string, details?: unknown) {
    super({
      statusCode: 404,
      code: 'not_found',
      message,
      details,
    });
  }
}

export class ConflictDomainError extends DomainError {
  constructor(message: string, details?: unknown) {
    super({
      statusCode: 409,
      code: 'conflict',
      message,
      details,
    });
  }
}

export class ForbiddenDomainError extends DomainError {
  constructor(message: string, details?: unknown) {
    super({
      statusCode: 403,
      code: 'forbidden',
      message,
      details,
    });
  }
}
