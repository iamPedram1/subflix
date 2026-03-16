import path from 'node:path';

import { unzipSync } from 'fflate';

import { SubtitleFormat } from 'common/domain/enums/subtitle-format.enum';

export type ArchiveEntry = {
  fileName: string;
  bytes: Buffer;
};

export const isZipArchive = (payload: Buffer): boolean => {
  // ZIP local file header signature: PK\x03\x04
  return payload.length >= 4 && payload[0] === 0x50 && payload[1] === 0x4b;
};

const sanitizeZipEntryName = (fileName: string): string | null => {
  const normalized = fileName.replace(/\\/g, '/').trim();
  if (!normalized.length) {
    return null;
  }

  // Guard against zip-slip style paths even though we never write to disk.
  if (normalized.startsWith('/') || normalized.includes('..')) {
    return null;
  }

  const base = path.posix.basename(normalized);
  return base.length ? base : null;
};

export const unzipToEntries = (
  archiveBytes: Buffer,
  options?: {
    maxFiles?: number;
    maxTotalUncompressedBytes?: number;
  },
): ArchiveEntry[] => {
  const maxFiles = options?.maxFiles ?? 50;
  const maxTotalUncompressedBytes =
    options?.maxTotalUncompressedBytes ?? 10 * 1024 * 1024;

  if (archiveBytes.length > maxTotalUncompressedBytes) {
    throw new Error('Zip archive exceeds the maximum allowed compressed size.');
  }

  let expectedTotalBytes = 0;
  let acceptedFiles = 0;
  const unzipped = unzipSync(new Uint8Array(archiveBytes), {
    filter: (file) => {
      if (acceptedFiles >= maxFiles) {
        return false;
      }

      const originalSize =
        Number.isFinite(file.originalSize) && (file.originalSize ?? 0) > 0
          ? (file.originalSize as number)
          : Number.isFinite(file.size) && (file.size ?? 0) > 0
            ? (file.size as number)
            : 0;

      if (originalSize > maxTotalUncompressedBytes) {
        throw new Error(
          'Zip archive exceeds the maximum allowed extracted size.',
        );
      }

      if (expectedTotalBytes + originalSize > maxTotalUncompressedBytes) {
        throw new Error(
          'Zip archive exceeds the maximum allowed extracted size.',
        );
      }

      expectedTotalBytes += originalSize;
      acceptedFiles += 1;
      return true;
    },
  });
  const entries: ArchiveEntry[] = [];
  let totalBytes = 0;

  for (const [rawName, data] of Object.entries(unzipped)) {
    if (entries.length >= maxFiles) {
      break;
    }

    const safeName = sanitizeZipEntryName(rawName);
    if (!safeName) {
      continue;
    }

    const buffer = Buffer.from(data);
    totalBytes += buffer.length;
    if (totalBytes > maxTotalUncompressedBytes) {
      throw new Error(
        'Zip archive exceeds the maximum allowed extracted size.',
      );
    }

    entries.push({
      fileName: safeName,
      bytes: buffer,
    });
  }

  return entries;
};

export const detectSubtitleFormat = (params: {
  fileName?: string;
  contentType?: string;
  contentBytes?: Buffer;
}): SubtitleFormat | null => {
  const name = (params.fileName ?? '').toLowerCase();
  if (name.endsWith('.vtt')) {
    return SubtitleFormat.Vtt;
  }
  if (name.endsWith('.srt')) {
    return SubtitleFormat.Srt;
  }

  const contentType = (params.contentType ?? '').toLowerCase();
  if (contentType.includes('text/vtt') || contentType.includes('webvtt')) {
    return SubtitleFormat.Vtt;
  }
  if (contentType.includes('application/x-subrip')) {
    return SubtitleFormat.Srt;
  }

  const head = params.contentBytes
    ? params.contentBytes.slice(0, 64).toString('utf8').toUpperCase()
    : '';
  if (head.includes('WEBVTT')) {
    return SubtitleFormat.Vtt;
  }

  return null;
};

const scoreEntryName = (fileName: string): number => {
  const lower = fileName.toLowerCase();
  const ext = path.extname(lower);

  if (['.nfo', '.txt', '.url', '.jpg', '.png', '.gif', '.pdf'].includes(ext)) {
    return -100;
  }

  let score = 0;
  if (ext === '.srt') {
    score += 30;
  } else if (ext === '.vtt') {
    score += 28;
  } else {
    score -= 10;
  }

  if (
    lower.includes('readme') ||
    lower.includes('sample') ||
    lower.includes('commentary')
  ) {
    score -= 20;
  }

  // Prefer simpler names (less junk).
  score -= Math.min(10, Math.floor(fileName.length / 20));
  return score;
};

export const rankArchiveEntries = (entries: ArchiveEntry[]): ArchiveEntry[] => {
  return [...entries].sort((left, right) => {
    const leftScore = scoreEntryName(left.fileName);
    const rightScore = scoreEntryName(right.fileName);
    if (rightScore !== leftScore) {
      return rightScore - leftScore;
    }

    return left.fileName.localeCompare(right.fileName);
  });
};
