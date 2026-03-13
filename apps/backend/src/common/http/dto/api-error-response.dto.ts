export class ApiErrorResponseDto {
  code!: string;
  message!: string;
  details?: unknown;
  requestId!: string;
  timestamp!: string;
}
