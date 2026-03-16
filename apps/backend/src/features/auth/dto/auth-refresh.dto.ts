import { IsString, MinLength } from 'class-validator';

export class AuthRefreshDto {
  @IsString()
  @MinLength(20)
  refreshToken!: string;
}
