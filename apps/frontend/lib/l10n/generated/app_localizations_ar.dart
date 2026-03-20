// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'الحساب';

  @override
  String get authAlreadySignedInTitle => 'أنت مسجل الدخول بالفعل';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'هذا الجهاز متصل بالفعل بالحساب $email.';
  }

  @override
  String get authBackToAccount => 'العودة إلى الحساب';

  @override
  String get authBackToSignIn => 'العودة إلى تسجيل الدخول';

  @override
  String get authCheckInboxTitle => 'تحقق من بريدك الوارد';

  @override
  String get authConfirmEmailAction => 'تأكيد البريد الإلكتروني';

  @override
  String authConfirmEmailHint(Object email) {
    return 'استخدم رمز التحقق المرسل إلى $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'ألصق رمز التحقق من بريدك الإلكتروني لإكمال تفعيل هذا الحساب.';

  @override
  String get authConfirmEmailSuccess =>
      'تم تأكيد البريد الإلكتروني. يمكنك الآن تسجيل الدخول.';

  @override
  String get authConfirmEmailTitle => 'تحقق من بريدك الإلكتروني';

  @override
  String get authConfirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get authContinueToReset => 'المتابعة لإعادة التعيين';

  @override
  String get authContinueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get authCreateAccountAction => 'إنشاء حساب';

  @override
  String authDebugTokenLabel(Object token) {
    return 'رمز التصحيح: $token';
  }

  @override
  String get authDisplayNameLabel => 'الاسم الظاهر';

  @override
  String get authEmailLabel => 'عنوان البريد الإلكتروني';

  @override
  String get authEyebrow => 'مساحة آمنة';

  @override
  String get authFieldRequired => 'هذا الحقل مطلوب.';

  @override
  String get authForgotPasswordAction => 'إرسال رابط إعادة التعيين';

  @override
  String get authForgotPasswordDebugMessage =>
      'تم إرجاع رمز إعادة تعيين لهذه البيئة التجريبية. يمكنك المتابعة مباشرة إلى نموذج إعادة التعيين.';

  @override
  String get authForgotPasswordLink => 'هل نسيت كلمة المرور؟';

  @override
  String get authForgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنطلب من الخادم إعادة تعيين كلمة المرور لهذا الحساب.';

  @override
  String get authForgotPasswordSuccess =>
      'إذا كان الحساب موجودًا، فقد تم إرسال رسالة لإعادة تعيين كلمة المرور.';

  @override
  String get authForgotPasswordTitle => 'أعد تعيين كلمة المرور';

  @override
  String get authGoogleHelper =>
      'يستخدم تسجيل الدخول عبر Google خدمة Firebase OAuth وسيعمل عندما يتم ربط هذا التطبيق بمشروع Firebase.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'لديك حساب بالفعل؟ سجّل الدخول';

  @override
  String get authInvalidEmail => 'أدخل عنوان بريد إلكتروني صالحًا.';

  @override
  String get authNewPasswordLabel => 'كلمة مرور جديدة';

  @override
  String get authNoAccountLink => 'تحتاج إلى حساب؟ أنشئ واحدًا';

  @override
  String get authOrDivider => 'أو';

  @override
  String get authPasswordLabel => 'كلمة المرور';

  @override
  String get authPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get authPasswordTooShort => 'استخدم 8 أحرف على الأقل.';

  @override
  String get authProfileRefreshed => 'تم تحديث بيانات الحساب.';

  @override
  String get authRefreshProfileAction => 'تحديث الملف الشخصي';

  @override
  String get authRefreshProfileSubtitle =>
      'تحميل أحدث بيانات الملف الشخصي من الخادم.';

  @override
  String get authResetPasswordAction => 'حفظ كلمة المرور الجديدة';

  @override
  String authResetPasswordHint(Object email) {
    return 'أعد تعيين كلمة مرور $email باستخدام الرمز المرسل إلى بريدك الإلكتروني.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'أدخل رمز إعادة التعيين واختر كلمة مرور جديدة لهذا الحساب.';

  @override
  String get authResetPasswordSuccess =>
      'تم تحديث كلمة المرور. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get authResetPasswordTitle => 'اختر كلمة مرور جديدة';

  @override
  String get authSignInAction => 'تسجيل الدخول';

  @override
  String get authSignInSubtitle =>
      'اربط هذا التطبيق بحساب SubFlix الخاص بك لمزامنة بيانات الملف الشخصي وفتح التدفقات الموثقة في الخادم.';

  @override
  String get authSignInSuccess => 'تم تسجيل الدخول بنجاح.';

  @override
  String get authSignInTitle => 'مرحبًا بعودتك';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'متصل باسم $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'سجّل الدخول لإدارة حسابك واستخدام Firebase OAuth وتجهيز الميزات الموثقة للمزامنة المستقبلية.';

  @override
  String get authSignedOutCardTitle => 'سجّل الدخول إلى SubFlix';

  @override
  String get authSignOutAction => 'تسجيل الخروج';

  @override
  String get authSignOutSubtitle =>
      'إلغاء الجلسة الحالية لهذا الجهاز ومسح الرموز المحلية.';

  @override
  String get authSignOutSuccess => 'تم تسجيل الخروج على هذا الجهاز.';

  @override
  String get authSignUpAction => 'إنشاء حسابي';

  @override
  String get authSignUpSubtitle =>
      'أنشئ حسابًا حتى يتمكن هذا التطبيق من استخدام الملف الشخصي الموثق وتدفقات الجلسة الخاصة بالخادم.';

  @override
  String get authSignUpSuccess =>
      'تم إنشاء الحساب. تابع تأكيد البريد الإلكتروني.';

  @override
  String get authSignUpTitle => 'أنشئ حسابك';

  @override
  String get authVerificationStatusTitle => 'التحقق من البريد الإلكتروني';

  @override
  String get authVerificationTokenLabel => 'رمز التحقق';

  @override
  String get authVerifiedStatus => 'تم التحقق';

  @override
  String get authUnverifiedStatus => 'التحقق قيد الانتظار';

  @override
  String get brandSubtitleCompact => 'Ш°ЩѓШ§ШЎ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get brandSubtitleFull =>
      'Ш§ШіШЄЩ€ШЇЩЉЩ€ ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ';

  @override
  String get comingSoonMessage =>
      'Щ…Ш§ ШІЩ„Щ†Ш§ Щ†Ш¬Щ‡Щ‘ШІ Щ‡Ш°Щ‡ Ш§Щ„ШґШ§ШґШ©.';

  @override
  String get comingSoonTitle => 'Щ‚Ш±ЩЉШЁЩ‹Ш§';

  @override
  String exportFailedSnack(Object error) {
    return 'ЩЃШґЩ„ Ш§Щ„ШЄШµШЇЩЉШ±: $error';
  }

  @override
  String get exportSubtitleLabel =>
      'ШЄШµШЇЩЉШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Щ…ШЄШ±Ш¬Щ…Ш©';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'ШЄЩ… ШЄШµШЇЩЉШ± $fileName ШҐЩ„Щ‰ $path';
  }

  @override
  String get exportingLabel => 'Ш¬Ш§Ш±ЩЌ Ш§Щ„ШЄШµШЇЩЉШ±...';

  @override
  String get heroBadge => 'Щ…ШіШ§Ш± ШЄШ±Ш¬Щ…Ш© Ш§Ш­ШЄШ±Ш§ЩЃЩЉ';

  @override
  String get heroBody =>
      'Ш§Ш®ШЄШ± ШЁЩЉЩ† ЩЃЩ‡Ш±Ші Ш№Щ†Ш§Щ€ЩЉЩ† Щ‚Ш§ШЁЩ„ Щ„Щ„ШЁШ­Ш« ШЈЩ€ Ш±ЩЃШ№ Щ…Щ„ЩЃ Щ…ШЁШ§ШґШ±ШЊ Ш«Щ… Ш№Ш§ЩЉЩ† Щ€ШµШЇЩ‘Ш± ШЄШ±Ш¬Щ…Ш§ШЄ Щ…ШµЩ‚Щ€Щ„Ш© Ш®Щ„Ш§Щ„ ШЇЩ‚Ш§Ш¦Щ‚.';

  @override
  String get heroHeadline =>
      'ШЄШ±Ш¬Щ… ШЄШ±Ш¬Щ…Ш§ШЄ Ш§Щ„ШЈЩЃЩ„Ш§Щ… Щ€Ш§Щ„Щ…ШіЩ„ШіЩ„Ш§ШЄ ШЁЩ…ШіШ§Ш± Ш№Щ…Щ„ ШЁЩ…ШіШЄЩ€Щ‰ Ш§Щ„Ш§ШіШЄЩ€ШЇЩЉЩ€.';

  @override
  String get heroSearchCta => 'Ш§ШЁШ­Ш« Ш№Щ† ЩЃЩЉЩ„Щ… / Щ…ШіЩ„ШіЩ„';

  @override
  String get heroStatLanguagesTitle => '10 Щ„ШєШ§ШЄ';

  @override
  String get heroStatLanguagesValue => 'Ш¬Ш§Щ‡ШІШ© Щ„Щ„Щ…Ш№Ш§ЩЉЩ†Ш©';

  @override
  String get heroStatMockTitle => 'Щ€Ш§Ш¬Щ‡Ш§ШЄ Щ€Щ‡Щ…ЩЉШ©';

  @override
  String get heroStatMockValue => 'Щ†Щ‚Ш·Ш© Ш¬Ш§Щ‡ШІШ© Щ„Щ„Ш®Ш§ШЇЩ…';

  @override
  String get heroStatPathsTitle => 'Щ…ШіШ§Ш±Ш§Щ†';

  @override
  String get heroStatPathsValue => 'ШЁШ­Ш« ШЈЩ€ Ш±ЩЃШ№';

  @override
  String get heroSubtitle =>
      'Ш§ШЁШ­Ш« ЩЃЩЉ ЩЃЩ‡Ш§Ш±Ші Ш§Щ„ШЈЩЃЩ„Ш§Щ… Щ€Ш§Щ„Щ…ШіЩ„ШіЩ„Ш§ШЄШЊ Щ€Ш§Ш®ШЄШ± Ш§Щ„Щ…ШµШ§ШЇШ±ШЊ Щ€ШµШЇЩ‘Ш± ШЄШ±Ш¬Щ…Ш§ШЄ Щ…ШµЩ‚Щ€Щ„Ш© Ш®Щ„Ш§Щ„ ШЇЩ‚Ш§Ш¦Щ‚.';

  @override
  String get heroTitle => 'ШЄШ±Ш¬Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш§ШЄ ШЁШіШ±Ш№Ш© ШЈЩѓШЁШ±';

  @override
  String get heroUploadCta => 'Ш±ЩЃШ№ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String historyCountLabel(Object count) {
    return '$count ШЄШ±Ш¬Щ…Ш©';
  }

  @override
  String get historyEmptyMessage =>
      'ШіШЄШёЩ‡Ш± Щ…Щ‡Ш§Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Щ…Щ†Ш¬ШІШ© Щ‡Щ†Ш§ ШЁШ№ШЇ ШҐЩѓЩ…Ш§Щ„ Щ…ШіШ§Ш± Ш§Щ„ШЁШ­Ш« ШЈЩ€ Ш§Щ„Ш±ЩЃШ№.';

  @override
  String get historyEmptyTitle => 'Ш§Щ„ШіШ¬Щ„ ЩЃШ§Ш±Шє';

  @override
  String get historyFailedItemMessage =>
      'ЩЃШґЩ„ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш©. Ш§Ш¶ШєШ· Щ„Щ„ШЁШЇШЎ Щ…Щ† Ш¬ШЇЩЉШЇ.';

  @override
  String get historyFailedTitle => 'ШЄШ№Ш°Щ‘Ш± ШЄШ­Щ…ЩЉЩ„ Ш§Щ„ШіШ¬Щ„';

  @override
  String get historyFilterAiTranslated =>
      'Щ…ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ';

  @override
  String get historyFilterAll => 'Ш§Щ„ЩѓЩ„';

  @override
  String get historyFilterCompleted => 'Щ…ЩѓШЄЩ…Щ„Ш©';

  @override
  String get historyFilterFailed => 'ЩЃШ§ШґЩ„Ш©';

  @override
  String get historyFilterMovies => 'Ш§Щ„ШЈЩЃЩ„Ш§Щ…';

  @override
  String get historyFilterReused => 'Щ…Ш№Ш§ШЇ Ш§ШіШЄШ®ШЇШ§Щ…Щ‡Ш§';

  @override
  String get historyFilterSeries => 'Ш§Щ„Щ…ШіЩ„ШіЩ„Ш§ШЄ';

  @override
  String get historySubtitle =>
      'ШЈШ№ШЇ ЩЃШЄШ­ Щ…Щ‡Ш§Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШіШ§ШЁЩ‚Ш©ШЊ Щ€Ш±Ш§Ш¬Ш№ Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш© Щ…Ш¬ШЇШЇЩ‹Ш§ШЊ ШЈЩ€ ШµШЇЩ‘Ш±Щ‡Ш§ Щ„Ш§Ш­Щ‚Щ‹Ш§.';

  @override
  String get historyTitle => 'ШіШ¬Щ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш§ШЄ';

  @override
  String get homeFailedRecentTitle =>
      'ШЄШ№Ш°Щ‘Ш± ШЄШ­Щ…ЩЉЩ„ Ш§Щ„Щ…Щ‡Ш§Щ… Ш§Щ„ШЈШ®ЩЉШ±Ш©';

  @override
  String get homeFutureSubtitle =>
      'ШЄЩЏШЁЩ‚ЩЉ Ш§Щ„Щ…ШіШЄЩ€ШЇШ№Ш§ШЄ Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉШ© Ш§Щ„Щ‚Ш§ШЁЩ„Ш© Щ„Щ„Ш§ШіШЄШЁШЇШ§Щ„ Щ€Ш§Ш¬Щ‡Ш© Ш§Щ„Щ…ШіШЄШ®ШЇЩ… Щ…Ш№ШІЩ€Щ„Ш© Ш№Щ† ШЄШєЩЉЩЉШ±Ш§ШЄ Ш§Щ„Ш®Ш§ШЇЩ….';

  @override
  String get homeFutureTitle => 'Щ…ШіШЄЩ€ШЇШ№Ш§ШЄ Ш¬Ш§Щ‡ШІШ© Щ„Щ„Щ…ШіШЄЩ‚ШЁЩ„';

  @override
  String get homeNoRecentMessage =>
      'Ш§ШЁШЇШЈ ШЁШ§Щ„ШЁШ­Ш« Ш№Щ† ЩЃЩЉЩ„Щ… ШЈЩ€ Ш§Ш±ЩЃШ№ Щ…Щ„ЩЃ ШЄШ±Ш¬Щ…Ш©ШЊ Щ€ШіШЄШёЩ‡Ш± ШЄШ±Ш¬Щ…Ш§ШЄЩѓ Ш§Щ„ШЈШ®ЩЉШ±Ш© Щ‡Щ†Ш§.';

  @override
  String get homeNoRecentTitle => 'Щ„Ш§ ШЄЩ€Ш¬ШЇ Щ…Щ‡Ш§Щ… Ш­ШЇЩЉШ«Ш© ШЁШ№ШЇ';

  @override
  String get homePreviewSubtitle =>
      'Ш±Ш§Ш¬Ш№ Ш§Щ„Щ†ШЄШ§Ш¦Ш¬ Щ‚ШЁЩ„ Ш§Щ„ШЄШµШЇЩЉШ± Ш№ШЁШ± Ш§Щ„Ш№Ш±Ш¶ Ш§Щ„ШЈШµЩ„ЩЉ ШЈЩ€ Ш§Щ„Щ…ШЄШ±Ш¬Щ… ШЈЩ€ Ш§Щ„Ш«Щ†Ш§Ш¦ЩЉ Ш§Щ„Щ„ШєШ©.';

  @override
  String get homePreviewTitle =>
      'Щ…ШіШ§Ш± ШЄШ±Ш¬Щ…Ш© Щ‚Ш§Ш¦Щ… Ш№Щ„Щ‰ Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш© ШЈЩ€Щ„Щ‹Ш§';

  @override
  String get homeQuickHistory => 'Ш§Щ„ШіШ¬Щ„';

  @override
  String get homeQuickSearch => 'ШЁШ­Ш«';

  @override
  String get homeQuickUpload => 'Ш±ЩЃШ№';

  @override
  String get homeRecentJobsSubtitle =>
      'ШЈШ№ШЇ ЩЃШЄШ­ ШЈШ­ШЇШ« Ш¬Щ„ШіШ§ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ„ШЇЩЉЩѓ ШЇЩ€Щ† Ш§Щ„ШЁШЇШЎ Щ…Щ† Ш§Щ„ШµЩЃШ±.';

  @override
  String get homeRecentJobsTitle => 'Ш§Щ„Щ…Щ‡Ш§Щ… Ш§Щ„ШЈШ®ЩЉШ±Ш©';

  @override
  String get homeSearchPlaceholder =>
      'Ш§ШЁШ­Ш« Ш№Щ† ШЈЩЃЩ„Ш§Щ… ШЈЩ€ Щ…ШіЩ„ШіЩ„Ш§ШЄ...';

  @override
  String get homeStatesSubtitle =>
      'Ш§Щ„ШЄШ­Щ…ЩЉЩ„ШЊ Щ€Ш§Щ„ЩЃШ±Ш§ШєШЊ Щ€ШҐШ№Ш§ШЇШ© Ш§Щ„Щ…Ш­Ш§Щ€Щ„Ш©ШЊ Щ€Ш§Щ„ШЄШ­Щ‚Щ‚ШЊ Щ€ШіЩЉЩ†Ш§Ш±ЩЉЩ€Щ‡Ш§ШЄ Ш№ШЇЩ… Ш§Щ„Ш§ШЄШµШ§Щ„ Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉШ© Ш¬ШІШЎ Щ…Щ† ШЄШ¬Ш±ШЁШ© Ш§Щ„Ш§ШіШЄШ®ШЇШ§Щ… Щ…Щ†Ш° Ш§Щ„ЩЉЩ€Щ… Ш§Щ„ШЈЩ€Щ„.';

  @override
  String get homeStatesTitle =>
      'Ш­Ш§Щ„Ш§ШЄ Ш§ШіШЄШ®ШЇШ§Щ… ШіЩ„ШіШ© Щ…Ш¶Щ…Щ‘Щ†Ш©';

  @override
  String get homeTrendingNow => 'Ш§Щ„Ш±Ш§Ш¦Ш¬ Ш§Щ„ШўЩ†';

  @override
  String get homeTrustSubtitle =>
      'Щ…ЩЏШ­Ш§ЩѓЩ‰ Ш§Щ„ЩЉЩ€Щ…ШЊ Щ„ЩѓЩ†Щ‡ Щ…ШЁЩ†ЩЉ ЩѓЩ…Щ†ШЄШ¬ Щ‚Ш§ШЁЩ„ Щ„Щ„ШҐШ·Щ„Ш§Щ‚ ЩЃШ№Щ„ЩЉЩ‹Ш§.';

  @override
  String get homeTrustTitle => 'Щ„Щ…Ш§Ш°Ш§ ШЄШ«Щ‚ ШЁЩ‡ Ш§Щ„ЩЃШ±Щ‚';

  @override
  String get homeViewAll => 'Ш№Ш±Ш¶ Ш§Щ„ЩѓЩ„';

  @override
  String get homeWelcomeSubtitle =>
      'Ш§Ш№Ш«Ш± Ш№Щ„Щ‰ Ш§Щ„ШЄШ±Ш¬Щ…Ш§ШЄ Щ€ШЄШ±Ш¬Щ…Щ‡Ш§';

  @override
  String get homeWelcomeTitle => 'Щ…Ш±Ш­ШЁЩ‹Ш§ ШЁШ№Щ€ШЇШЄЩѓ';

  @override
  String jobConfidence(Object level) {
    return 'Ш§Щ„Ш«Щ‚Ш©: $level';
  }

  @override
  String get jobOpenPreview => 'ЩЃШЄШ­ Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш©';

  @override
  String get jobReuseSubtitle =>
      'ШҐШ№Ш§ШЇШ© Ш§ШіШЄШ®ШЇШ§Щ… Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get jobReuseTranslation => 'ШҐШ№Ш§ШЇШ© Ш§ШіШЄШ®ШЇШ§Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get legalBodyAbout =>
      'SubFlix Ш№Щ…ЩЉЩ„ Flutter ШЁШ·Ш§ШЁШ№ Ш§Ш­ШЄШ±Ш§ЩЃЩЉ Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ. ШЄШіШЄШ®ШЇЩ… Щ‡Ш°Щ‡ Ш§Щ„Щ†ШіШ®Ш© Щ…ШіШЄЩ€ШЇШ№Ш§ШЄ Щ€Щ‡Щ…ЩЉШ©ШЊ Щ€ШЄШЈШ®ЩЉШ±Щ‹Ш§ Ш§ШµШ·Щ†Ш§Ш№ЩЉЩ‹Ш§ШЊ Щ€ШЄШ®ШІЩЉЩ†Щ‹Ш§ Щ…Ш­Щ„ЩЉЩ‹Ш§ Ш­ШЄЩ‰ ШЄШЄШ·Щ€Ш± Ш§Щ„Щ€Ш§Ш¬Щ‡Ш© Щ€Ш§Щ„ШЁЩ†ЩЉШ© Щ‚ШЁЩ„ Ш±ШЁШ· Ш®Ш§ШЇЩ… Ш­Щ‚ЩЉЩ‚ЩЉ.';

  @override
  String get legalBodyPrivacy =>
      'ЩЉШ®ШІЩ† SubFlix Ш­Ш§Щ„ЩЉЩ‹Ш§ Ш§Щ„ШЄЩЃШ¶ЩЉЩ„Ш§ШЄ Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉШ© Щ€ШіШ¬Щ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш© ЩЃЩ‚Ш· Ш№Щ„Щ‰ Ш§Щ„Ш¬Щ‡Ш§ШІ Ш№ШЁШ± Ш§Щ„ШЄШ®ШІЩЉЩ† Ш§Щ„Щ…Ш­Щ„ЩЉ. ЩЉЩ…ЩѓЩ† ШЈЩ† ЩЉШіШЄШЁШЇЩ„ ШЄЩѓШ§Щ…Щ„ Ш®Ш§ШЇЩ… Щ…ШіШЄЩ‚ШЁЩ„ЩЉ Ш°Щ„Щѓ ШЁШЄШ®ШІЩЉЩ† Щ…Щ€Ш«Щ‘Щ‚ШЊ Щ€Щ…ШіШ§Ш±Ш§ШЄ ШЄШЇЩ‚ЩЉЩ‚ШЊ Щ€ШіЩЉШ§ШіШ§ШЄ Ш§Ш­ШЄЩЃШ§Шё ШЄЩЏШЇШ§Ш± Щ…Щ† Ш§Щ„Ш®Ш§ШЇЩ….';

  @override
  String get legalBodySupport =>
      'Ш§Щ„ШЇШ№Щ… Щ…Ш¬Ш±ШЇ Ш№Щ†ШµШ± Щ†Ш§Ш¦ШЁ Ш­Ш§Щ„ЩЉЩ‹Ш§. ЩЃЩЉ ШҐШµШЇШ§Ш± Ш§Щ„ШҐЩ†ШЄШ§Ш¬ ЩЉЩ…ЩѓЩ† Щ„Щ‡Ш°Ш§ Ш§Щ„Щ‚ШіЩ… ШЈЩ† ЩЉШЄШµЩ„ ШЁШ§Щ„ШЁШ±ЩЉШЇ Ш§Щ„ШҐЩ„ЩѓШЄШ±Щ€Щ†ЩЉШЊ Щ€ШЄЩ‚Ш§Ш±ЩЉШ± Ш§Щ„Щ…ШґЩѓЩ„Ш§ШЄШЊ Щ€Щ…ШіШ§Ш№ШЇШ© Ш§Щ„Ш­ШіШ§ШЁШ§ШЄ Ш§Щ„Щ…Щ…ЩЉШІШ© Щ…Ш№ ШЁЩ‚Ш§ШЎ Щ‡ЩЉЩѓЩ„ Ш§Щ„ШЄШ·ШЁЩЉЩ‚ ЩѓЩ…Ш§ Щ‡Щ€.';

  @override
  String get legalBodyTerms =>
      'ШЄЩ‡ШЇЩЃ Щ‡Ш°Щ‡ Ш§Щ„Щ†ШіШ®Ш© Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉШ© ШҐЩ„Щ‰ Ш§Ш®ШЄШЁШ§Ш± ШЄШЇЩЃЩ‚Ш§ШЄ Ш§Щ„Щ…Щ†ШЄШ¬ШЊ Щ€Ш­Ш§Щ„Ш§ШЄ Ш§Щ„Щ€Ш§Ш¬Щ‡Ш©ШЊ Щ€Ш­ШЇЩ€ШЇ Ш§Щ„ШЁЩ†ЩЉШ©. Щ€Ш№Щ†ШЇЩ…Ш§ ЩЉШЄЩ… Ш±ШЁШ· Ш®Ш§ШЇЩ… ШҐЩ†ШЄШ§Ш¬ЩЉ ЩЉШ№ШЄЩ…ШЇ Ш№Щ„Щ‰ NestJS Щ€Postgres Щ„Ш§Ш­Щ‚Щ‹Ш§ШЊ ЩЉЩ…ЩѓЩ† ШЄЩ€ШіЩЉШ№ Ш§Щ„ШіШ·Ш­ Ш§Щ„Щ‚Ш§Щ†Щ€Щ†ЩЉ ШЁШґШ±Щ€Ш· Ш®ШЇЩ…Ш© Ш­Щ‚ЩЉЩ‚ЩЉШ© Щ€ШµЩЉШ§ШєШ§ШЄ Щ„Щ…Ш№Ш§Щ„Ш¬Ш© Ш§Щ„ШЁЩЉШ§Щ†Ш§ШЄ.';

  @override
  String get legalPlaceholderBody =>
      'Щ‡Ш°Щ‡ Ш§Щ„ШµЩЃШ­Ш© Щ…Ш¬Ш±ШЇ Ш№Щ†ШµШ± Щ†Ш§Ш¦ШЁ ЩЃЩЉ Ш§Щ„ШЄШ·ШЁЩЉЩ‚ Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉ. Ш§Ш±ШЁШ·Щ‡Ш§ ШЁЩ…Ш­ШЄЩ€Ш§Щѓ Ш§Щ„Щ‚Ш§Щ†Щ€Щ†ЩЉ Ш§Щ„Ш­Щ‚ЩЉЩ‚ЩЉ ЩЃЩЉ Щ†ШіШ®Ш© Ш§Щ„ШҐЩ†ШЄШ§Ш¬.';

  @override
  String get legalTitleAbout => 'Ш­Щ€Щ„ SubFlix';

  @override
  String get legalTitlePrivacy => 'ШіЩЉШ§ШіШ© Ш§Щ„Ш®ШµЩ€ШµЩЉШ©';

  @override
  String get legalTitleSupport => 'Ш§Щ„ШЇШ№Щ…';

  @override
  String get legalTitleTerms => 'ШґШ±Щ€Ш· Ш§Щ„Ш®ШЇЩ…Ш©';

  @override
  String get mediaTypeMovie => 'ЩЃЩЉЩ„Щ…';

  @override
  String get mediaTypeSeries => 'Щ…ШіЩ„ШіЩ„';

  @override
  String get metadataEstimatedDuration => 'Ш§Щ„Щ…ШЇШ© Ш§Щ„ШЄЩ‚ШЇЩЉШ±ЩЉШ©';

  @override
  String get metadataFormat => 'Ш§Щ„ШµЩЉШєШ©';

  @override
  String get metadataLanguages => 'Ш§Щ„Щ„ШєШ§ШЄ';

  @override
  String get metadataLines => 'Ш§Щ„ШЈШіШ·Ш±';

  @override
  String get navHistory => 'Ш§Щ„ШіШ¬Щ„';

  @override
  String get navHome => 'Ш§Щ„Ш±Ш¦ЩЉШіЩЉШ©';

  @override
  String get navSettings => 'Ш§Щ„ШҐШ№ШЇШ§ШЇШ§ШЄ';

  @override
  String get noTitlesMatchedMessage =>
      'Щ„Щ… Щ†ШЄЩ…ЩѓЩ† Щ…Щ† Ш§Щ„Ш№Ш«Щ€Ш± Ш№Щ„Щ‰ Щ‡Ш°Ш§ Ш§Щ„Ш№Щ†Щ€Ш§Щ† ЩЃЩЉ Ш§Щ„ЩЃЩ‡Ш±Ші Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉ. Ш¬Ш±Щ‘ШЁ ШЁШ­Ш«Щ‹Ш§ ШЈЩ€ШіШ№ ШЈЩ€ ШЈШ­ШЇ Ш§Щ„Ш№Щ†Ш§Щ€ЩЉЩ† Ш§Щ„Щ…Щ‚ШЄШ±Ш­Ш©.';

  @override
  String get noTitlesMatchedTitle => 'Щ„Ш§ ШЄЩ€Ш¬ШЇ Щ†ШЄШ§Ш¦Ш¬ Щ…Ш·Ш§ШЁЩ‚Ш©';

  @override
  String get onboardingContinue => 'Щ…ШЄШ§ШЁШ№Ш©';

  @override
  String get onboardingEnterApp => 'Ш§ШЇШ®Щ„ ШҐЩ„Щ‰ SubFlix';

  @override
  String get onboardingNext => 'Ш§Щ„ШЄШ§Щ„ЩЉ';

  @override
  String get onboardingPage1Description =>
      'Ш§ШЁШ­Ш« Ш№Щ† Ш№Щ†Щ€Ш§Щ†ШЊ Щ€Ш±Ш§Ш¬Ш№ Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШҐЩ†Ш¬Щ„ЩЉШІЩЉШ© Ш§Щ„Щ…ШЄШ§Ш­Ш©ШЊ Щ€Ш§ШЁШЇШЈ Щ…ШіШ§Ш± ШЄШ±Ш¬Щ…Ш© ЩЉШЁШЇЩ€ ЩЃЩ€Ш±ЩЉЩ‹Ш§.';

  @override
  String get onboardingPage1Eyebrow => 'Ш§ШЁШ­Ш« Щ€Ш§Ш¬Щ„ШЁ';

  @override
  String get onboardingPage1Highlight1 =>
      'ЩЃЩ‡Ш±Ші ШЄШ¬Ш±ЩЉШЁЩЉ Ш­ШЄЩ…ЩЉ Щ„ШЄШ·Щ€ЩЉШ± Щ…Щ€Ш«Щ€Щ‚';

  @override
  String get onboardingPage1Highlight2 =>
      'ШЁШ·Ш§Щ‚Ш§ШЄ Ш¬Щ€ШЇШ© Ш§Щ„Щ…ШµШЇШ± Щ€ШґШ§Ш±Ш§ШЄ Ш§Щ„ШµЩЉШєШ©';

  @override
  String get onboardingPage1Highlight3 =>
      'Щ…ШµЩ…Щ… Щ„ЩЉШіШЄШЁШЇЩ„ ШЁШ®Ш§ШЇЩ… Ш­Щ‚ЩЉЩ‚ЩЉ Щ„Ш§Ш­Щ‚Щ‹Ш§';

  @override
  String get onboardingPage1Title =>
      'Ш§Ш№Ш«Ш± Ш№Щ„Щ‰ ШЈЩЃЩ„Ш§Щ… ШЈЩ€ Щ…ШіЩ„ШіЩ„Ш§ШЄ Щ€Ш§ШіШ­ШЁ ШЄШ±Ш¬Щ…Ш§ШЄ Ш¬Ш§Щ‡ШІШ© Щ„Щ„ШЄШ±Ш¬Щ…Ш©.';

  @override
  String get onboardingPage2Description =>
      'Ш§ШіШЄЩ€Ш±ШЇ Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш©ШЊ Щ€ШЄШ­Щ‚Щ‚ Щ…Щ† Ш§Щ„ШµЩЉШєШ©ШЊ Щ€ШґШєЩ‘Щ„ Щ…ШіШ§Ш± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Щ…ШµЩ‚Щ€Щ„ Щ†ЩЃШіЩ‡ ШЇЩ€Щ† Щ…ШєШ§ШЇШ±Ш© Ш§Щ„ШЄШ·ШЁЩЉЩ‚.';

  @override
  String get onboardingPage2Eyebrow => 'Ш§ШіШЄШ®ШЇЩ… Щ…Щ„ЩЃЩѓ Ш§Щ„Ш®Ш§Шµ';

  @override
  String get onboardingPage2Highlight1 =>
      'ШЄШ­Щ‚Щ‚ Щ…Ш­Щ„ЩЉ Щ…Щ† Ш§Щ„Щ…Щ„ЩЃШ§ШЄ Щ…Ш№ Ш­Ш§Щ„Ш§ШЄ ШҐШ№Ш§ШЇШ© Щ…Ш­Ш§Щ€Щ„Ш© ШіЩ„ШіШ©';

  @override
  String get onboardingPage2Highlight2 =>
      'ШҐШ№ШЇШ§ШЇ ШЄШ±Ш¬Щ…Ш© Щ…ШЄШіЩ‚ ШЁЩЉЩ† Ш§Щ„Ш±ЩЃШ№ Щ€Ш§Щ„ШЁШ­Ш«';

  @override
  String get onboardingPage2Highlight3 =>
      'Ш№Ш§ЩЉЩ† Щ‚ШЁЩ„ Ш§Щ„ШЄШµШЇЩЉШ± Ш­ШЄЩ‰ Щ„Ш§ ЩЉШЁШЇЩ€ ШґЩЉШЎ ШєШ§Щ…Ш¶Щ‹Ш§';

  @override
  String get onboardingPage2Title =>
      'Ш§Ш±ЩЃШ№ Щ…Щ„ЩЃШ§ШЄ `.srt` ШЈЩ€ `.vtt` Ш№Щ†ШЇЩ…Ш§ ШЄЩѓЩ€Щ† Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ„ШЇЩЉЩѓ ШЁШ§Щ„ЩЃШ№Щ„.';

  @override
  String get onboardingPage3Description =>
      'ШЁШЇЩ‘Щ„ ШЁЩЉЩ† Ш§Щ„Ш№Ш±Ш¶ Ш§Щ„ШЈШµЩ„ЩЉ Щ€Ш§Щ„Щ…ШЄШ±Ш¬Щ… Щ€Ш§Щ„Ш«Щ†Ш§Ш¦ЩЉ Ш§Щ„Щ„ШєШ©ШЊ Щ€Ш§Ш±Ш¬Ш№ ШҐЩ„Щ‰ Ш§Щ„ШіШ¬Щ„ШЊ Щ€ШµШЇЩ‘Ш± Щ…Щ„ЩЃШ§ШЄ ШЄШ±Ш¬Щ…Ш© Щ†ШёЩЉЩЃШ© Ш№Щ†ШЇЩ…Ш§ ШЄШЁШЇЩ€ Ш§Щ„Щ†ШЄЩЉШ¬Ш© ШµШ­ЩЉШ­Ш©.';

  @override
  String get onboardingPage3Eyebrow => 'ШЄШ±Ш¬Щ… Щ€ШµШЇЩ‘Ш±';

  @override
  String get onboardingPage3Highlight1 =>
      'Ш№Щ†Ш§ШµШ± Щ…Ш№Ш§ЩЉЩ†Ш© ШіШ±ЩЉШ№Ш© Щ…Ш№ Ш§Щ„ШЁЩЉШ§Щ†Ш§ШЄ Ш§Щ„Щ€ШµЩЃЩЉШ© Щ€Ш§Щ„ШЁШ­Ш«';

  @override
  String get onboardingPage3Highlight2 =>
      'ЩЉШЁЩ‚ЩЉ Ш§Щ„ШіШ¬Щ„ Ш§Щ„Щ…Щ‡Ш§Щ… Ш§Щ„ШіШ§ШЁЩ‚Ш© Ш№Щ„Щ‰ ШЁЩЏШ№ШЇ Щ„Щ…ШіШ©';

  @override
  String get onboardingPage3Highlight3 =>
      'Щ…ШµЩ…Щ… ЩѓШЈШЇШ§Ш© Щ€ШіШ§Ш¦Ш· Ш§Ш­ШЄШ±Ш§ЩЃЩЉШ© Щ„Ш§ ЩѓШ№Ш±Ш¶ ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get onboardingPage3Title =>
      'Ш§Ш®ШЄШ± Ш§Щ„Щ„ШєШ§ШЄ Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ©ШЊ Щ€Ш№Ш§ЩЉЩ† Ш§Щ„ШЄШ±Ш¬Щ…Ш©ШЊ Щ€ШµШЇЩ‘Ш± ЩЃЩ€Ш±Щ‹Ш§.';

  @override
  String get onboardingSkip => 'ШЄШ®Ш·Щ‘ЩЋ';

  @override
  String get onboardingStart => 'Ш§ШЁШЇШЈ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get previewFailedTitle => 'ЩЃШґЩ„ ШЄШ­Щ…ЩЉЩ„ Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш©';

  @override
  String get previewModeBilingual => 'Ш«Щ†Ш§Ш¦ЩЉ Ш§Щ„Щ„ШєШ©';

  @override
  String get previewModeOriginal => 'Ш§Щ„ШЈШµЩ„';

  @override
  String get previewModeTranslated => 'Ш§Щ„Щ…ШЄШ±Ш¬Щ…';

  @override
  String get previewNoMatchesMessage =>
      'Ш¬Ш±Щ‘ШЁ ЩѓЩ„Щ…Ш© ШЁШ­Ш« Щ…Ш®ШЄЩ„ЩЃШ© ШЈЩ€ ШЈШІЩ„ Ш§Щ„ШЄШµЩЃЩЉШ© Щ„Щ…Ш±Ш§Ш¬Ш№Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ЩѓШ§Щ…Щ„Ш©.';

  @override
  String get previewNoMatchesTitle => 'Щ„Щ… ШЄШЄЩ… Щ…Ш·Ш§ШЁЩ‚Ш© ШЈЩЉ ШЈШіШ·Ш±';

  @override
  String get previewNotReadyMessage =>
      'Ш§ЩѓШЄЩ…Щ„ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш©ШЊ Щ„ЩѓЩ† Ш§Щ„Ш®Ш§ШЇЩ… Щ„Щ… ЩЉЩЏШ±Ш¬Ш№ ШЈШіШ·Ш± Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш© ШЁШ№ШЇ. Ш¬Ш±Щ‘ШЁ ШҐШ№Ш§ШЇШ© ШЄШ­Щ…ЩЉЩ„ Щ‡Ш°Щ‡ Ш§Щ„ШґШ§ШґШ© ШЁШ№ШЇ Щ„Ш­ШёШ©.';

  @override
  String get previewNotReadyTitle =>
      'ШЈШіШ·Ш± Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш© ШєЩЉШ± Щ…ШЄШ§Ш­Ш© ШЁШ№ШЇ';

  @override
  String get retry => 'ШҐШ№Ш§ШЇШ© Ш§Щ„Щ…Ш­Ш§Щ€Щ„Ш©';

  @override
  String get retryTranslation => 'ШҐШ№Ш§ШЇШ© Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Щ„Щ… Щ†ШЄЩ…ЩѓЩ† Щ…Щ† ШЄШ­ШЇЩЉШЇ Ш§Щ„Щ…Щ€ШіЩ… Ш§Щ„Щ…Ш·Щ„Щ€ШЁ ШЄШ­Щ…ЩЉЩ„Щ‡. Ш§ШЁШЇШЈ Щ…Ш¬ШЇШЇЩ‹Ш§ Щ…Щ† Ш§Щ„ШЁШ­Ш«.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Ш­Щ„Щ‚Ш§ШЄ Ш§Щ„Щ…Щ€ШіЩ…';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Щ„Щ… Щ†ШЄЩ…ЩѓЩ† Щ…Щ† ШЄШ­ШЇЩЉШЇ Ш§Щ„Щ…ШіЩ„ШіЩ„ Ш§Щ„Щ…Ш·Щ„Щ€ШЁ ШЄШ­Щ…ЩЉЩ„Щ‡. Ш§ШЁШЇШЈ Щ…Ш¬ШЇШЇЩ‹Ш§ Щ…Щ† Ш§Щ„ШЁШ­Ш«.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Щ…Щ€Ш§ШіЩ… Ш§Щ„Щ…ШіЩ„ШіЩ„';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Щ„Щ… Щ†ШЄЩ…ЩѓЩ† Щ…Щ† ШЄШ­ШЇЩЉШЇ Ш§Щ„Ш№Щ†Щ€Ш§Щ† Ш§Щ„Ш°ЩЉ ЩЉШ¬ШЁ ШЄШ­Щ…ЩЉЩ„ Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ„Щ‡. Ш§ШЁШЇШЈ Щ…Ш¬ШЇШЇЩ‹Ш§ Щ…Щ† Ш§Щ„ШЁШ­Ш«.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Щ„Щ… ЩЉШЄЩ… ШЄЩ€ЩЃЩЉШ± Ш·Щ„ШЁ ШЄШ±Ш¬Щ…Ш©. Ш§ШЁШЇШЈ ШЄШ±Ш¬Щ…Ш© Ш¬ШЇЩЉШЇШ© Щ…Щ† Ш§Щ„ШЁШ­Ш« ШЈЩ€ Ш§Щ„Ш±ЩЃШ№.';

  @override
  String get routeMissingTranslationProgressTitle =>
      'ШЄЩ‚ШЇЩ‘Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Щ…ШµШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ…Ш·Щ„Щ€ШЁ Щ‚ШЁЩ„ ЩЃШЄШ­ ШґШ§ШґШ© ШҐШ№ШЇШ§ШЇ Ш§Щ„ШЄШ±Ш¬Щ…Ш©.';

  @override
  String get routeMissingTranslationSetupTitle => 'ШҐШ№ШЇШ§ШЇ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get searchFailedTitle => 'ЩЃШґЩ„ Ш§Щ„ШЁШ­Ш«';

  @override
  String searchFoundResults(Object count, Object query) {
    return 'ШЄЩ… Ш§Щ„Ш№Ш«Щ€Ш± Ш№Щ„Щ‰ $count Щ†ШЄЩЉШ¬Ш© Щ„Ш№ШЁШ§Ш±Ш© \'\'$query\'\'';
  }

  @override
  String get searchHintText =>
      'Ш§ШЁШ­Ш« Ш№Щ† Dune ШЈЩ€ Breaking Bad ШЈЩ€ Severance...';

  @override
  String get searchLoadingLabel => 'Ш¬Ш§Ш±ЩЌ Ш§Щ„ШЁШ­Ш«...';

  @override
  String get searchMockMessage =>
      'Ш¬Ш±Щ‘ШЁ Ш№Щ†Ш§Щ€ЩЉЩ† Щ…Ш«Щ„ Inception ШЈЩ€ Dune ШЈЩ€ Breaking Bad ШЈЩ€ Severance ШЈЩ€ The Last of Us Щ„Ш§ШіШЄЩѓШґШ§ЩЃ Щ…ШіШ§Ш± Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш©.';

  @override
  String get searchMockTitle =>
      'Ш§ШЁШ­Ш« Ш№Щ† ШЈЩЉ ШґЩЉШЎ ЩЃЩЉ Ш§Щ„ЩЃЩ‡Ш±Ші Ш§Щ„ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Ш§Ш№Ш«Ш± Ш№Щ„Щ‰ Ш№Щ†Щ€Ш§Щ†ШЊ Щ€ШЄЩЃЩ‚Щ‘ШЇ Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш©ШЊ Щ€Ш§ШЁШЇШЈ Щ…Щ‡Щ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШЁШ¶Ш№ Щ„Щ…ШіШ§ШЄ.';

  @override
  String get searchMovieOrSeriesTitle =>
      'Ш§ШЁШ­Ш« Ш№Щ† ЩЃЩЉЩ„Щ… ШЈЩ€ Щ…ШіЩ„ШіЩ„';

  @override
  String searchNoResultsFor(Object query) {
    return 'Щ„Щ… ЩЉШЄЩ… Ш§Щ„Ш№Ш«Щ€Ш± Ш№Щ„Щ‰ Щ†ШЄШ§Ш¦Ш¬ Щ„Ш№ШЁШ§Ш±Ш© \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Ш§Щ„ШґШ№ШЁЩЉШ© $score';
  }

  @override
  String get searchTitles => 'Ш§Щ„ШЁШ­Ш« Ш№Щ† Ш§Щ„Ш№Щ†Ш§Щ€ЩЉЩ†';

  @override
  String get searchTrendingTitle => 'Ш№Щ…Щ„ЩЉШ§ШЄ Ш§Щ„ШЁШ­Ш« Ш§Щ„Ш±Ш§Ш¦Ш¬Ш©';

  @override
  String get searchTryDifferentKeywords =>
      'Ш¬Ш±Щ‘ШЁ Ш§Щ„ШЁШ­Ш« ШЁЩѓЩ„Щ…Ш§ШЄ Щ…Ш®ШЄЩ„ЩЃШ©.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Ш§Щ„Ш­Щ„Щ‚Ш© $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Ш­Щ€Ш§Щ„ЩЉ $runtime ШЇЩ‚ЩЉЩ‚Ш©';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount Ш­Щ„Щ‚Ш©$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Ш§Щ„Щ…Щ€ШіЩ… $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Ш§Щ„Щ…Щ€ШіЩ… $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount Ш­Щ„Щ‚Ш©$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Ш§Ш®ШЄШ± Щ…Щ€ШіЩ…Щ‹Ш§ Щ…Щ† $title Щ„ШЄШµЩЃЩ‘Ш­ Ш§Щ„Ш­Щ„Щ‚Ш§ШЄ Ш§Щ„Щ…ШЄШ§Ш­Ш©.';
  }

  @override
  String get seriesSeasonsTitle => 'Ш§Ш®ШЄШ± Щ…Щ€ШіЩ…Щ‹Ш§';

  @override
  String get settingsAboutTitle => 'Ш­Щ€Щ„ SubFlix';

  @override
  String get settingsCacheCleared =>
      'ШЄЩ… Щ…ШіШ­ Ш§Щ„Ш°Ш§ЩѓШ±Ш© Ш§Щ„Щ…Ш¤Щ‚ШЄШ©';

  @override
  String get settingsClearCache => 'Щ…ШіШ­ Ш§Щ„Ш°Ш§ЩѓШ±Ш© Ш§Щ„Щ…Ш¤Щ‚ШЄШ©';

  @override
  String get settingsContactTitle => 'ШЄЩ€Ш§ШµЩ„ Щ…Ш№Щ†Ш§';

  @override
  String get settingsFailedTitle => 'ЩЃШґЩ„ ШЄШ­Щ…ЩЉЩ„ Ш§Щ„ШҐШ№ШЇШ§ШЇШ§ШЄ';

  @override
  String get settingsHelpCenterTitle => 'Щ…Ш±ЩѓШІ Ш§Щ„Щ…ШіШ§Ш№ШЇШ©';

  @override
  String get settingsHistoryClearedSnack =>
      'ШЄЩ… Щ…ШіШ­ ШіШ¬Щ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ„Щ‡Ш°Ш§ Ш§Щ„Ш¬Щ‡Ш§ШІ';

  @override
  String get settingsLanguageLabel =>
      'Ш§Щ„Щ„ШєШ© Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ© Ш§Щ„Щ…ЩЃШ¶Щ„Ш©';

  @override
  String get settingsMaintenanceSubtitle =>
      'Ш§Щ…ШіШ­ Щ…Щ‡Ш§Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШЄШ§ШЁШ№Ш© Щ„Щ„Ш®Ш§ШЇЩ… Щ„Щ‡Ш°Ш§ Ш§Щ„Ш¬Щ‡Ш§ШІ Щ€Ш§ШЁШЇШЈ ШЁШіШ¬Щ„ ЩЃШ§Ш±Шє.';

  @override
  String get settingsMaintenanceTitle => 'Ш§Щ„ШµЩЉШ§Щ†Ш©';

  @override
  String get settingsNotificationsSubtitle =>
      'ШЈШЇШ± ШЄЩЃШ¶ЩЉЩ„Ш§ШЄ Ш§Щ„ШҐШґШ№Ш§Ш±Ш§ШЄ';

  @override
  String get settingsNotificationsTitle => 'Ш§Щ„ШҐШґШ№Ш§Ш±Ш§ШЄ';

  @override
  String get settingsPremiumSubtitle =>
      'Щ„Ш§Ш­Щ‚Щ‹Ш§ ЩЉЩ…ЩѓЩ†Щ†Ш§ Ш±ШЁШ· Ш§Щ„Ш§ШґШЄШ±Ш§ЩѓШ§ШЄ Щ€Ш§Щ„ЩЃЩ€ШЄШ±Ш© Щ€Щ…ШІШ§Щ…Щ†Ш© Ш§Щ„Щ…ШґШ§Ш±ЩЉШ№ Ш§Щ„ШіШ­Ш§ШЁЩЉШ© Щ‡Щ†Ш§.';

  @override
  String get settingsPremiumTitle => 'Ш№Щ†ШµШ± Щ…Щ…ЩЉШІ ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get settingsPrivacySubtitle => 'Щ…Ш­ШЄЩ€Щ‰ Ш®ШµЩ€ШµЩЉШ© ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get settingsPrivacyTitle => 'ШіЩЉШ§ШіШ© Ш§Щ„Ш®ШµЩ€ШµЩЉШ©';

  @override
  String get settingsProfileName => 'Щ…ШіШЄШ®ШЇЩ… SubFlix';

  @override
  String get settingsProfileTier => 'Ш№Ш¶Щ€ Щ…Щ…ЩЉШІ';

  @override
  String get settingsSubtitle => 'ШЈШЇШ± ШЄЩЃШ¶ЩЉЩ„Ш§ШЄЩѓ';

  @override
  String get settingsSupportSubtitle =>
      'ШµЩЃШ­Ш© Щ…ШіШ§Ш№ШЇШ© Щ€Ш§ШЄШµШ§Щ„ ШЄШ¬Ш±ЩЉШЁЩЉШ©';

  @override
  String get settingsSupportTitle => 'Щ‚ШіЩ… ШЇШ№Щ… ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get settingsTermsSubtitle => 'Щ…Ш­ШЄЩ€Щ‰ ШґШ±Щ€Ш· ШЄШ¬Ш±ЩЉШЁЩЉ';

  @override
  String get settingsTermsTitle => 'ШґШ±Щ€Ш· Ш§Щ„Ш®ШЇЩ…Ш©';

  @override
  String get settingsThemeLabel => 'Ш§Щ„Щ…ШёЩ‡Ш±';

  @override
  String get settingsTitle => 'Ш§Щ„ШҐШ№ШЇШ§ШЇШ§ШЄ';

  @override
  String settingsVersion(Object version) {
    return 'Ш§Щ„ШҐШµШЇШ§Ш± $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing =>
      'Ш¬Ш§Ш±ЩЌ ШЄШ¬Щ‡ЩЉШІ Ш§ШіШЄЩ€ШЇЩЉЩ€ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Ш®Ш§Шµ ШЁЩѓ';

  @override
  String get splashSubtitle =>
      'ШЄШ±Ш¬Щ…Ш© ШЄШ±Ш¬Щ…Ш© Щ…ШЇШ№Щ€Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ';

  @override
  String get startTranslation => 'ШЁШЇШЎ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads ШЄЩ†ШІЩЉЩ„Щ‹Ш§';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Щ…ШµШЇШ± ШЄШ±Ш¬Щ…Ш© $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount ШіШ·Ш±Щ‹Ш§';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'Ш§Щ„ШЄЩ‚ЩЉЩЉЩ… $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Ш§Ш®ШЄШ± Щ…ШµШЇШ± ШЄШ±Ш¬Щ…Ш© Щ€ШЄШ§ШЁШ№ ШҐЩ„Щ‰ ШҐШ№ШЇШ§ШЇ ШЄШ±Ш¬Щ…Ш© Щ…ШµЩ‚Щ€Щ„ Щ€Щ…Щ‡ЩЉШЈ Щ„ШЄЩ€Щ‚ЩЉШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш©.';

  @override
  String get subtitleSourcesBannerTitle =>
      'Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ Щ…ШЄШ§Ш­Ш©';

  @override
  String get subtitleSourcesFailedTitle =>
      'ШЄШ№Ш°Щ‘Ш± ШЄШ­Щ…ЩЉЩ„ Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Ш§Ш®ШЄШ± Щ…ШµШЇШ± ШЄШ±Ш¬Щ…Ш© Щ„ЩЂ $title$targetШЊ Ш«Щ… Ш§Ш®ШЄШ± Ш§Щ„Щ„ШєШ© Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ© ЩЃЩЉ Ш§Щ„Ш®Ш·Щ€Ш© Ш§Щ„ШЄШ§Щ„ЩЉШ©.';
  }

  @override
  String get subtitleSourcesTitle =>
      'Щ…ШµШ§ШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШҐЩ†Ш¬Щ„ЩЉШІЩЉШ©';

  @override
  String get targetLanguage => 'Ш§Щ„Щ„ШєШ© Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ©';

  @override
  String get themeDark => 'ШЇШ§ЩѓЩ†';

  @override
  String get themeLight => 'ЩЃШ§ШЄШ­';

  @override
  String get themeSystem => 'Ш§Щ„Щ†ШёШ§Щ…';

  @override
  String get translateSetupAutoDetect =>
      'Ш§ЩѓШЄШґШ§ЩЃ Ш§Щ„ШµЩЉШєШ© ШЄЩ„Щ‚Ш§Ш¦ЩЉЩ‹Ш§';

  @override
  String get translateSetupAutoDetectBody =>
      'Ш§Ш®ШЄШ± ШЁЩ†ЩЉШ© ШҐШ®Ш±Ш§Ш¬ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Щ…Щ†Ш§ШіШЁШ© ШЄЩ„Щ‚Ш§Ш¦ЩЉЩ‹Ш§.';

  @override
  String get translateSetupLanguageTitle => 'Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШҐЩ„Щ‰';

  @override
  String get translateSetupOptionsTitle => 'Ш§Щ„Ш®ЩЉШ§Ш±Ш§ШЄ';

  @override
  String get translateSetupPreserveTiming =>
      'Ш§Щ„Ш­ЩЃШ§Шё Ш№Щ„Щ‰ Ш§Щ„ШЄЩ€Щ‚ЩЉШЄ';

  @override
  String get translateSetupPreserveTimingBody =>
      'ШЈШЁЩ‚Щђ ШЄЩ€Щ‚ЩЉШЄШ§ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШЈШµЩ„ЩЉШ© Щ…ШЄШ·Ш§ШЁЩ‚Ш© Щ…Ш№ Ш§Щ„Щ…Щ„ЩЃ Ш§Щ„Щ…ШµШЇШ±.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'ШіЩЉШ­Щ€Щ‘Щ„ Щ…ШіШ§Ш± Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ„ШЇЩЉЩ†Ш§ Щ‡Ш°Щ‡ Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШҐЩ„Щ‰ $language Щ…Ш№ Ш§Щ„Ш­ЩЃШ§Шё Ш№Щ„Щ‰ Ш§Щ„ШЄЩ€Щ‚ЩЉШЄ Щ€ШЁЩ†ЩЉШ© Ш§Щ„ШЈШіШ·Ш± ШЁШґЩѓЩ„ Щ†ШёЩЉЩЃ.';
  }

  @override
  String get translateSetupReadyTitle =>
      'Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ Ш¬Ш§Щ‡ШІШ©';

  @override
  String get translateSetupSelectLanguage => 'Ш§Ш®ШЄШ± Ш§Щ„Щ„ШєШ©';

  @override
  String get translateSetupSourceTitle => 'Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Щ…ШµШЇШ±';

  @override
  String get translateSetupSubtitle =>
      'Ш§Ш®ШЄШ± Ш§Щ„Щ„ШєШ© Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ©ШЊ Щ€Ш±Ш§Ш¬Ш№ Щ…ШµШЇШ± Ш§Щ„ШЄШ±Ш¬Щ…Ш©ШЊ Ш«Щ… Ш§ШЁШЇШЈ Щ…Щ‡Щ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ЩЃЩЉ Ш§Щ„Ш®Ш§ШЇЩ….';

  @override
  String get translateSetupTitle => 'ШҐШ№ШЇШ§ШЇ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationFailedMessage => 'Ш­ШЇШ« Ш®Ш·ШЈ Щ…Ш§.';

  @override
  String get translationFailedTitle => 'ШЄШ№Ш°Щ‘Ш± ШҐЩѓЩ…Ш§Щ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationPreviewHeader =>
      'Ш±Ш§Ш¬Ш№ Ш§Щ„ШЄШ±Ш¬Щ…Ш§ШЄ Ш§Щ„Щ…ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationPreviewSearchHint =>
      'Ш§ШЁШ­Ш« ЩЃЩЉ ШЈШіШ·Ш± Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationPreviewSubtitle =>
      'Ш§ШЁШ­Ш« ШЇШ§Ш®Щ„ Ш§Щ„ШЈШіШ·Ш±ШЊ Щ€ШЁШЇЩ‘Щ„ ШЈЩ€Ш¶Ш§Ш№ Ш§Щ„Щ…Ш№Ш§ЩЉЩ†Ш©ШЊ Ш«Щ… ШµШЇЩ‘Ш± Ш§Щ„Щ…Щ„ЩЃ Ш№Щ†ШЇЩ…Ш§ ШЄШЁШЇЩ€ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ…Щ†Ш§ШіШЁШ©.';

  @override
  String get translationPreviewTitle => 'Щ…Ш№Ш§ЩЉЩ†Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationProgressHeadline =>
      'ШЄШ±Ш¬Щ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ Щ‚ЩЉШЇ Ш§Щ„ШЄЩ†ЩЃЩЉШ°';

  @override
  String get translationProgressTitle => 'ШЄЩ‚ШЇЩ‘Щ… Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationResultCompleteSubtitle =>
      'ШЈШµШЁШ­ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш¬Ш§Щ‡ШІШ© Щ„Щ„Щ…Ш№Ш§ЩЉЩ†Ш© ШЈЩ€ Ш§Щ„ШЄЩ†ШІЩЉЩ„.';

  @override
  String get translationResultCompleteTitle => 'Ш§ЩѓШЄЩ…Щ„ШЄ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationResultConfidenceLabel => 'Ш«Щ‚Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationResultDetailsTitle => 'ШЄЩЃШ§ШµЩЉЩ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationResultDownloadCta => 'ШЄЩ†ШІЩЉЩ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationResultHomeCta => 'Ш§Щ„Ш№Щ€ШЇШ© ШҐЩ„Щ‰ Ш§Щ„Ш±Ш¦ЩЉШіЩЉШ©';

  @override
  String get translationResultMediaLabel => 'Ш№Щ†Щ€Ш§Щ† Ш§Щ„Ш№Щ…Щ„';

  @override
  String get translationResultMethodAi =>
      'Щ…ШЄШ±Ш¬Щ…Ш© ШЁШ§Щ„Ш°ЩѓШ§ШЎ Ш§Щ„Ш§ШµШ·Щ†Ш§Ш№ЩЉ';

  @override
  String get translationResultMetricsTitle => 'Щ…Щ‚Ш§ЩЉЩЉШі Ш§Щ„Ш¬Щ€ШЇШ©';

  @override
  String get translationResultPreviewCta => 'Щ…Ш№Ш§ЩЉЩ†Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'ШЄЩ…ШЄ Ш§Щ„Щ…Ш№Ш§Щ„Ш¬Ш© Ш®Щ„Ш§Щ„ $duration';
  }

  @override
  String get translationResultSourceLabel => 'Щ„ШєШ© Ш§Щ„Щ…ШµШЇШ±';

  @override
  String get translationResultTargetLabel => 'Ш§Щ„Щ„ШєШ© Ш§Щ„Щ…ШіШЄЩ‡ШЇЩЃШ©';

  @override
  String get translationResultTimingLabel => 'ШЇЩ‚Ш© Ш§Щ„ШЄЩ€Щ‚ЩЉШЄ';

  @override
  String get translationResultTimingPreserved =>
      'ШЄЩ… Ш§Щ„Ш­ЩЃШ§Шё Ш№Щ„Щ‰ Ш§Щ„ШЄЩ€Щ‚ЩЉШЄ';

  @override
  String get translationResultWarning =>
      'Щ‚ШЇ ШЄШіШЄЩЃЩЉШЇ ШЁШ№Ш¶ Ш§Щ„Щ…ШµШ·Щ„Ш­Ш§ШЄ Ш§Щ„ШЄЩ‚Щ†ЩЉШ© Щ…Щ† Щ…Ш±Ш§Ш¬Ш№Ш© ШЁШґШ±ЩЉШ© ШіШ±ЩЉШ№Ш© Щ„ЩЃЩ‡Щ… Ш§Щ„ШіЩЉШ§Щ‚.';

  @override
  String get translationStageAligning =>
      'Ш¬Ш§Ш±ЩЌ Щ…Щ€Ш§ШЎЩ…Ш© Ш§Щ„Ш·Щ€Ш§ШЁШ№ Ш§Щ„ШІЩ…Щ†ЩЉШ© Щ€ШіЩЉШ§Щ‚ Ш§Щ„Щ…ШґЩ‡ШЇ';

  @override
  String get translationStageGenerating => 'Ш¬Ш§Ш±ЩЌ ШҐЩ†ШґШ§ШЎ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationStageIdle => 'ШЁШ§Щ†ШЄШёШ§Ш± Ш·Щ„ШЁ ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationStagePreparing =>
      'Ш¬Ш§Ш±ЩЌ ШЄШ¬Щ‡ЩЉШІ Ш­ШІЩ…Ш© Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationStageQueued =>
      'ЩЃЩЉ Ш§Щ†ШЄШёШ§Ш± Ш§Щ„ШЇЩ€Ш± Щ„Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get translationStageReadability =>
      'Ш¬Ш§Ш±ЩЌ ШЄШ­ШіЩЉЩ† Щ‚Ш§ШЁЩ„ЩЉШ© Ш§Щ„Щ‚Ш±Ш§ШЎШ©';

  @override
  String get translationStageReady => 'Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш¬Ш§Щ‡ШІШ©';

  @override
  String get tryAgain => 'Ш¬Ш±Щ‘ШЁ Щ…Ш±Ш© ШЈШ®Ш±Щ‰';

  @override
  String get uploadChooseFile => 'Ш§Ш®ШЄШ± Щ…Щ„ЩЃ ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadChooseFileShort => 'Ш§Ш®ШЄШ± Щ…Щ„ЩЃЩ‹Ш§';

  @override
  String get uploadContinueSetup =>
      'Щ…ШЄШ§ШЁШ№Ш© ШҐЩ„Щ‰ ШҐШ№ШЇШ§ШЇ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadEnglishSource => 'Ш§Щ„Щ…ШµШЇШ± Ш§Щ„ШҐЩ†Ш¬Щ„ЩЉШІЩЉ';

  @override
  String get uploadFailedFallback =>
      'ЩЉШ±Ш¬Щ‰ ШЄШ¬Ш±ШЁШ© Щ…Щ„ЩЃ ШЄШ±Ш¬Щ…Ш© ШўШ®Ш±.';

  @override
  String get uploadFailedMessage =>
      'ШЄШ№Ш°Щ‘Ш±ШЄ Щ‚Ш±Ш§ШЎШ© Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Щ‡Ш°Ш§. Ш¬Ш±Щ‘ШЁ Щ…Щ„ЩЃЩ‹Ш§ ШўШ®Ш± ШЈЩ€ Щ…Щ„ЩЃ ШЄШµШЇЩЉШ± ШЈШµШєШ±.';

  @override
  String get uploadFailedTitle => 'ЩЃШґЩ„ Ш§ШіШЄЩЉШ±Ш§ШЇ Ш§Щ„Щ…Щ„ЩЃ';

  @override
  String get uploadIntroSubtitle =>
      'Ш§ШіШЄЩ€Ш±ШЇ Щ…Щ„ЩЃ `.srt` ШЈЩ€ `.vtt` ШЁШ§Щ„Щ„ШєШ© Ш§Щ„ШҐЩ†Ш¬Щ„ЩЉШІЩЉШ©ШЊ Щ€ШЇШ№ Ш§Щ„Ш®Ш§ШЇЩ… ЩЉШЄШ­Щ‚Щ‚ Щ…Щ†Щ‡ Щ€ЩЉШ­Щ„Щ‘Щ„Щ‡ШЊ Ш«Щ… ШЄШ§ШЁШ№ ШҐЩ„Щ‰ ШҐШ№ШЇШ§ШЇ Ш§Щ„ШЄШ±Ш¬Щ…Ш©.';

  @override
  String get uploadIntroTitle =>
      'Ш§ШіШЄШ®ШЇЩ… Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш© Ш§Щ„Ш®Ш§Шµ ШЁЩѓ';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount ШіШ·Ш±Щ‹Ш§';
  }

  @override
  String get uploadMetadataTitle => 'ШЄЩЃШ§ШµЩЉЩ„ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadOpeningPicker =>
      'Ш¬Ш§Ш±ЩЌ ЩЃШЄШ­ ШЈШЇШ§Ш© Ш§Щ„Ш§Ш®ШЄЩЉШ§Ш±...';

  @override
  String get uploadPickSubtitle => 'Ш§Ш®ШЄШ± Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadPickedFile => 'ШЄЩ… Ш§Ш®ШЄЩЉШ§Ш± Щ…Щ„ЩЃ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadReadyTitle => 'Ш¬Ш§Щ‡ШІ Щ„Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadSubtitleTitle => 'Ш±ЩЃШ№ Ш§Щ„ШЄШ±Ш¬Щ…Ш©';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Щ…Щ„ЩЃШ§ШЄ ШЄШ±Ш¬Щ…Ш© ШҐЩ†Ш¬Щ„ЩЉШІЩЉШ© ШЁШµЩЉШєШ© `.srt` Щ€ `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Ш§Щ„ШµЩЉШє Ш§Щ„Щ…ШЇШ№Щ€Щ…Ш©';

  @override
  String get uploadUseDemoFile => 'Ш§ШіШЄШ®ШЇШ§Щ… Щ…Щ„ЩЃ ШЄШ¬Ш±ЩЉШЁЩЉ';
}
