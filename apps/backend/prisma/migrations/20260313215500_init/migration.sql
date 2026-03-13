-- CreateEnum
CREATE TYPE "AppLanguage" AS ENUM ('en', 'es', 'ar', 'fr', 'de', 'pt', 'ja', 'ko', 'hi', 'tr');

-- CreateEnum
CREATE TYPE "SubtitleFormat" AS ENUM ('srt', 'vtt');

-- CreateEnum
CREATE TYPE "ThemePreference" AS ENUM ('system', 'dark', 'light');

-- CreateEnum
CREATE TYPE "TranslationSourceType" AS ENUM ('catalog', 'upload');

-- CreateEnum
CREATE TYPE "TranslationJobStatus" AS ENUM ('queued', 'translating', 'completed', 'failed');

-- CreateTable
CREATE TABLE "ClientDevice" (
    "id" UUID NOT NULL,
    "deviceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClientDevice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserPreference" (
    "id" UUID NOT NULL,
    "clientDeviceId" UUID NOT NULL,
    "hasSeenOnboarding" BOOLEAN NOT NULL DEFAULT false,
    "preferredTargetLanguage" "AppLanguage" NOT NULL DEFAULT 'es',
    "themePreference" "ThemePreference" NOT NULL DEFAULT 'system',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParsedSubtitleFile" (
    "id" UUID NOT NULL,
    "clientDeviceId" UUID NOT NULL,
    "fileName" TEXT NOT NULL,
    "format" "SubtitleFormat" NOT NULL,
    "sourceLanguage" "AppLanguage" NOT NULL DEFAULT 'en',
    "lineCount" INTEGER NOT NULL,
    "durationMs" INTEGER NOT NULL,
    "checksum" TEXT NOT NULL,
    "rawContent" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ParsedSubtitleFile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ParsedSubtitleCue" (
    "id" UUID NOT NULL,
    "parsedFileId" UUID NOT NULL,
    "cueIndex" INTEGER NOT NULL,
    "startMs" INTEGER NOT NULL,
    "endMs" INTEGER NOT NULL,
    "text" TEXT NOT NULL,

    CONSTRAINT "ParsedSubtitleCue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TranslationJob" (
    "id" UUID NOT NULL,
    "clientDeviceId" UUID NOT NULL,
    "sourceType" "TranslationSourceType" NOT NULL,
    "status" "TranslationJobStatus" NOT NULL,
    "stageLabel" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "sourceName" TEXT NOT NULL,
    "sourceLanguage" "AppLanguage" NOT NULL DEFAULT 'en',
    "targetLanguage" "AppLanguage" NOT NULL,
    "format" "SubtitleFormat" NOT NULL,
    "progress" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "lineCount" INTEGER NOT NULL,
    "durationMs" INTEGER NOT NULL,
    "errorMessage" TEXT,
    "parsedFileId" UUID,
    "mediaRef" JSONB,
    "subtitleSourceRef" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),

    CONSTRAINT "TranslationJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TranslationJobCue" (
    "id" UUID NOT NULL,
    "jobId" UUID NOT NULL,
    "cueIndex" INTEGER NOT NULL,
    "startMs" INTEGER NOT NULL,
    "endMs" INTEGER NOT NULL,
    "originalText" TEXT NOT NULL,
    "translatedText" TEXT,

    CONSTRAINT "TranslationJobCue_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ClientDevice_deviceId_key" ON "ClientDevice"("deviceId");

-- CreateIndex
CREATE UNIQUE INDEX "UserPreference_clientDeviceId_key" ON "UserPreference"("clientDeviceId");

-- CreateIndex
CREATE INDEX "ParsedSubtitleFile_clientDeviceId_createdAt_idx" ON "ParsedSubtitleFile"("clientDeviceId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "ParsedSubtitleCue_parsedFileId_cueIndex_idx" ON "ParsedSubtitleCue"("parsedFileId", "cueIndex");

-- CreateIndex
CREATE UNIQUE INDEX "ParsedSubtitleCue_parsedFileId_cueIndex_key" ON "ParsedSubtitleCue"("parsedFileId", "cueIndex");

-- CreateIndex
CREATE INDEX "TranslationJob_clientDeviceId_createdAt_idx" ON "TranslationJob"("clientDeviceId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "TranslationJob_status_updatedAt_idx" ON "TranslationJob"("status", "updatedAt" DESC);

-- CreateIndex
CREATE INDEX "TranslationJobCue_jobId_cueIndex_idx" ON "TranslationJobCue"("jobId", "cueIndex");

-- CreateIndex
CREATE UNIQUE INDEX "TranslationJobCue_jobId_cueIndex_key" ON "TranslationJobCue"("jobId", "cueIndex");

-- AddForeignKey
ALTER TABLE "UserPreference" ADD CONSTRAINT "UserPreference_clientDeviceId_fkey" FOREIGN KEY ("clientDeviceId") REFERENCES "ClientDevice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParsedSubtitleFile" ADD CONSTRAINT "ParsedSubtitleFile_clientDeviceId_fkey" FOREIGN KEY ("clientDeviceId") REFERENCES "ClientDevice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParsedSubtitleCue" ADD CONSTRAINT "ParsedSubtitleCue_parsedFileId_fkey" FOREIGN KEY ("parsedFileId") REFERENCES "ParsedSubtitleFile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TranslationJob" ADD CONSTRAINT "TranslationJob_clientDeviceId_fkey" FOREIGN KEY ("clientDeviceId") REFERENCES "ClientDevice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TranslationJob" ADD CONSTRAINT "TranslationJob_parsedFileId_fkey" FOREIGN KEY ("parsedFileId") REFERENCES "ParsedSubtitleFile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TranslationJobCue" ADD CONSTRAINT "TranslationJobCue_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "TranslationJob"("id") ON DELETE CASCADE ON UPDATE CASCADE;

