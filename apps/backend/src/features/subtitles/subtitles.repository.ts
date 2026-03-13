import { Injectable } from '@nestjs/common';
import { AppLanguage, ParsedSubtitleFile, SubtitleFormat } from '@prisma/client';

import { normalizeDatabaseError } from 'src/common/database/helpers/database-error.helper';
import { requireEntity } from 'src/common/database/helpers/entity.helper';
import { PrismaService } from 'src/common/database/prisma/prisma.service';

import { SubtitleCue } from './models/subtitle-cue.model';

@Injectable()
export class SubtitlesRepository {
  constructor(private readonly prisma: PrismaService) {}

  async createParsedFile(params: {
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
    try {
      return await this.prisma.$transaction(async (tx) => {
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
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  async findOwnedParsedFile(params: {
    clientDeviceId: string;
    parsedFileId: string;
  }) {
    const parsedFile = await this.prisma.parsedSubtitleFile.findFirst({
      where: {
        id: params.parsedFileId,
        clientDeviceId: params.clientDeviceId,
      },
      include: {
        cues: {
          orderBy: { cueIndex: 'asc' },
        },
      },
    });

    return requireEntity(
      parsedFile,
      'The subtitle file could not be found for this device.',
    );
  }
}
