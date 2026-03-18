import { Injectable } from '@nestjs/common';
import {
  AppLanguage,
  ParsedSubtitleCue,
  ParsedSubtitleFile,
  Prisma,
  SubtitleFormat,
} from '@prisma/client';

import { BaseRepository } from 'common/database/base.repository';
import { requireEntity } from 'common/database/helpers/entity.helper';
import { PrismaService } from 'common/database/prisma/prisma.service';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

@Injectable()
/** Persists parsed subtitle uploads and their normalized cue rows. */
export class SubtitlesRepository extends BaseRepository {
  constructor(private readonly prisma: PrismaService) {
    super();
  }

  private static readonly parsedFileSummarySelect =
    Prisma.validator<Prisma.ParsedSubtitleFileSelect>()({
      id: true,
      fileName: true,
      format: true,
      lineCount: true,
      durationMs: true,
    });

  /** Stores a parsed subtitle file and its cues in one transaction. */
  createParsedFile(params: {
    clientDeviceId: string;
    fileName: string;
    format: SubtitleFormat;
    sourceLanguage: AppLanguage;
    lineCount: number;
    durationMs: number;
    checksum: string;
    rawContent: string;
    cues: SubtitleCue[];
  }): Promise<ParsedSubtitleFile> {
    return this.dbCall(() =>
      this.prisma.$transaction(async (tx) => {
        const file = await tx.parsedSubtitleFile.create({
          data: {
            clientDeviceId: params.clientDeviceId,
            fileName: params.fileName,
            format: params.format,
            sourceLanguage: params.sourceLanguage,
            lineCount: params.lineCount,
            durationMs: params.durationMs,
            checksum: params.checksum,
            rawContent: params.rawContent,
          },
        });

        await tx.parsedSubtitleCue.createMany({
          data: params.cues.map((cue) => ({
            parsedFileId: file.id,
            cueIndex: cue.cueIndex,
            startMs: cue.startMs,
            endMs: cue.endMs,
            text: cue.text,
          })),
        });

        return file;
      }),
    );
  }

  /** Loads parsed subtitle metadata without eagerly hydrating the full cue set. */
  async findOwnedParsedFileSummary(params: {
    clientDeviceId: string;
    parsedFileId: string;
  }) {
    const parsedFile = await this.prisma.parsedSubtitleFile.findFirst({
      where: {
        id: params.parsedFileId,
        clientDeviceId: params.clientDeviceId,
      },
      select: SubtitlesRepository.parsedFileSummarySelect,
    });

    return requireEntity(
      parsedFile,
      'The subtitle file could not be found for this device.',
    );
  }

  /** Loads normalized subtitle cues for a device-owned parsed upload. */
  async listOwnedParsedFileCues(params: {
    clientDeviceId: string;
    parsedFileId: string;
  }): Promise<SubtitleCue[]> {
    const cues = await this.prisma.parsedSubtitleCue.findMany({
      where: {
        parsedFileId: params.parsedFileId,
        parsedFile: {
          clientDeviceId: params.clientDeviceId,
        },
      },
      orderBy: { cueIndex: 'asc' },
    });

    if (cues.length > 0) {
      return cues.map(this.toSubtitleCue);
    }

    const parsedFile = await this.prisma.parsedSubtitleFile.findFirst({
      where: {
        id: params.parsedFileId,
        clientDeviceId: params.clientDeviceId,
      },
      select: { id: true },
    });

    requireEntity(
      parsedFile,
      'The subtitle file could not be found for this device.',
    );

    return [];
  }

  /** Maps persisted cue rows into the shared subtitle cue model. */
  private toSubtitleCue(cue: ParsedSubtitleCue): SubtitleCue {
    return {
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      text: cue.text,
    };
  }
}
