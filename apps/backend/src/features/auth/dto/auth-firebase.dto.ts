import { IsString, MinLength } from 'class-validator';

export class AuthFirebaseDto {
  @IsString()
  @MinLength(20)
  idToken!: string;
}
