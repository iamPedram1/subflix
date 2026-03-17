-- AlterTable: add jobMeta JSON column for retry tracking and recovery metadata
ALTER TABLE "TranslationJob" ADD COLUMN "jobMeta" JSONB;
