import { Logger } from '@nestjs/common';

export type LogContext = Record<string, unknown>;

/**
 * Thin wrapper around NestJS Logger that emits JSON-structured log entries.
 *
 * Each log entry serializes an event name plus any context fields (jobId,
 * mediaId, durationMs, …) into a single JSON line, making it easy to parse
 * and correlate in production log aggregators.
 *
 * Usage:
 *   private readonly log = new StructuredLogger(MyService.name);
 *   this.log.info('translation.started', { jobId, sourceType });
 */
export class StructuredLogger {
  private readonly logger: Logger;

  constructor(context: string) {
    this.logger = new Logger(context);
  }

  info(event: string, ctx?: LogContext): void {
    this.logger.log(JSON.stringify({ event, ...ctx }));
  }

  warn(event: string, ctx?: LogContext): void {
    this.logger.warn(JSON.stringify({ event, ...ctx }));
  }

  error(event: string, ctx?: LogContext): void {
    this.logger.error(JSON.stringify({ event, ...ctx }));
  }
}
