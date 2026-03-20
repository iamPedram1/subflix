import { IsUUID } from 'class-validator';

export class TranslationJobParamsDto {
  @IsUUID()
  jobId!: string;
}
