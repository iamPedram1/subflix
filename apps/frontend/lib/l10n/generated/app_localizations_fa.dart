// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'حساب';

  @override
  String get authAlreadySignedInTitle => 'شما از قبل وارد شده‌اید';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'این دستگاه از قبل با حساب $email متصل است.';
  }

  @override
  String get authBackToAccount => 'بازگشت به حساب';

  @override
  String get authBackToSignIn => 'بازگشت به ورود';

  @override
  String get authCheckInboxTitle => 'صندوق ورودی خود را بررسی کنید';

  @override
  String get authConfirmEmailAction => 'تأیید ایمیل';

  @override
  String authConfirmEmailHint(Object email) {
    return 'از توکن تأیید ارسال‌شده به $email استفاده کنید.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'برای تکمیل فعال‌سازی این حساب، توکن تأیید را از ایمیل خود وارد کنید.';

  @override
  String get authConfirmEmailSuccess =>
      'ایمیل تأیید شد. اکنون می‌توانید وارد شوید.';

  @override
  String get authConfirmEmailTitle => 'ایمیل خود را تأیید کنید';

  @override
  String get authConfirmPasswordLabel => 'تأیید رمز عبور';

  @override
  String get authContinueToReset => 'ادامه برای بازنشانی';

  @override
  String get authContinueWithGoogle => 'ادامه با Google';

  @override
  String get authCreateAccountAction => 'ایجاد حساب';

  @override
  String authDebugTokenLabel(Object token) {
    return 'توکن اشکال‌زدایی: $token';
  }

  @override
  String get authDisplayNameLabel => 'نام نمایشی';

  @override
  String get authEmailLabel => 'آدرس ایمیل';

  @override
  String get authEyebrow => 'فضای امن';

  @override
  String get authFieldRequired => 'این فیلد الزامی است.';

  @override
  String get authForgotPasswordAction => 'ارسال لینک بازنشانی';

  @override
  String get authForgotPasswordDebugMessage =>
      'برای این محیط اشکال‌زدایی یک توکن بازنشانی بازگردانده شد. می‌توانید مستقیم به فرم بازنشانی بروید.';

  @override
  String get authForgotPasswordLink => 'رمز عبور را فراموش کرده‌اید؟';

  @override
  String get authForgotPasswordSubtitle =>
      'ایمیل خود را وارد کنید تا از بک‌اند درخواست بازنشانی رمز عبور برای این حساب ارسال شود.';

  @override
  String get authForgotPasswordSuccess =>
      'اگر این حساب وجود داشته باشد، پیام بازنشانی رمز عبور ارسال شده است.';

  @override
  String get authForgotPasswordTitle => 'رمز عبور خود را بازنشانی کنید';

  @override
  String get authGoogleHelper =>
      'ورود با Google از Firebase OAuth استفاده می‌کند و زمانی کار خواهد کرد که این برنامه به یک پروژه Firebase متصل شود.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'از قبل حساب دارید؟ وارد شوید';

  @override
  String get authInvalidEmail => 'یک آدرس ایمیل معتبر وارد کنید.';

  @override
  String get authNewPasswordLabel => 'رمز عبور جدید';

  @override
  String get authNoAccountLink => 'حساب ندارید؟ یکی بسازید';

  @override
  String get authOrDivider => 'یا';

  @override
  String get authPasswordLabel => 'رمز عبور';

  @override
  String get authPasswordMismatch => 'رمزهای عبور یکسان نیستند.';

  @override
  String get authPasswordTooShort => 'حداقل از ۸ کاراکتر استفاده کنید.';

  @override
  String get authProfileRefreshed => 'اطلاعات حساب به‌روزرسانی شد.';

  @override
  String get authRefreshProfileAction => 'به‌روزرسانی پروفایل';

  @override
  String get authRefreshProfileSubtitle =>
      'جدیدترین اطلاعات پروفایل را از بک‌اند بارگیری کنید.';

  @override
  String get authResetPasswordAction => 'ذخیره رمز عبور جدید';

  @override
  String authResetPasswordHint(Object email) {
    return 'با استفاده از توکن موجود در ایمیل، رمز عبور $email را بازنشانی کنید.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'توکن بازنشانی را وارد کنید و یک رمز عبور جدید برای این حساب انتخاب کنید.';

  @override
  String get authResetPasswordSuccess =>
      'رمز عبور به‌روزرسانی شد. لطفاً دوباره وارد شوید.';

  @override
  String get authResetPasswordTitle => 'یک رمز عبور جدید انتخاب کنید';

  @override
  String get authSignInAction => 'ورود';

  @override
  String get authSignInSubtitle =>
      'این برنامه را به حساب SubFlix خود وصل کنید تا داده‌های پروفایل همگام شود و جریان‌های احراز هویت‌شده بک‌اند فعال شوند.';

  @override
  String get authSignInSuccess => 'ورود با موفقیت انجام شد.';

  @override
  String get authSignInTitle => 'خوش برگشتید';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'متصل به عنوان $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'برای مدیریت حساب، استفاده از Firebase OAuth و آماده‌سازی قابلیت‌های احراز هویت‌شده برای همگام‌سازی آینده وارد شوید.';

  @override
  String get authSignedOutCardTitle => 'به SubFlix وارد شوید';

  @override
  String get authSignOutAction => 'خروج';

  @override
  String get authSignOutSubtitle =>
      'نشست فعلی این دستگاه را لغو و توکن‌های محلی را پاک کنید.';

  @override
  String get authSignOutSuccess => 'در این دستگاه از حساب خارج شدید.';

  @override
  String get authSignUpAction => 'ایجاد حساب من';

  @override
  String get authSignUpSubtitle =>
      'یک حساب ایجاد کنید تا این برنامه بتواند از پروفایل احراز هویت‌شده و جریان‌های نشست بک‌اند استفاده کند.';

  @override
  String get authSignUpSuccess => 'حساب ایجاد شد. تأیید ایمیل را ادامه دهید.';

  @override
  String get authSignUpTitle => 'حساب خود را ایجاد کنید';

  @override
  String get authVerificationStatusTitle => 'تأیید ایمیل';

  @override
  String get authVerificationTokenLabel => 'توکن تأیید';

  @override
  String get authVerifiedStatus => 'تأیید شده';

  @override
  String get authUnverifiedStatus => 'در انتظار تأیید';

  @override
  String get brandSubtitleCompact => 'Щ‡Щ€Шґ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get brandSubtitleFull =>
      'Ш§ШіШЄЩ€ШЇЫЊЩ€ЫЊ ШЄШ±Ш¬Щ…Щ‡ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ';

  @override
  String get comingSoonMessage =>
      'Щ‡Щ†Щ€ШІ ШЇШ± Ш­Ш§Щ„ ШўЩ…Ш§ШЇЩ‡ Ъ©Ш±ШЇЩ† Ш§ЫЊЩ† ШµЩЃШ­Щ‡ Щ‡ШіШЄЫЊЩ….';

  @override
  String get comingSoonTitle => 'ШЁЩ‡вЂЊШІЩ€ШЇЫЊ';

  @override
  String exportFailedSnack(Object error) {
    return 'Ш®Ш±Щ€Ш¬ЫЊ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ: $error';
  }

  @override
  String get exportSubtitleLabel =>
      'Ш®Ш±Щ€Ш¬ЫЊ ЪЇШ±ЩЃШЄЩ† Ш§ШІ ШІЫЊШ±Щ†Щ€ЫЊШі ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName ШЇШ± $path Ш°Ш®ЫЊШ±Щ‡ ШґШЇ';
  }

  @override
  String get exportingLabel => 'ШЇШ± Ш­Ш§Щ„ Ш®Ш±Щ€Ш¬ЫЊ ЪЇШ±ЩЃШЄЩ†...';

  @override
  String get heroBadge => 'Ш¬Ш±ЫЊШ§Щ† Ш­Ш±ЩЃЩ‡вЂЊШ§ЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get heroBody =>
      'ШЁЫЊЩ† Ъ©Ш§ШЄШ§Щ„Щ€ЪЇ Щ‚Ш§ШЁЩ„ Ш¬ШіШЄШ¬Щ€ ЫЊШ§ ШўЩѕЩ„Щ€ШЇ Щ…ШіШЄЩ‚ЫЊЩ… ЩЃШ§ЫЊЩ„ ЫЊЪ©ЫЊ Ш±Ш§ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ†ШЊ ШіЩѕШі ШЇШ± Ъ†Щ†ШЇ ШЇЩ‚ЫЊЩ‚Щ‡ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ШЁЪЇЫЊШ± Щ€ ШІЫЊШ±Щ†Щ€ЫЊШі Щ†Щ‡Ш§ЫЊЫЊ Ш±Ш§ Ш®Ш±Щ€Ш¬ЫЊ ШЁЪЇЫЊШ±.';

  @override
  String get heroHeadline =>
      'ШІЫЊШ±Щ†Щ€ЫЊШі ЩЃЫЊЩ„Щ… Щ€ ШіШ±ЫЊШ§Щ„ Ш±Ш§ ШЁШ§ ЫЊЪ© Ш¬Ш±ЫЊШ§Щ† ШЇШ± Ш­ШЇ Ш§ШіШЄЩ€ШЇЫЊЩ€ ШЄШ±Ш¬Щ…Щ‡ Ъ©Щ†.';

  @override
  String get heroSearchCta => 'Ш¬ШіШЄШ¬Щ€ЫЊ ЩЃЫЊЩ„Щ… / ШіШ±ЫЊШ§Щ„';

  @override
  String get heroStatLanguagesTitle => 'Ы±Ы° ШІШЁШ§Щ†';

  @override
  String get heroStatLanguagesValue => 'ШўЩ…Ш§ШЇЩ‡ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ';

  @override
  String get heroStatMockTitle => 'APIЩ‡Ш§ЫЊ Щ…Ш§Ъ©';

  @override
  String get heroStatMockValue => 'ШўЩ…Ш§ШЇЩ‡ Ш§ШЄШµШ§Щ„ ШЁЩ‡ ШЁЪ©вЂЊШ§Щ†ШЇ';

  @override
  String get heroStatPathsTitle => 'ЫІ Щ…ШіЫЊШ±';

  @override
  String get heroStatPathsValue => 'Ш¬ШіШЄШ¬Щ€ ЫЊШ§ ШўЩѕЩ„Щ€ШЇ';

  @override
  String get heroSubtitle =>
      'ШЇШ± Ъ©Ш§ШЄШ§Щ„Щ€ЪЇ ЩЃЫЊЩ„Щ… Щ€ ШіШ±ЫЊШ§Щ„ Ш¬ШіШЄШ¬Щ€ Ъ©Щ†ШЊ Щ…Щ†ШЁШ№ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ† Щ€ ШЇШ± Ъ†Щ†ШЇ ШЇЩ‚ЫЊЩ‚Щ‡ Ш®Ш±Щ€Ш¬ЫЊ ШЄЩ…ЫЊШІ ШЁЪЇЫЊШ±.';

  @override
  String get heroTitle =>
      'ШІЫЊШ±Щ†Щ€ЫЊШівЂЊЩ‡Ш§ Ш±Ш§ ШіШ±ЫЊШ№вЂЊШЄШ± ШЄШ±Ш¬Щ…Щ‡ Ъ©Щ†';

  @override
  String get heroUploadCta => 'ШўЩѕЩ„Щ€ШЇ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String historyCountLabel(Object count) {
    return '$count ШЄШ±Ш¬Щ…Щ‡';
  }

  @override
  String get historyEmptyMessage =>
      'ШЁШ№ШЇ Ш§ШІ Ъ©Ш§Щ…Щ„ Ъ©Ш±ШЇЩ† ЩЃШ±Ш§ЫЊЩ†ШЇ Ш¬ШіШЄШ¬Щ€ ЫЊШ§ ШўЩѕЩ„Щ€ШЇШЊ ШЄШ±Ш¬Щ…Щ‡вЂЊЩ‡Ш§ЫЊ Ш§Щ†Ш¬Ш§Щ…вЂЊШґШЇЩ‡ Ш§ЫЊЩ†Ш¬Ш§ ШёШ§Щ‡Ш± Щ…ЫЊвЂЊШґЩ€Щ†ШЇ.';

  @override
  String get historyEmptyTitle => 'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ Ш®Ш§Щ„ЫЊ Ш§ШіШЄ';

  @override
  String get historyFailedItemMessage =>
      'ШЄШ±Ш¬Щ…Щ‡ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ. ШЁШ±Ш§ЫЊ ШґШ±Щ€Ш№ ШЇЩ€ШЁШ§Ш±Щ‡ Щ„Щ…Ші Ъ©Щ†.';

  @override
  String get historyFailedTitle =>
      'ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ Щ…Щ…Ъ©Щ† Щ†ШґШЇ';

  @override
  String get historyFilterAiTranslated =>
      'ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡ ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ';

  @override
  String get historyFilterAll => 'Щ‡Щ…Щ‡';

  @override
  String get historyFilterCompleted => 'ШЄЪ©Щ…ЫЊЩ„вЂЊШґШЇЩ‡';

  @override
  String get historyFilterFailed => 'Щ†Ш§Щ…Щ€ЩЃЩ‚';

  @override
  String get historyFilterMovies => 'ЩЃЫЊЩ„Щ…вЂЊЩ‡Ш§';

  @override
  String get historyFilterReused => 'Ш§ШіШЄЩЃШ§ШЇЩ‡вЂЊШґШЇЩ‡ ШЇЩ€ШЁШ§Ш±Щ‡';

  @override
  String get historyFilterSeries => 'ШіШ±ЫЊШ§Щ„вЂЊЩ‡Ш§';

  @override
  String get historySubtitle =>
      'Ъ©Ш§Ш±Щ‡Ш§ЫЊ Щ‚ШЁЩ„ЫЊ Ш±Ш§ ШЇЩ€ШЁШ§Ш±Щ‡ ШЁШ§ШІ Ъ©Щ†ШЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ Ш±Ш§ ШЇЩ€ШЁШ§Ш±Щ‡ ШЁШЁЫЊЩ† ЫЊШ§ ШЁШ№ШЇШ§Щ‹ Ш®Ш±Щ€Ш¬ЫЊ ШЁЪЇЫЊШ±.';

  @override
  String get historyTitle => 'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ ШЄШ±Ш¬Щ…Щ‡вЂЊЩ‡Ш§';

  @override
  String get homeFailedRecentTitle =>
      'ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ Ъ©Ш§Ш±Щ‡Ш§ЫЊ Ш§Ш®ЫЊШ± Щ…Щ…Ъ©Щ† Щ†ШґШЇ';

  @override
  String get homeFutureSubtitle =>
      'Ш±ЫЊЩѕШ§ШІЫЊШЄЩ€Ш±ЫЊвЂЊЩ‡Ш§ЫЊ Щ…Ш§Ъ© Щ‚Ш§ШЁЩ„ ШЄШ№Щ€ЫЊШ¶ ШЁШ§Ш№Ш« Щ…ЫЊвЂЊШґЩ€Щ†ШЇ Ъ©ШЇ UI Ш§ШІ ШЄШєЫЊЫЊШ±Ш§ШЄ ШЁЪ©вЂЊШ§Щ†ШЇ ШЇШ± Ш§Щ…Ш§Щ† ШЁЩ…Ш§Щ†ШЇ.';

  @override
  String get homeFutureTitle =>
      'Ш±ЫЊЩѕШ§ШІЫЊШЄЩ€Ш±ЫЊвЂЊЩ‡Ш§ЫЊ ШўЩ…Ш§ШЇЩ‡ ШўЫЊЩ†ШЇЩ‡';

  @override
  String get homeNoRecentMessage =>
      'ШЁШ§ Ш¬ШіШЄШ¬Щ€ЫЊ ЩЃЫЊЩ„Щ… ЫЊШ§ ШўЩѕЩ„Щ€ШЇ ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі ШґШ±Щ€Ш№ Ъ©Щ† ШЄШ§ ШЄШ±Ш¬Щ…Щ‡вЂЊЩ‡Ш§ЫЊ Ш§Ш®ЫЊШ±ШЄ Ш§ЫЊЩ†Ш¬Ш§ ШЇЫЊШЇЩ‡ ШґЩ€Щ†ШЇ.';

  @override
  String get homeNoRecentTitle =>
      'Щ‡Щ†Щ€ШІ Ъ©Ш§Ш±ЫЊ ШЇШ± ШЁШ®Шґ Ш§Ш®ЫЊШ±Щ‡Ш§ Щ†ЫЊШіШЄ';

  @override
  String get homePreviewSubtitle =>
      'Щ‚ШЁЩ„ Ш§ШІ Ш®Ш±Щ€Ш¬ЫЊ ЪЇШ±ЩЃШЄЩ†ШЊ Щ†ШЄЫЊШ¬Щ‡ Ш±Ш§ ШЇШ± Ш­Ш§Щ„ШЄ Ш§ШµЩ„ЫЊШЊ ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡ ЫЊШ§ ШЇЩ€ШІШЁШ§Щ†Щ‡ ШЁШ±Ш±ШіЫЊ Ъ©Щ†.';

  @override
  String get homePreviewTitle =>
      'Ш¬Ш±ЫЊШ§Щ† ШЄШ±Ш¬Щ…Щ‡ ШЁШ§ Щ…Ш­Щ€Ш±ЫЊШЄ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ';

  @override
  String get homeQuickHistory => 'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡';

  @override
  String get homeQuickSearch => 'Ш¬ШіШЄШ¬Щ€';

  @override
  String get homeQuickUpload => 'ШўЩѕЩ„Щ€ШЇ';

  @override
  String get homeRecentJobsSubtitle =>
      'ШўШ®Ш±ЫЊЩ† Ш¬Щ„ШіЩ‡вЂЊЩ‡Ш§ЫЊ ШЄШ±Ш¬Щ…Щ‡вЂЊШ§ШЄ Ш±Ш§ ШЁШЇЩ€Щ† ШґШ±Щ€Ш№ Ш§ШІ ШµЩЃШ± ШЇЩ€ШЁШ§Ш±Щ‡ ШЁШ§ШІ Ъ©Щ†.';

  @override
  String get homeRecentJobsTitle => 'Ъ©Ш§Ш±Щ‡Ш§ЫЊ Ш§Ш®ЫЊШ±';

  @override
  String get homeSearchPlaceholder =>
      'Ш¬ШіШЄШ¬Щ€ЫЊ ЩЃЫЊЩ„Щ… ЫЊШ§ ШіШ±ЫЊШ§Щ„...';

  @override
  String get homeStatesSubtitle =>
      'Щ„Щ€ШЇЫЊЩ†ЪЇШЊ Ш­Ш§Щ„ШЄ Ш®Ш§Щ„ЫЊШЊ ШЄЩ„Ш§Шґ ШЇЩ€ШЁШ§Ш±Щ‡ШЊ Ш§Ш№ШЄШЁШ§Ш±ШіЩ†Ш¬ЫЊ Щ€ ШіЩ†Ш§Ш±ЫЊЩ€Щ‡Ш§ЫЊ ШўЩЃЩ„Ш§ЫЊЩ† ШўШІЩ…Ш§ЫЊШґЫЊ Ш§ШІ Щ‡Щ…Ш§Щ† Ш±Щ€ШІ Ш§Щ€Щ„ Ш¬ШІШ¦ЫЊ Ш§ШІ UX Щ‡ШіШЄЩ†ШЇ.';

  @override
  String get homeStatesTitle =>
      'Щ‡Щ…Щ‡ Щ€Ш¶Ш№ЫЊШЄвЂЊЩ‡Ш§ЫЊ Щ„Ш§ШІЩ… ШЇШ± Щ†ШёШ± ЪЇШ±ЩЃШЄЩ‡ ШґШЇЩ‡';

  @override
  String get homeTrendingNow => 'ШЄШ±Щ†ШЇЩ‡Ш§ЫЊ ЩЃШ№Щ„ЫЊ';

  @override
  String get homeTrustSubtitle =>
      'ЩЃШ№Щ„Ш§Щ‹ ШўШІЩ…Ш§ЫЊШґЫЊ Ш§ШіШЄШЊ Ш§Щ…Ш§ ШіШ§Ш®ШЄШ§Ш±Шґ Щ…Ш«Щ„ ЫЊЪ© Щ…Ш­ШµЩ€Щ„ Щ€Ш§Щ‚Ш№ЫЊ Щ€ Щ‚Ш§ШЁЩ„ Ш§Щ†ШЄШґШ§Ш± Ш·Ш±Ш§Ш­ЫЊ ШґШЇЩ‡.';

  @override
  String get homeTrustTitle =>
      'Ъ†Ш±Ш§ ШЄЫЊЩ…вЂЊЩ‡Ш§ ШЁЩ‡ ШўЩ† Ш§Ш№ШЄЩ…Ш§ШЇ Щ…ЫЊвЂЊЪ©Щ†Щ†ШЇ';

  @override
  String get homeViewAll => 'Щ…ШґШ§Щ‡ШЇЩ‡ Щ‡Щ…Щ‡';

  @override
  String get homeWelcomeSubtitle =>
      'ШІЫЊШ±Щ†Щ€ЫЊШі ЩѕЫЊШЇШ§ Ъ©Щ† Щ€ ШЄШ±Ш¬Щ…Щ‡ Ъ©Щ†';

  @override
  String get homeWelcomeTitle => 'Ш®Щ€Шґ ШЁШ±ЪЇШґШЄЫЊ';

  @override
  String jobConfidence(Object level) {
    return 'Ш§Ш·Щ…ЫЊЩ†Ш§Щ†: $level';
  }

  @override
  String get jobOpenPreview => 'ШЁШ§ШІ Ъ©Ш±ШЇЩ† ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ';

  @override
  String get jobReuseSubtitle =>
      'Ш§ШіШЄЩЃШ§ШЇЩ‡ ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ШІ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get jobReuseTranslation =>
      'Ш§ШіШЄЩЃШ§ШЇЩ‡ ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ШІ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get legalBodyAbout =>
      'SubFlix ЫЊЪ© Ъ©Щ„Ш§ЫЊЩ†ШЄ Flutter ШЁШ§ Ш­ШівЂЊЩ€Ш­Ш§Щ„ ЩѕШ±ЫЊЩ…ЫЊЩ€Щ… ШЁШ±Ш§ЫЊ ШЄШ±Ш¬Щ…Щ‡ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ Ш§ШіШЄ. Ш§ЫЊЩ† ШЁЫЊЩ„ШЇ Ш§ШІ Ш±ЫЊЩѕШ§ШІЫЊШЄЩ€Ш±ЫЊвЂЊЩ‡Ш§ЫЊ Щ…Ш§Ъ©ШЊ ШЄШЈШ®ЫЊШ± Щ…ШµЩ†Щ€Ш№ЫЊ Щ€ Ш°Ш®ЫЊШ±Щ‡вЂЊШіШ§ШІЫЊ Щ…Ш­Щ„ЫЊ Ш§ШіШЄЩЃШ§ШЇЩ‡ Щ…ЫЊвЂЊЪ©Щ†ШЇ ШЄШ§ Щ‚ШЁЩ„ Ш§ШІ Ш§ШЄШµШ§Щ„ ШЁЪ©вЂЊШ§Щ†ШЇ Щ€Ш§Щ‚Ш№ЫЊШЊ UI Щ€ Щ…Ш№Щ…Ш§Ш±ЫЊ ШЁЩ‡ ШЁЩ„Щ€Шє ШЁШ±ШіЩ†ШЇ.';

  @override
  String get legalBodyPrivacy =>
      'SubFlix ЩЃШ№Щ„Ш§Щ‹ ЩЃЩ‚Ш· ШЄШ±Ш¬ЫЊШ­Ш§ШЄ ШўШІЩ…Ш§ЫЊШґЫЊ Щ€ ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ ШЄШ±Ш¬Щ…Щ‡ Ш±Ш§ ШЁШ§ Ш°Ш®ЫЊШ±Щ‡вЂЊШіШ§ШІЫЊ Щ…Ш­Щ„ЫЊ Ш±Щ€ЫЊ ШЇШіШЄЪЇШ§Щ‡ Щ†ЪЇЩ‡ Щ…ЫЊвЂЊШЇШ§Ш±ШЇ. ШЇШ± ШўЫЊЩ†ШЇЩ‡ Щ…ЫЊвЂЊШЄЩ€Ш§Щ† Ш§ЫЊЩ† ШЁШ®Шґ Ш±Ш§ ШЁШ§ ЫЊЪ© ШЁЪ©вЂЊШ§Щ†ШЇ Щ€Ш§Щ‚Ш№ЫЊ ШЁЩ‡ Ш°Ш®ЫЊШ±Щ‡вЂЊШіШ§ШІЫЊ Ш§Ш­Ш±Ш§ШІ Щ‡Щ€ЫЊШЄвЂЊШґШЇЩ‡ШЊ Щ…ШіЫЊШ±Щ‡Ш§ЫЊ Щ…Щ…ЫЊШІЫЊ Щ€ ШіЫЊШ§ШіШЄвЂЊЩ‡Ш§ЫЊ Щ†ЪЇЩ‡вЂЊШЇШ§Ш±ЫЊ ШіЩ…ШЄ ШіШ±Щ€Ш± Ш§Ш±ШЄЩ‚Ш§ ШЇШ§ШЇ.';

  @override
  String get legalBodySupport =>
      'ШЁШ®Шґ ЩѕШґШЄЫЊШЁШ§Щ†ЫЊ ЩЃШ№Щ„Ш§Щ‹ ЩЃЩ‚Ш· Ш¬Ш§ЫЊвЂЊЩ†ЪЇЩ‡ШЇШ§Ш± Ш§ШіШЄ. ШЇШ± Щ†ШіШ®Щ‡ Щ€Ш§Щ‚Ш№ЫЊШЊ Ш§ЫЊЩ† Щ‚ШіЩ…ШЄ Щ…ЫЊвЂЊШЄЩ€Ш§Щ†ШЇ ШЁШЇЩ€Щ† ШЄШєЫЊЫЊШ± ШЇШ± ШіШ§Ш®ШЄШ§Ш± Ш§Щѕ ШЁЩ‡ Ш§ЫЊЩ…ЫЊЩ„ШЊ ЪЇШІШ§Ш±Шґ Щ…ШґЪ©Щ„ Щ€ ЩѕШґШЄЫЊШЁШ§Щ†ЫЊ Ш­ШіШ§ШЁвЂЊЩ‡Ш§ЫЊ ЩѕШ±ЫЊЩ…ЫЊЩ€Щ… Щ…ШЄШµЩ„ ШґЩ€ШЇ.';

  @override
  String get legalBodyTerms =>
      'Ш§ЫЊЩ† Щ†ШіШ®Щ‡ ШўШІЩ…Ш§ЫЊШґЫЊ ШЁШ±Ш§ЫЊ ШіЩ†Ш¬Шґ Ш¬Ш±ЫЊШ§Щ†вЂЊЩ‡Ш§ЫЊ Щ…Ш­ШµЩ€Щ„ШЊ Щ€Ш¶Ш№ЫЊШЄвЂЊЩ‡Ш§ЫЊ Ш±Ш§ШЁШ· Ъ©Ш§Ш±ШЁШ±ЫЊ Щ€ Щ…Ш±ШІЩ‡Ш§ЫЊ Щ…Ш№Щ…Ш§Ш±ЫЊ ШіШ§Ш®ШЄЩ‡ ШґШЇЩ‡ Ш§ШіШЄ. Щ€Щ‚ШЄЫЊ ШЁШ№ШЇШ§Щ‹ ЫЊЪ© ШЁЪ©вЂЊШ§Щ†ШЇ Щ€Ш§Щ‚Ш№ЫЊ Щ…ШЁШЄЩ†ЫЊ ШЁШ± NestJS Щ€ Postgres Щ…ШЄШµЩ„ ШґЩ€ШЇШЊ ШЁШ®Шґ Ш­Щ‚Щ€Щ‚ЫЊ Щ‡Щ… Щ…ЫЊвЂЊШЄЩ€Ш§Щ†ШЇ ШЁШ§ ШґШ±Ш§ЫЊШ· Щ€Ш§Щ‚Ш№ЫЊ ШіШ±Щ€ЫЊШі Щ€ Щ…ШЄЩ†вЂЊЩ‡Ш§ЫЊ Щ…Ш±ШЁЩ€Ш· ШЁЩ‡ ЩѕШ±ШЇШ§ШІШґ ШЇШ§ШЇЩ‡ ЪЇШіШЄШ±Шґ ЩѕЫЊШЇШ§ Ъ©Щ†ШЇ.';

  @override
  String get legalPlaceholderBody =>
      'Ш§ЫЊЩ† ШµЩЃШ­Щ‡ ШЇШ± Щ†ШіШ®Щ‡ ШЇЩ…Щ€ ЩЃЩ‚Ш· ЫЊЪ© Ш¬Ш§ЫЊвЂЊЩ†ЪЇЩ‡ШЇШ§Ш± Ш§ШіШЄ. ШўЩ† Ш±Ш§ ШЁЩ‡ Щ…Ш­ШЄЩ€Ш§ЫЊ Ш­Щ‚Щ€Щ‚ЫЊ Щ€Ш§Щ‚Ш№ЫЊ Щ…Ш­ШµЩ€Щ„ШЄ Щ€ШµЩ„ Ъ©Щ†.';

  @override
  String get legalTitleAbout => 'ШЇШ±ШЁШ§Ш±Щ‡ SubFlix';

  @override
  String get legalTitlePrivacy => 'Ш­Ш±ЫЊЩ… Ш®ШµЩ€ШµЫЊ';

  @override
  String get legalTitleSupport => 'ЩѕШґШЄЫЊШЁШ§Щ†ЫЊ';

  @override
  String get legalTitleTerms => 'ШґШ±Ш§ЫЊШ· Ш§ШіШЄЩЃШ§ШЇЩ‡';

  @override
  String get mediaTypeMovie => 'ЩЃЫЊЩ„Щ…';

  @override
  String get mediaTypeSeries => 'ШіШ±ЫЊШ§Щ„';

  @override
  String get metadataEstimatedDuration => 'Щ…ШЇШЄ ШІЩ…Ш§Щ† ШЄЩ‚Ш±ЫЊШЁЫЊ';

  @override
  String get metadataFormat => 'ЩЃШ±Щ…ШЄ';

  @override
  String get metadataLanguages => 'ШІШЁШ§Щ†вЂЊЩ‡Ш§';

  @override
  String get metadataLines => 'Ш®Ш·Щ€Ш·';

  @override
  String get navHistory => 'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡';

  @override
  String get navHome => 'Ш®Ш§Щ†Щ‡';

  @override
  String get navSettings => 'ШЄЩ†ШёЫЊЩ…Ш§ШЄ';

  @override
  String get noTitlesMatchedMessage =>
      'Щ†ШЄЩ€Ш§Щ†ШіШЄЫЊЩ… Ш§ЫЊЩ† Ш№Щ†Щ€Ш§Щ† Ш±Ш§ ШЇШ± Ъ©Ш§ШЄШ§Щ„Щ€ЪЇ ШўШІЩ…Ш§ЫЊШґЫЊ ЩѕЫЊШЇШ§ Ъ©Щ†ЫЊЩ…. ЫЊЪ© Ш¬ШіШЄШ¬Щ€ЫЊ Ъ©Щ„ЫЊвЂЊШЄШ± ЫЊШ§ ЫЊЪ©ЫЊ Ш§ШІ Ш№Щ†Щ€Ш§Щ†вЂЊЩ‡Ш§ЫЊ ЩѕЫЊШґЩ†Щ‡Ш§ШЇЫЊ Ш±Ш§ Ш§Щ…ШЄШ­Ш§Щ† Ъ©Щ†.';

  @override
  String get noTitlesMatchedTitle => 'Щ†ШЄЫЊШ¬Щ‡вЂЊШ§ЫЊ ЩѕЫЊШЇШ§ Щ†ШґШЇ';

  @override
  String get onboardingContinue => 'Ш§ШЇШ§Щ…Щ‡';

  @override
  String get onboardingEnterApp => 'Щ€Ш±Щ€ШЇ ШЁЩ‡ SubFlix';

  @override
  String get onboardingNext => 'ШЁШ№ШЇЫЊ';

  @override
  String get onboardingPage1Description =>
      'ЫЊЪ© Ш№Щ†Щ€Ш§Щ† Ш¬ШіШЄШ¬Щ€ Ъ©Щ†ШЊ Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ЪЇЩ„ЫЊШіЫЊ Щ…Щ€Ш¬Щ€ШЇ Ш±Ш§ ШЁШЁЫЊЩ† Щ€ Ш¬Ш±ЫЊШ§Щ† ШЄШ±Ш¬Щ…Щ‡вЂЊШ§ЫЊ Ш±Ш§ ШґШ±Щ€Ш№ Ъ©Щ† Ъ©Щ‡ ШіШ±ЫЊШ№ Щ€ Ш±Щ€Ш§Щ† Ш§Ш­ШіШ§Ші Щ…ЫЊвЂЊШґЩ€ШЇ.';

  @override
  String get onboardingPage1Eyebrow => 'Ш¬ШіШЄШ¬Щ€ Щ€ ШЇШ±ЫЊШ§ЩЃШЄ';

  @override
  String get onboardingPage1Highlight1 =>
      'Ъ©Ш§ШЄШ§Щ„Щ€ЪЇ Щ…Ш§Ъ© Щ‚Ш·Ш№ЫЊ ШЁШ±Ш§ЫЊ ШЄЩ€ШіШ№Щ‡ Щ…Ш·Щ…Ш¦Щ†';

  @override
  String get onboardingPage1Highlight2 =>
      'ШЁШ±Ъ†ШіШЁ Ъ©ЫЊЩЃЫЊШЄ Щ…Щ†ШЁШ№ Щ€ Щ†ШґШ§Щ† ЩЃШ±Щ…ШЄ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get onboardingPage1Highlight3 =>
      'Ш·Щ€Ш±ЫЊ ШіШ§Ш®ШЄЩ‡ ШґШЇЩ‡ Ъ©Щ‡ ШЁШ№ШЇШ§Щ‹ ШЁЩ‡ ШЁЪ©вЂЊШ§Щ†ШЇ Щ€Ш§Щ‚Ш№ЫЊ Щ€ШµЩ„ ШґЩ€ШЇ';

  @override
  String get onboardingPage1Title =>
      'ЩЃЫЊЩ„Щ… ЫЊШ§ ШіШ±ЫЊШ§Щ„ ЩѕЫЊШЇШ§ Ъ©Щ† Щ€ ШІЫЊШ±Щ†Щ€ЫЊШі ШўЩ…Ш§ШЇЩ‡ ШЄШ±Ш¬Щ…Щ‡ Ш±Ш§ ШЁЪЇЫЊШ±.';

  @override
  String get onboardingPage2Description =>
      'ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ Щ€Ш§Ш±ШЇ Ъ©Щ†ШЊ ЩЃШ±Щ…ШЄ Ш±Ш§ Ш§Ш№ШЄШЁШ§Ш±ШіЩ†Ш¬ЫЊ Ъ©Щ† Щ€ ШЁШЇЩ€Щ† Ш®Ш±Щ€Ш¬ Ш§ШІ Ш§Щѕ Щ‡Щ…Ш§Щ† Щ…ШіЫЊШ± ШЄШ±Ш¬Щ…Щ‡ Ш­Ш±ЩЃЩ‡вЂЊШ§ЫЊ Ш±Ш§ Ш§Ш¬Ш±Ш§ Ъ©Щ†.';

  @override
  String get onboardingPage2Eyebrow => 'ЩЃШ§ЫЊЩ„ Ш®Щ€ШЇШЄ Ш±Ш§ ШЁЫЊШ§Щ€Ш±';

  @override
  String get onboardingPage2Highlight1 =>
      'Ш§Ш№ШЄШЁШ§Ш±ШіЩ†Ш¬ЫЊ Щ…Ш­Щ„ЫЊ ЩЃШ§ЫЊЩ„ Щ€ Ш­Ш§Щ„ШЄвЂЊЩ‡Ш§ЫЊ ШЄЩ„Ш§Шґ ШЇЩ€ШЁШ§Ш±Щ‡ Ш±Щ€Ш§Щ†';

  @override
  String get onboardingPage2Highlight2 =>
      'ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡ ЫЊЪ©ШЇШіШЄ ШЁШ±Ш§ЫЊ ШўЩѕЩ„Щ€ШЇ Щ€ Ш¬ШіШЄШ¬Щ€';

  @override
  String get onboardingPage2Highlight3 =>
      'Щ‚ШЁЩ„ Ш§ШІ Ш®Ш±Щ€Ш¬ЫЊ ЪЇШ±ЩЃШЄЩ† ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ШЁШЁЫЊЩ† ШЄШ§ Ъ†ЫЊШІЫЊ Щ…ШЁЩ‡Щ… Щ†Щ…Ш§Щ†ШЇ';

  @override
  String get onboardingPage2Title =>
      'Щ€Щ‚ШЄЫЊ ЩЃШ§ЫЊЩ„ Ш±Ш§ ШЇШ§Ш±ЫЊШЊ `.srt` ЫЊШ§ `.vtt` ШўЩѕЩ„Щ€ШЇ Ъ©Щ†.';

  @override
  String get onboardingPage3Description =>
      'ШЁЫЊЩ† Щ†Щ…Ш§ЫЊШґ Ш§ШµЩ„ЫЊШЊ ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡ Щ€ ШЇЩ€ШІШЁШ§Щ†Щ‡ Ш¬Ш§ШЁЩ‡вЂЊШ¬Ш§ ШґЩ€ШЊ ШЁЩ‡ ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ ШіШ± ШЁШІЩ† Щ€ Щ€Щ‚ШЄЫЊ Щ†ШЄЫЊШ¬Щ‡ ШЇШ±ШіШЄ ШЁЩ€ШЇ ЩЃШ§ЫЊЩ„ ШЄЩ…ЫЊШІ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ Ш®Ш±Щ€Ш¬ЫЊ ШЁЪЇЫЊШ±.';

  @override
  String get onboardingPage3Eyebrow => 'ШЄШ±Ш¬Щ…Щ‡ Щ€ Ш®Ш±Щ€Ш¬ЫЊ';

  @override
  String get onboardingPage3Highlight1 =>
      'Ъ©Щ†ШЄШ±Щ„вЂЊЩ‡Ш§ЫЊ ШіШ±ЫЊШ№ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ Щ‡Щ…Ш±Ш§Щ‡ ШЁШ§ Щ…ШЄШ§ШЇЫЊШЄШ§ Щ€ Ш¬ШіШЄШ¬Щ€';

  @override
  String get onboardingPage3Highlight2 =>
      'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ШЊ Ъ©Ш§Ш±Щ‡Ш§ЫЊ Щ‚ШЁЩ„ЫЊ Ш±Ш§ ЩЃЩ‚Ш· ШЁШ§ ЫЊЪ© Щ„Щ…Ші ШЇШ± ШЇШіШЄШ±Ші Щ†ЪЇЩ‡ Щ…ЫЊвЂЊШЇШ§Ш±ШЇ';

  @override
  String get onboardingPage3Highlight3 =>
      'Ш·Ш±Ш§Ш­ЫЊвЂЊШґШЇЩ‡ Щ…Ш«Щ„ ЫЊЪ© Ш§ШЁШІШ§Ш± Ш±ШіШ§Щ†Щ‡вЂЊШ§ЫЊ ЩѕШ±ЫЊЩ…ЫЊЩ€Щ…ШЊ Щ†Щ‡ ЫЊЪ© ШЇЩ…Щ€';

  @override
  String get onboardingPage3Title =>
      'ШІШЁШ§Щ† Щ…Щ‚ШµШЇ Ш±Ш§ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ†ШЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ШЁШЁЫЊЩ† Щ€ ЩЃЩ€Ш±ЫЊ Ш®Ш±Щ€Ш¬ЫЊ ШЁЪЇЫЊШ±.';

  @override
  String get onboardingSkip => 'Ш±ШЇ Ъ©Ш±ШЇЩ†';

  @override
  String get onboardingStart => 'ШґШ±Щ€Ш№ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get previewFailedTitle =>
      'ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ';

  @override
  String get previewModeBilingual => 'ШЇЩ€ШІШЁШ§Щ†Щ‡';

  @override
  String get previewModeOriginal => 'Ш§ШµЩ„';

  @override
  String get previewModeTranslated => 'ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡';

  @override
  String get previewNoMatchesMessage =>
      'ЫЊЪ© Ш№ШЁШ§Ш±ШЄ ШЇЫЊЪЇШ± Ш±Ш§ Ш¬ШіШЄШ¬Щ€ Ъ©Щ† ЫЊШ§ ЩЃЫЊЩ„ШЄШ± Ш±Ш§ ЩѕШ§Ъ© Ъ©Щ† ШЄШ§ Ъ©Щ„ ШЄШ±Ш¬Щ…Щ‡ Ш±Ш§ ШЁШЁЫЊЩ†ЫЊ.';

  @override
  String get previewNoMatchesTitle => 'Щ‡ЫЊЪ† Ш®Ш·ЫЊ ЩѕЫЊШЇШ§ Щ†ШґШЇ';

  @override
  String get previewNotReadyMessage =>
      'ШЄШ±Ш¬Щ…Щ‡ ШЄЩ…Ш§Щ… ШґШЇЩ‡ШЊ Ш§Щ…Ш§ ШЁЪ©вЂЊШ§Щ†ШЇ Щ‡Щ†Щ€ШІ cueЩ‡Ш§ЫЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ Ш±Ш§ ШЁШ±Щ†ЪЇШ±ШЇШ§Щ†ШЇЩ‡ Ш§ШіШЄ. Ъ©Щ…ЫЊ ШЁШ№ШЇ ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ЫЊЩ† ШµЩЃШ­Щ‡ Ш±Ш§ ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ Ъ©Щ†.';

  @override
  String get previewNotReadyTitle =>
      'cueЩ‡Ш§ЫЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ Щ‡Щ†Щ€ШІ ШўЩ…Ш§ШЇЩ‡ Щ†ЫЊШіШЄЩ†ШЇ';

  @override
  String get retry => 'ШЄЩ„Ш§Шґ ШЇЩ€ШЁШ§Ш±Щ‡';

  @override
  String get retryTranslation => 'ШЄШ±Ш¬Щ…Щ‡ ШЇЩ€ШЁШ§Ш±Щ‡';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Щ†ШЄЩ€Ш§Щ†ШіШЄЫЊЩ… ШЄШґШ®ЫЊШµ ШЇЩ‡ЫЊЩ… Ъ©ШЇШ§Щ… ЩЃШµЩ„ ШЁШ§ЫЊШЇ ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ШґЩ€ШЇ. ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ШІ Ш¬ШіШЄШ¬Щ€ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Щ‚ШіЩ…ШЄвЂЊЩ‡Ш§ЫЊ ЩЃШµЩ„';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Щ†ШЄЩ€Ш§Щ†ШіШЄЫЊЩ… ШЄШґШ®ЫЊШµ ШЇЩ‡ЫЊЩ… Ъ©ШЇШ§Щ… ШіШ±ЫЊШ§Щ„ ШЁШ§ЫЊШЇ ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ШґЩ€ШЇ. ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ШІ Ш¬ШіШЄШ¬Щ€ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'ЩЃШµЩ„вЂЊЩ‡Ш§ЫЊ ШіШ±ЫЊШ§Щ„';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Щ†ШЄЩ€Ш§Щ†ШіШЄЫЊЩ… ШЄШґШ®ЫЊШµ ШЇЩ‡ЫЊЩ… Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁШ±Ш§ЫЊ Ъ©ШЇШ§Щ… Ш№Щ†Щ€Ш§Щ† ШЁШ§ЫЊШЇ ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ШґЩ€Щ†ШЇ. ШЇЩ€ШЁШ§Ш±Щ‡ Ш§ШІ Ш¬ШіШЄШ¬Щ€ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Щ‡ЫЊЪ† ШЇШ±Ш®Щ€Ш§ШіШЄ ШЄШ±Ш¬Щ…Щ‡вЂЊШ§ЫЊ Ш§Ш±ШіШ§Щ„ Щ†ШґШЇЩ‡ Ш§ШіШЄ. ЫЊЪ© ШЄШ±Ш¬Щ…Щ‡ Ш¬ШЇЫЊШЇ Ш±Ш§ Ш§ШІ Щ…ШіЫЊШ± Ш¬ШіШЄШ¬Щ€ ЫЊШ§ ШўЩѕЩ„Щ€ШЇ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get routeMissingTranslationProgressTitle => 'Ш±Щ€Щ†ШЇ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Щ‚ШЁЩ„ Ш§ШІ ШЁШ§ШІ ШґШЇЩ† ШµЩЃШ­Щ‡ ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡ШЊ Щ€Ш¬Щ€ШЇ ЫЊЪ© Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш¶Ш±Щ€Ш±ЫЊ Ш§ШіШЄ.';

  @override
  String get routeMissingTranslationSetupTitle => 'ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get searchFailedTitle => 'Ш¬ШіШЄШ¬Щ€ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count Щ†ШЄЫЊШ¬Щ‡ ШЁШ±Ш§ЫЊ \"$query\" ЩѕЫЊШЇШ§ ШґШЇ';
  }

  @override
  String get searchHintText =>
      'Щ…Ш«Щ„Ш§Щ‹ Dune ЫЊШ§ Breaking Bad ЫЊШ§ Severance Ш±Ш§ Ш¬ШіШЄШ¬Щ€ Ъ©Щ†...';

  @override
  String get searchLoadingLabel => 'ШЇШ± Ш­Ш§Щ„ Ш¬ШіШЄШ¬Щ€...';

  @override
  String get searchMockMessage =>
      'ШЁШ±Ш§ЫЊ ШЇЫЊШЇЩ† Ш¬Ш±ЫЊШ§Щ† Ш§Щ†ШЄШ®Ш§ШЁ Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШіШЊ Ш№Щ†Щ€Ш§Щ†вЂЊЩ‡Ш§ЫЊЫЊ Щ…Ш«Щ„ InceptionШЊ DuneШЊ Breaking BadШЊ Severance ЫЊШ§ The Last of Us Ш±Ш§ Ш§Щ…ШЄШ­Ш§Щ† Ъ©Щ†.';

  @override
  String get searchMockTitle =>
      'Щ‡Ш± Ъ†ЫЊШІЫЊ Ш±Ш§ ШЇШ± Ъ©Ш§ШЄШ§Щ„Щ€ЪЇ ШўШІЩ…Ш§ЫЊШґЫЊ Ш¬ШіШЄШ¬Щ€ Ъ©Щ†';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'ЫЊЪ© Ш№Щ†Щ€Ш§Щ† ЩѕЫЊШЇШ§ Ъ©Щ†ШЊ Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁШ±Ш±ШіЫЊ Ъ©Щ† Щ€ ЩЃЩ‚Ш· ШЁШ§ Ъ†Щ†ШЇ Щ„Щ…Ші ШЄШ±Ш¬Щ…Щ‡ Ш±Ш§ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get searchMovieOrSeriesTitle =>
      'Ш¬ШіШЄШ¬Щ€ЫЊ ЩЃЫЊЩ„Щ… ЫЊШ§ ШіШ±ЫЊШ§Щ„';

  @override
  String searchNoResultsFor(Object query) {
    return 'Щ†ШЄЫЊШ¬Щ‡вЂЊШ§ЫЊ ШЁШ±Ш§ЫЊ \"$query\" ЩѕЫЊШЇШ§ Щ†ШґШЇ';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Щ…Ш­ШЁЩ€ШЁЫЊШЄ $score';
  }

  @override
  String get searchTitles => 'Ш¬ШіШЄШ¬Щ€ЫЊ Ш№Щ†Щ€Ш§Щ†вЂЊЩ‡Ш§';

  @override
  String get searchTrendingTitle => 'Ш¬ШіШЄШ¬Щ€Щ‡Ш§ЫЊ ЩѕШ±Ш·Ш±ЩЃШЇШ§Ш±';

  @override
  String get searchTryDifferentKeywords =>
      'ШЁШ§ Ъ©Щ„Щ…Ш§ШЄ Ъ©Щ„ЫЊШЇЫЊ ШЇЫЊЪЇШ±ЫЊ Ш¬ШіШЄШ¬Щ€ Ъ©Щ†.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Щ‚ШіЩ…ШЄ $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Ш­ШЇЩ€ШЇ $runtime ШЇЩ‚ЫЊЩ‚Щ‡';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount Щ‚ШіЩ…ШЄ$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'ЩЃШµЩ„ $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'ЩЃШµЩ„ $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount Щ‚ШіЩ…ШЄ$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'ЫЊЪ© ЩЃШµЩ„ Ш§ШІ $title Ш±Ш§ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ† ШЄШ§ Щ‚ШіЩ…ШЄвЂЊЩ‡Ш§ЫЊ Щ…Щ€Ш¬Щ€ШЇ Ш±Ш§ ШЁШЁЫЊЩ†ЫЊ.';
  }

  @override
  String get seriesSeasonsTitle => 'ЫЊЪ© ЩЃШµЩ„ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ†';

  @override
  String get settingsAboutTitle => 'ШЇШ±ШЁШ§Ш±Щ‡ SubFlix';

  @override
  String get settingsCacheCleared => 'Ъ©Шґ ЩѕШ§Ъ© ШґШЇ';

  @override
  String get settingsClearCache => 'ЩѕШ§Ъ© Ъ©Ш±ШЇЩ† Ъ©Шґ';

  @override
  String get settingsContactTitle => 'ШЄЩ…Ш§Ші ШЁШ§ Щ…Ш§';

  @override
  String get settingsFailedTitle =>
      'ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ ШЄЩ†ШёЫЊЩ…Ш§ШЄ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ';

  @override
  String get settingsHelpCenterTitle => 'Щ…Ш±Ъ©ШІ Ш±Ш§Щ‡Щ†Щ…Ш§';

  @override
  String get settingsHistoryClearedSnack =>
      'ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ ШЄШ±Ш¬Щ…Щ‡ ШЁШ±Ш§ЫЊ Ш§ЫЊЩ† ШЇШіШЄЪЇШ§Щ‡ ЩѕШ§Ъ© ШґШЇ';

  @override
  String get settingsLanguageLabel => 'ШІШЁШ§Щ† Щ…Щ‚ШµШЇ ШЄШ±Ш¬ЫЊШ­ЫЊ';

  @override
  String get settingsMaintenanceSubtitle =>
      'Ъ©Ш§Ш±Щ‡Ш§ЫЊ ШЄШ±Ш¬Щ…Щ‡ Щ€Ш§ШЁШіШЄЩ‡ ШЁЩ‡ ШЁЪ©вЂЊШ§Щ†ШЇ Ш±Ш§ ШЁШ±Ш§ЫЊ Ш§ЫЊЩ† ШЇШіШЄЪЇШ§Щ‡ ЩѕШ§Ъ© Ъ©Щ† Щ€ ШЁШ§ ЫЊЪ© ШЄШ§Ш±ЫЊШ®Ъ†Щ‡ Ш®Ш§Щ„ЫЊ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get settingsMaintenanceTitle => 'Щ†ЪЇЩ‡вЂЊШЇШ§Ш±ЫЊ';

  @override
  String get settingsNotificationsSubtitle =>
      'ШЄЩ†ШёЫЊЩ…Ш§ШЄ Ш§Ш№Щ„Ш§Щ†вЂЊЩ‡Ш§ Ш±Ш§ Щ…ШЇЫЊШ±ЫЊШЄ Ъ©Щ†';

  @override
  String get settingsNotificationsTitle => 'Ш§Ш№Щ„Ш§Щ†вЂЊЩ‡Ш§';

  @override
  String get settingsPremiumSubtitle =>
      'ШЁШ№ШЇШ§Щ‹ Щ…ЫЊвЂЊШЄЩ€Ш§Щ†ЫЊЩ… Ш§ШґШЄШ±Ш§Ъ©вЂЊЩ‡Ш§ШЊ ЩѕШ±ШЇШ§Ш®ШЄ Щ€ Щ‡Щ…ЪЇШ§Щ…вЂЊШіШ§ШІЫЊ ЩѕШ±Щ€ЪЩ‡ Ш§ШЁШ±ЫЊ Ш±Ш§ Ш§ЫЊЩ†Ш¬Ш§ Щ€ШµЩ„ Ъ©Щ†ЫЊЩ….';

  @override
  String get settingsPremiumTitle => 'ШЁШ®Шґ ЩѕШ±ЫЊЩ…ЫЊЩ€Щ… ШўШІЩ…Ш§ЫЊШґЫЊ';

  @override
  String get settingsPrivacySubtitle =>
      'Щ…Ш­ШЄЩ€Ш§ЫЊ ШўШІЩ…Ш§ЫЊШґЫЊ Ш­Ш±ЫЊЩ… Ш®ШµЩ€ШµЫЊ';

  @override
  String get settingsPrivacyTitle => 'Ш­Ш±ЫЊЩ… Ш®ШµЩ€ШµЫЊ';

  @override
  String get settingsProfileName => 'Ъ©Ш§Ш±ШЁШ± SubFlix';

  @override
  String get settingsProfileTier => 'Ш№Ш¶Щ€ ЩѕШ±ЫЊЩ…ЫЊЩ€Щ…';

  @override
  String get settingsSubtitle => 'ШЄШ±Ш¬ЫЊШ­Ш§ШЄШЄ Ш±Ш§ Щ…ШЇЫЊШ±ЫЊШЄ Ъ©Щ†';

  @override
  String get settingsSupportSubtitle =>
      'ШµЩЃШ­Щ‡ Щ†Щ…Щ€Щ†Щ‡ ШЁШ±Ш§ЫЊ Ш±Ш§Щ‡Щ†Щ…Ш§ Щ€ ШЄЩ…Ш§Ші';

  @override
  String get settingsSupportTitle => 'ШЁШ®Шґ ЩѕШґШЄЫЊШЁШ§Щ†ЫЊ ШўШІЩ…Ш§ЫЊШґЫЊ';

  @override
  String get settingsTermsSubtitle =>
      'Щ…Ш­ШЄЩ€Ш§ЫЊ ШўШІЩ…Ш§ЫЊШґЫЊ ШґШ±Ш§ЫЊШ· Ш§ШіШЄЩЃШ§ШЇЩ‡';

  @override
  String get settingsTermsTitle => 'ШґШ±Ш§ЫЊШ· Ш§ШіШЄЩЃШ§ШЇЩ‡';

  @override
  String get settingsThemeLabel => 'ШёШ§Щ‡Ш±';

  @override
  String get settingsTitle => 'ШЄЩ†ШёЫЊЩ…Ш§ШЄ';

  @override
  String settingsVersion(Object version) {
    return 'Щ†ШіШ®Щ‡ $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing =>
      'ШЇШ± Ш­Ш§Щ„ ШўЩ…Ш§ШЇЩ‡вЂЊШіШ§ШІЫЊ Ш§ШіШЄЩ€ШЇЫЊЩ€ЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі ШЄЩ€';

  @override
  String get splashSubtitle =>
      'ШЄШ±Ш¬Щ…Щ‡ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ';

  @override
  String get startTranslation => 'ШґШ±Щ€Ш№ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads ШЇШ§Щ†Щ„Щ€ШЇ';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount Ш®Ш·';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'Ш§Щ…ШЄЫЊШ§ШІ $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'ЫЊЪ© Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ† Щ€ Щ€Ш§Ш±ШЇ ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡вЂЊШ§ЫЊ ШґЩ€ Ъ©Щ‡ ШЁШ±Ш§ЫЊ ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁЩ‡ЫЊЩ†Щ‡ ШґШЇЩ‡ Ш§ШіШЄ.';

  @override
  String get subtitleSourcesBannerTitle =>
      'ШЄШ±Ш¬Щ…Щ‡ ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ ШЇШ± ШЇШіШЄШ±Ші Ш§ШіШЄ';

  @override
  String get subtitleSourcesFailedTitle =>
      'ШЁШ§Ш±ЪЇШ°Ш§Ш±ЫЊ Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Щ…Щ…Ъ©Щ† Щ†ШґШЇ';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'ШЁШ±Ш§ЫЊ $title$target ЫЊЪ© Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ† Щ€ ШЇШ± Щ…Ш±Ш­Щ„Щ‡ ШЁШ№ШЇ ШІШЁШ§Щ† Щ…Щ‚ШµШЇ Ш±Ш§ Щ…ШґШ®Шµ Ъ©Щ†.';
  }

  @override
  String get subtitleSourcesTitle => 'Щ…Щ†Ш§ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ЪЇЩ„ЫЊШіЫЊ';

  @override
  String get targetLanguage => 'ШІШЁШ§Щ† Щ…Щ‚ШµШЇ';

  @override
  String get themeDark => 'ШЄЫЊШ±Щ‡';

  @override
  String get themeLight => 'Ш±Щ€ШґЩ†';

  @override
  String get themeSystem => 'ШіЫЊШіШЄЩ…';

  @override
  String get translateSetupAutoDetect => 'ШЄШґШ®ЫЊШµ Ш®Щ€ШЇЪ©Ш§Ш± ЩЃШ±Щ…ШЄ';

  @override
  String get translateSetupAutoDetectBody =>
      'ШіШ§Ш®ШЄШ§Ш± Щ…Щ†Ш§ШіШЁ Ш®Ш±Щ€Ш¬ЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁЩ‡вЂЊШµЩ€Ш±ШЄ Ш®Щ€ШЇЪ©Ш§Ш± Ш§Щ†ШЄШ®Ш§ШЁ Щ…ЫЊвЂЊЪ©Щ†ШЇ.';

  @override
  String get translateSetupLanguageTitle => 'ШЄШ±Ш¬Щ…Щ‡ ШЁЩ‡';

  @override
  String get translateSetupOptionsTitle => 'ЪЇШІЫЊЩ†Щ‡вЂЊЩ‡Ш§';

  @override
  String get translateSetupPreserveTiming => 'Ш­ЩЃШё ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ';

  @override
  String get translateSetupPreserveTimingBody =>
      'ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ Ш§ШµЩ„ЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁШ§ ЩЃШ§ЫЊЩ„ Щ…ШЁШЇШЈ Щ‡Щ…Ш§Щ‡Щ†ЪЇ Щ†ЪЇЩ‡ Щ…ЫЊвЂЊШЇШ§Ш±ШЇ.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Ш¬Ш±ЫЊШ§Щ† ШЄШ±Ш¬Щ…Щ‡ Щ…Ш§ Ш§ЫЊЩ† ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁШ§ Ш­ЩЃШё ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ Щ€ ШіШ§Ш®ШЄШ§Ш± ШЄЩ…ЫЊШІ cueЩ‡Ш§ ШЁЩ‡ $language ШЄШЁШЇЫЊЩ„ Щ…ЫЊвЂЊЪ©Щ†ШЇ.';
  }

  @override
  String get translateSetupReadyTitle =>
      'ШЄШ±Ш¬Щ…Щ‡ ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ ШўЩ…Ш§ШЇЩ‡ Ш§ШіШЄ';

  @override
  String get translateSetupSelectLanguage => 'Ш§Щ†ШЄШ®Ш§ШЁ ШІШЁШ§Щ†';

  @override
  String get translateSetupSourceTitle => 'ШІЫЊШ±Щ†Щ€ЫЊШі Щ…ШЁШЇШЈ';

  @override
  String get translateSetupSubtitle =>
      'ШІШЁШ§Щ† Щ…Щ‚ШµШЇ Ш±Ш§ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ†ШЊ Щ…Щ†ШЁШ№ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁШ±Ш±ШіЫЊ Ъ©Щ† Щ€ ШЁШ№ШЇ Ъ©Ш§Ш± ШЄШ±Ш¬Щ…Щ‡ Ш±Ш§ ШЇШ± ШЁЪ©вЂЊШ§Щ†ШЇ ШґШ±Щ€Ш№ Ъ©Щ†.';

  @override
  String get translateSetupTitle => 'ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationFailedMessage => 'Щ…ШґЪ©Щ„ЫЊ ЩѕЫЊШґ ШўЩ…ШЇ.';

  @override
  String get translationFailedTitle => 'ШЄШ±Ш¬Щ…Щ‡ Ъ©Ш§Щ…Щ„ Щ†ШґШЇ';

  @override
  String get translationPreviewHeader =>
      'ШІЫЊШ±Щ†Щ€ЫЊШівЂЊЩ‡Ш§ЫЊ ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡ Ш±Ш§ ШЁШ±Ш±ШіЫЊ Ъ©Щ†';

  @override
  String get translationPreviewSearchHint =>
      'Ш¬ШіШЄШ¬Щ€ ШЇШ± Ш®Ш·Щ€Ш· ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get translationPreviewSubtitle =>
      'ШЇШ± cueЩ‡Ш§ Ш¬ШіШЄШ¬Щ€ Ъ©Щ†ШЊ Ш­Ш§Щ„ШЄ Щ†Щ…Ш§ЫЊШґ Ш±Ш§ Ш№Щ€Ш¶ Ъ©Щ† Щ€ Щ€Щ‚ШЄЫЊ Щ†ШЄЫЊШ¬Щ‡ ШЇШ±ШіШЄ ШЁЩ€ШЇ Ш®Ш±Щ€Ш¬ЫЊ ШЁЪЇЫЊШ±.';

  @override
  String get translationPreviewTitle => 'ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationProgressHeadline =>
      'ШЄШ±Ш¬Щ…Щ‡ ШІЫЊШ±Щ†Щ€ЫЊШі ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ ШЇШ± Ш­Ш§Щ„ Ш§Щ†Ш¬Ш§Щ… Ш§ШіШЄ';

  @override
  String get translationProgressTitle => 'Ш±Щ€Щ†ШЇ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationResultCompleteSubtitle =>
      'ШІЫЊШ±Щ†Щ€ЫЊШі ШЄЩ€ ШЁШ±Ш§ЫЊ ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ЫЊШ§ ШЇШ§Щ†Щ„Щ€ШЇ ШўЩ…Ш§ШЇЩ‡ Ш§ШіШЄ.';

  @override
  String get translationResultCompleteTitle => 'ШЄШ±Ш¬Щ…Щ‡ Ъ©Ш§Щ…Щ„ ШґШЇ';

  @override
  String get translationResultConfidenceLabel =>
      'Щ…ЫЊШІШ§Щ† Ш§Ш·Щ…ЫЊЩ†Ш§Щ† ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationResultDetailsTitle => 'Ш¬ШІШ¦ЫЊШ§ШЄ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationResultDownloadCta => 'ШЇШ§Щ†Щ„Щ€ШЇ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get translationResultHomeCta => 'ШЁШ§ШІЪЇШґШЄ ШЁЩ‡ Ш®Ш§Щ†Щ‡';

  @override
  String get translationResultMediaLabel => 'Ш№Щ†Щ€Ш§Щ† Ш§Ш«Ш±';

  @override
  String get translationResultMethodAi =>
      'ШЄШ±Ш¬Щ…Щ‡вЂЊШґШЇЩ‡ ШЁШ§ Щ‡Щ€Шґ Щ…ШµЩ†Щ€Ш№ЫЊ';

  @override
  String get translationResultMetricsTitle => 'ШґШ§Ш®ШµвЂЊЩ‡Ш§ЫЊ Ъ©ЫЊЩЃЫЊШЄ';

  @override
  String get translationResultPreviewCta =>
      'ЩѕЫЊШґвЂЊЩ†Щ…Ш§ЫЊШґ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'ШЇШ± $duration ЩѕШ±ШЇШ§ШІШґ ШґШЇ';
  }

  @override
  String get translationResultSourceLabel => 'ШІШЁШ§Щ† Щ…ШЁШЇШЈ';

  @override
  String get translationResultTargetLabel => 'ШІШЁШ§Щ† Щ…Щ‚ШµШЇ';

  @override
  String get translationResultTimingLabel => 'ШЇЩ‚ШЄ ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ';

  @override
  String get translationResultTimingPreserved =>
      'ШІЩ…Ш§Щ†вЂЊШЁЩ†ШЇЫЊ Ш­ЩЃШё ШґШЇЩ‡';

  @override
  String get translationResultWarning =>
      'ШЁШ№Ш¶ЫЊ Ш§ШµШ·Щ„Ш§Ш­Ш§ШЄ ШЄШ®ШµШµЫЊ ШґШ§ЫЊШЇ Щ‡Щ†Щ€ШІ ШЁШ±Ш§ЫЊ ШЇШ±Ъ© ШЁЩ‡ШЄШ± ШЁШ§ЩЃШЄ Ш¬Щ…Щ„Щ‡ ШЁЩ‡ ЫЊЪ© ШЁШ§ШІШЁЫЊЩ†ЫЊ Ш§Щ†ШіШ§Щ†ЫЊ ШіШ±ЫЊШ№ Щ†ЫЊШ§ШІ ШЇШ§ШґШЄЩ‡ ШЁШ§ШґЩ†ШЇ.';

  @override
  String get translationStageAligning =>
      'ШЇШ± Ш­Ш§Щ„ Щ‡Щ…Ш§Щ‡Щ†ЪЇвЂЊШіШ§ШІЫЊ ШІЩ…Ш§Щ†вЂЊЩ‡Ш§ Щ€ ЩЃШ¶Ш§ЫЊ ШµШ­Щ†Щ‡';

  @override
  String get translationStageGenerating =>
      'ШЇШ± Ш­Ш§Щ„ ШЄЩ€Щ„ЫЊШЇ ШЄШ±Ш¬Щ…Щ‡ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get translationStageIdle =>
      'ШЇШ± Ш§Щ†ШЄШёШ§Ш± ШЇШ±Ш®Щ€Ш§ШіШЄ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationStagePreparing =>
      'ШЇШ± Ш­Ш§Щ„ ШўЩ…Ш§ШЇЩ‡вЂЊШіШ§ШІЫЊ ШЁШіШЄЩ‡ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get translationStageQueued => 'ШЇШ± ШµЩЃ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get translationStageReadability =>
      'ШЇШ± Ш­Ш§Щ„ Ш§Ш№Щ…Ш§Щ„ ШЁШ§ШІШЁЫЊЩ†ЫЊ Ш®Щ€Ш§Щ†Ш§ЫЊЫЊ';

  @override
  String get translationStageReady => 'ШЄШ±Ш¬Щ…Щ‡ ШўЩ…Ш§ШЇЩ‡ Ш§ШіШЄ';

  @override
  String get tryAgain => 'ШЇЩ€ШЁШ§Ш±Щ‡ Ш§Щ…ШЄШ­Ш§Щ† Ъ©Щ†';

  @override
  String get uploadChooseFile => 'Ш§Щ†ШЄШ®Ш§ШЁ ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get uploadChooseFileShort => 'Ш§Щ†ШЄШ®Ш§ШЁ ЩЃШ§ЫЊЩ„';

  @override
  String get uploadContinueSetup => 'Ш§ШЇШ§Щ…Щ‡ ШЁЩ‡ ШЄЩ†ШёЫЊЩ…Ш§ШЄ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get uploadEnglishSource => 'Щ…Щ†ШЁШ№ Ш§Щ†ЪЇЩ„ЫЊШіЫЊ';

  @override
  String get uploadFailedFallback =>
      'Щ„Ш·ЩЃШ§Щ‹ ЫЊЪ© ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі ШЇЫЊЪЇШ± Ш±Ш§ Ш§Щ…ШЄШ­Ш§Щ† Ъ©Щ†.';

  @override
  String get uploadFailedMessage =>
      'Щ†ШЄЩ€Ш§Щ†ШіШЄЫЊЩ… Ш§ЫЊЩ† ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ ШЁШ®Щ€Ш§Щ†ЫЊЩ…. ЫЊЪ© ЩЃШ§ЫЊЩ„ ШЇЫЊЪЇШ± ЫЊШ§ Ш®Ш±Щ€Ш¬ЫЊ ШіШЁЪ©вЂЊШЄШ± Ш±Ш§ Ш§Щ…ШЄШ­Ш§Щ† Ъ©Щ†.';

  @override
  String get uploadFailedTitle =>
      'Щ€Ш§Ш±ШЇ Ъ©Ш±ШЇЩ† ЩЃШ§ЫЊЩ„ Щ†Ш§Щ…Щ€ЩЃЩ‚ ШЁЩ€ШЇ';

  @override
  String get uploadIntroSubtitle =>
      'ЫЊЪ© ЩЃШ§ЫЊЩ„ Ш§Щ†ЪЇЩ„ЫЊШіЫЊ `.srt` ЫЊШ§ `.vtt` Щ€Ш§Ш±ШЇ Ъ©Щ†ШЊ ШЁЪЇШ°Ш§Ш± ШЁЪ©вЂЊШ§Щ†ШЇ ШўЩ† Ш±Ш§ ШЁШ±Ш±ШіЫЊ Щ€ ЩѕШ±ШЇШ§ШІШґ Ъ©Щ†ШЇШЊ ШіЩѕШі Щ€Ш§Ш±ШЇ Щ…Ш±Ш­Щ„Щ‡ ШЄЩ†ШёЫЊЩ… ШЄШ±Ш¬Щ…Щ‡ ШґЩ€.';

  @override
  String get uploadIntroTitle =>
      'ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі Ш®Щ€ШЇШЄ Ш±Ш§ ШЁЫЊШ§Щ€Ш±';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount Ш®Ш·';
  }

  @override
  String get uploadMetadataTitle => 'Ш¬ШІШ¦ЫЊШ§ШЄ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get uploadOpeningPicker =>
      'ШЇШ± Ш­Ш§Щ„ ШЁШ§ШІ Ъ©Ш±ШЇЩ† Ш§Щ†ШЄШ®Ш§ШЁвЂЊЪЇШ± ЩЃШ§ЫЊЩ„...';

  @override
  String get uploadPickSubtitle =>
      'ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі Ш±Ш§ Ш§Щ†ШЄШ®Ш§ШЁ Ъ©Щ†';

  @override
  String get uploadPickedFile => 'ЩЃШ§ЫЊЩ„ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ШЄШ®Ш§ШЁ ШґШЇ';

  @override
  String get uploadReadyTitle => 'ШўЩ…Ш§ШЇЩ‡ ШЄШ±Ш¬Щ…Щ‡';

  @override
  String get uploadSubtitleTitle => 'ШўЩѕЩ„Щ€ШЇ ШІЫЊШ±Щ†Щ€ЫЊШі';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'ЩЃШ§ЫЊЩ„вЂЊЩ‡Ш§ЫЊ ШІЫЊШ±Щ†Щ€ЫЊШі Ш§Щ†ЪЇЩ„ЫЊШіЫЊ `.srt` Щ€ `.vtt`';

  @override
  String get uploadSupportedFormatsTitle =>
      'ЩЃШ±Щ…ШЄвЂЊЩ‡Ш§ЫЊ ЩѕШґШЄЫЊШЁШ§Щ†ЫЊвЂЊШґШЇЩ‡';

  @override
  String get uploadUseDemoFile => 'Ш§ШіШЄЩЃШ§ШЇЩ‡ Ш§ШІ ЩЃШ§ЫЊЩ„ Щ†Щ…Щ€Щ†Щ‡';
}
