import { IsBoolean, IsEnum, IsOptional } from 'class-validator';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { ThemePreference } from 'src/common/domain/enums/theme-preference.enum';

export class UpdatePreferencesDto {
  @IsOptional()
  @IsBoolean()
  hasSeenOnboarding?: boolean;

  @IsOptional()
  @IsEnum(AppLanguage)
  preferredTargetLanguage?: AppLanguage;

  @IsOptional()
  @IsEnum(ThemePreference)
  themePreference?: ThemePreference;
}
