import { IsString, MinLength } from 'class-validator';

export class AuthConfirmEmailDto {
  @IsString()
  @MinLength(20)
  token!: string;
}
