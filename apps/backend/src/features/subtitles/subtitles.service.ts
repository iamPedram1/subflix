import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppLanguage, ClientDevice, SubtitleFormat } from '@prisma/client';
import { createHash } from 'node:crypto';
import { extname } from 'node:path';

import { ValidationDomainError } from 'src/common/domain/errors/domain.error';

import { SubtitleCue } from './models/subtitle-cue.model';
import { SubtitlesRepository } from './subtitles.repository';
import { SubtitleParserService } from './utils/subtitle-parser.service';

@Injectable()
export class SubtitlesService {
  constructor(
    private readonly configService: ConfigService,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly subtitleParserService: SubtitleParserService,
  ) {}

  async parseAndStore(device: ClientDevice, file?: Express.Multer.File) {
    if (!file) {
      throw new ValidationDomainError('A subtitle file is required.');
    }

    const maxUploadBytes =
      this.configService.get<number>('app.maxUploadBytes') ?? 2 * 1024 * 1024;
    if (file.size > maxUploadBytes) {
      throw new ValidationDomainError('Subtitle file exceeds the upload limit.', {
        maxUploadBytes,
      });
    }

    const format = this.resolveFormat(file.originalname);
    const rawContent = file.buffer.toString('utf8');
    const cues = this.subtitleParserService.parse({
      content: rawContent,
      format,
    });

    const parsedFile = await this.subtitlesRepository.createParsedFile({
      clientDeviceId: device.id,
      fileName: file.originalname,
      format,
      sourceLanguage: AppLanguage.en,
      lineCount: cues.length,
      durationMs: this.getDurationMs(cues),
      checksum: createHash('sha256').update(file.buffer).digest('hex'),
      rawContent,
      cues,
    });

    return {
      id: parsedFile.id,
      fileName: parsedFile.fileName,
      format: parsedFile.format,
      sourceLanguage: parsedFile.sourceLanguage,
      lineCount: parsedFile.lineCount,
      durationMs: parsedFile.durationMs,
    };
  }

  private resolveFormat(fileName: string): SubtitleFormat {
    const extension = extname(fileName).toLowerCase();

    if (extension === '.srt') {
      return SubtitleFormat.srt;
    }

    if (extension === '.vtt') {
      return SubtitleFormat.vtt;
    }

    throw new ValidationDomainError(
      'Unsupported file type. Only .srt and .vtt files are accepted.',
    );
  }

  private getDurationMs(cues: SubtitleCue[]): number {
    return cues.at(-1)?.endMs ?? 0;
  }
}
