import { IsOptional, IsString, MaxLength } from 'class-validator';

import { PaginationQueryDto } from 'src/common/http/dto/pagination-query.dto';

export class JobPreviewQueryDto extends PaginationQueryDto {
  @IsOptional()
  @IsString()
  @MaxLength(120)
  q?: string;
}
