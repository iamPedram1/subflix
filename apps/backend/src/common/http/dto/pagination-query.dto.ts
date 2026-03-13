import { IsInt, Max, Min } from 'class-validator';

export class PaginationQueryDto {
  @IsInt()
  @Min(1)
  page = 1;

  @IsInt()
  @Min(1)
  @Max(100)
  limit = 20;
}
