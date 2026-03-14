import { PrismaService } from 'src/common/database/prisma/prisma.service';

export const hasDatabaseUrl = (): boolean =>
  Boolean(process.env.DATABASE_URL?.trim());

type DescribeBlock = (name: string, run: () => void) => void;

export const describeIfDatabase: DescribeBlock = (name, run) => {
  (hasDatabaseUrl() ? describe : describe.skip)(name, run);
};

/** Clears persisted test data in dependency order. */
export const resetDatabase = async (prisma: PrismaService): Promise<void> => {
  await prisma.translationJobCue.deleteMany();
  await prisma.translationJob.deleteMany();
  await prisma.parsedSubtitleCue.deleteMany();
  await prisma.parsedSubtitleFile.deleteMany();
  await prisma.userPreference.deleteMany();
  await prisma.clientDevice.deleteMany();
};
