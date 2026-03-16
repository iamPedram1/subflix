import { IsEmail, MaxLength } from 'class-validator';

export class AuthForgotPasswordDto {
  @IsEmail()
  @MaxLength(320)
  email!: string;
}
