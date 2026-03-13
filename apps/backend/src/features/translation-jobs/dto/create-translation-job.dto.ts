import { IsEnum, IsOptional, IsString, IsUUID } from 'class-validator';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { TranslationSourceType } from 'src/common/domain/enums/translation-source-type.enum';

export class CreateTranslationJobDto {
  @IsEnum(TranslationSourceType)
  sourceType!: TranslationSourceType;

  @IsOptional()
  @IsString()
  mediaId?: string;

  @IsOptional()
  @IsString()
  subtitleSourceId?: string;

  @IsOptional()
  @IsUUID()
  parsedFileId?: string;

  @IsEnum(AppLanguage)
  targetLanguage!: AppLanguage;
}
