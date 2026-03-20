// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => '账户';

  @override
  String get authAlreadySignedInTitle => '你已登录';

  @override
  String authAlreadySignedInMessage(Object email) {
    return '此设备已连接到 $email 账户。';
  }

  @override
  String get authBackToAccount => '返回账户';

  @override
  String get authBackToSignIn => '返回登录';

  @override
  String get authCheckInboxTitle => '请检查收件箱';

  @override
  String get authConfirmEmailAction => '确认邮箱';

  @override
  String authConfirmEmailHint(Object email) {
    return '请使用发送到 $email 的验证令牌。';
  }

  @override
  String get authConfirmEmailSubtitle => '粘贴邮件中的验证令牌，以完成此账户的激活。';

  @override
  String get authConfirmEmailSuccess => '邮箱已确认。现在可以登录了。';

  @override
  String get authConfirmEmailTitle => '验证你的邮箱';

  @override
  String get authConfirmPasswordLabel => '确认密码';

  @override
  String get authContinueToReset => '继续重置';

  @override
  String get authContinueWithGoogle => '使用 Google 继续';

  @override
  String get authCreateAccountAction => '创建账户';

  @override
  String authDebugTokenLabel(Object token) {
    return '调试令牌：$token';
  }

  @override
  String get authDisplayNameLabel => '显示名称';

  @override
  String get authEmailLabel => '邮箱地址';

  @override
  String get authEyebrow => '安全空间';

  @override
  String get authFieldRequired => '此字段为必填项。';

  @override
  String get authForgotPasswordAction => '发送重置链接';

  @override
  String get authForgotPasswordDebugMessage => '此调试环境已返回一个重置令牌。你可以直接继续到重置表单。';

  @override
  String get authForgotPasswordLink => '忘记密码？';

  @override
  String get authForgotPasswordSubtitle => '输入你的邮箱，我们将向后端请求为此账户重置密码。';

  @override
  String get authForgotPasswordSuccess => '如果账户存在，密码重置消息已发送。';

  @override
  String get authForgotPasswordTitle => '重置你的密码';

  @override
  String get authGoogleHelper =>
      'Google 登录使用 Firebase OAuth，当此应用连接到 Firebase 项目后即可正常使用。';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => '已有账户？去登录';

  @override
  String get authInvalidEmail => '请输入有效的邮箱地址。';

  @override
  String get authNewPasswordLabel => '新密码';

  @override
  String get authNoAccountLink => '需要账户？创建一个';

  @override
  String get authOrDivider => '或';

  @override
  String get authPasswordLabel => '密码';

  @override
  String get authPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get authPasswordTooShort => '请至少使用 8 个字符。';

  @override
  String get authProfileRefreshed => '账户数据已刷新。';

  @override
  String get authRefreshProfileAction => '刷新资料';

  @override
  String get authRefreshProfileSubtitle => '从后端加载最新的个人资料数据。';

  @override
  String get authResetPasswordAction => '保存新密码';

  @override
  String authResetPasswordHint(Object email) {
    return '使用邮件中的令牌重置 $email 的密码。';
  }

  @override
  String get authResetPasswordSubtitle => '输入重置令牌，并为此账户设置一个新密码。';

  @override
  String get authResetPasswordSuccess => '密码已更新。请重新登录。';

  @override
  String get authResetPasswordTitle => '选择新密码';

  @override
  String get authSignInAction => '登录';

  @override
  String get authSignInSubtitle => '将此应用连接到你的 SubFlix 账户，以同步个人资料并启用后端认证流程。';

  @override
  String get authSignInSuccess => '登录成功。';

  @override
  String get authSignInTitle => '欢迎回来';

  @override
  String authSignedInCardSubtitle(Object email) {
    return '已连接为 $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      '登录后即可管理账户、使用 Firebase OAuth，并为未来同步准备认证功能。';

  @override
  String get authSignedOutCardTitle => '登录到 SubFlix';

  @override
  String get authSignOutAction => '退出登录';

  @override
  String get authSignOutSubtitle => '撤销此设备上的当前会话并清除本地令牌。';

  @override
  String get authSignOutSuccess => '已在此设备上退出登录。';

  @override
  String get authSignUpAction => '创建我的账户';

  @override
  String get authSignUpSubtitle => '创建一个账户，以便此应用可以使用后端的已认证资料和会话流程。';

  @override
  String get authSignUpSuccess => '账户已创建。请继续进行邮箱验证。';

  @override
  String get authSignUpTitle => '创建你的账户';

  @override
  String get authVerificationStatusTitle => '邮箱验证';

  @override
  String get authVerificationTokenLabel => '验证令牌';

  @override
  String get authVerifiedStatus => '已验证';

  @override
  String get authUnverifiedStatus => '等待验证';

  @override
  String get brandSubtitleCompact => 'е­—е№•ж™єиѓЅ';

  @override
  String get brandSubtitleFull => 'AI е­—е№•зї»иЇ‘е·ҐдЅње®¤';

  @override
  String get comingSoonMessage => 'иї™дёЄйЎµйќўиїењЁе‡†е¤‡дё­гЂ‚';

  @override
  String get comingSoonTitle => 'еЌіе°†жЋЁе‡є';

  @override
  String exportFailedSnack(Object error) {
    return 'еЇје‡єе¤±иґҐпјљ$error';
  }

  @override
  String get exportSubtitleLabel => 'еЇје‡єзї»иЇ‘еђЋзљ„е­—е№•';

  @override
  String exportedSnack(Object fileName, Object path) {
    return 'е·Іе°† $fileName еЇје‡єе€° $path';
  }

  @override
  String get exportingLabel => 'ж­ЈењЁеЇје‡є...';

  @override
  String get heroBadge => 'й«зє§е­—е№•е·ҐдЅњжµЃ';

  @override
  String get heroBody =>
      'дЅ еЏЇд»ҐйЂ‰ж‹©еЏЇжђњзґўзљ„з‰‡еђЌз›®еЅ•пјЊж€–з›ґжЋҐдёЉдј ж–‡д»¶пјЊз„¶еђЋењЁе‡ е€†й’џе†…е®Њж€ђйў„и§€е№¶еЇје‡єж‰“зЈЁиї‡зљ„е­—е№•гЂ‚';

  @override
  String get heroHeadline =>
      'з”ЁжЋҐиї‘е·ҐдЅње®¤зє§е€«зљ„жµЃзЁ‹зї»иЇ‘з”µеЅ±е’Ње‰§й›†е­—е№•гЂ‚';

  @override
  String get heroSearchCta => 'жђњзґўз”µеЅ± / е‰§й›†';

  @override
  String get heroStatLanguagesTitle => '10 з§ЌиЇ­иЁЂ';

  @override
  String get heroStatLanguagesValue => 'еЏЇз›ґжЋҐйў„и§€';

  @override
  String get heroStatMockTitle => 'Mock API';

  @override
  String get heroStatMockValue => 'е·ІдёєеђЋз«ЇжЋҐе…ҐеЃљеҐЅе‡†е¤‡';

  @override
  String get heroStatPathsTitle => '2 жќЎи·Їеѕ„';

  @override
  String get heroStatPathsValue => 'жђњзґўж€–дёЉдј ';

  @override
  String get heroSubtitle =>
      'жђњзґўз”µеЅ±е’Ње‰§й›†з›®еЅ•гЂЃйЂ‰ж‹©жќҐжєђпјЊе№¶ењЁе‡ е€†й’џе†…еЇје‡єж‰“зЈЁиї‡зљ„зї»иЇ‘з»“жћњгЂ‚';

  @override
  String get heroTitle => 'ж›ґеї«зї»иЇ‘е­—е№•';

  @override
  String get heroUploadCta => 'дёЉдј е­—е№•';

  @override
  String historyCountLabel(Object count) {
    return '$count жќЎзї»иЇ‘';
  }

  @override
  String get historyEmptyMessage =>
      'е®Њж€ђжђњзґўж€–дёЉдј жµЃзЁ‹еђЋпјЊе·Ізї»иЇ‘зљ„е­—е№•д»»еЉЎдјљжѕз¤єењЁиї™й‡ЊгЂ‚';

  @override
  String get historyEmptyTitle => 'еЋ†еЏІдёєз©є';

  @override
  String get historyFailedItemMessage => 'зї»иЇ‘е¤±иґҐгЂ‚з‚№е‡»й‡Ќж–°ејЂе§‹гЂ‚';

  @override
  String get historyFailedTitle => 'ж— жі•еЉ иЅЅеЋ†еЏІи®°еЅ•';

  @override
  String get historyFilterAiTranslated => 'AI зї»иЇ‘';

  @override
  String get historyFilterAll => 'е…ЁйѓЁ';

  @override
  String get historyFilterCompleted => 'е·Іе®Њж€ђ';

  @override
  String get historyFilterFailed => 'е¤±иґҐ';

  @override
  String get historyFilterMovies => 'з”µеЅ±';

  @override
  String get historyFilterReused => 'е¤Ќз”Ё';

  @override
  String get historyFilterSeries => 'е‰§й›†';

  @override
  String get historySubtitle =>
      'й‡Ќж–°ж‰“ејЂд»Ґе‰Ќзљ„е­—е№•д»»еЉЎпјЊе†Ќж¬ЎжџҐзњ‹йў„и§€пјЊж€–зЁЌеђЋеЇје‡єгЂ‚';

  @override
  String get historyTitle => 'зї»иЇ‘еЋ†еЏІ';

  @override
  String get homeFailedRecentTitle => 'ж— жі•еЉ иЅЅжњЂиї‘д»»еЉЎ';

  @override
  String get homeFutureSubtitle =>
      'еЏЇж›їжЌўзљ„ mock д»“еє“и®© UI д»Јз ЃдёЌеЏ—еђЋз«ЇеЏеЊ–еЅ±е“ЌгЂ‚';

  @override
  String get homeFutureTitle => 'йќўеђ‘жњЄжќҐзљ„д»“еє“и®ѕи®Ў';

  @override
  String get homeNoRecentMessage =>
      'е…€жђњзґўз”µеЅ±ж€–дёЉдј е­—е№•ж–‡д»¶пјЊдЅ жњЂиї‘зљ„зї»иЇ‘дјљжѕз¤єењЁиї™й‡ЊгЂ‚';

  @override
  String get homeNoRecentTitle => 'иїжІЎжњ‰жњЂиї‘д»»еЉЎ';

  @override
  String get homePreviewSubtitle =>
      'еЏЇењЁеЇје‡єе‰ЌйЂљиї‡еЋџж–‡гЂЃиЇ‘ж–‡ж€–еЏЊиЇ­и§†е›ѕжЈЂжџҐз»“жћњгЂ‚';

  @override
  String get homePreviewTitle => 'д»Ґйў„и§€дёєе…€зљ„зї»иЇ‘жµЃзЁ‹';

  @override
  String get homeQuickHistory => 'еЋ†еЏІ';

  @override
  String get homeQuickSearch => 'жђњзґў';

  @override
  String get homeQuickUpload => 'дёЉдј ';

  @override
  String get homeRecentJobsSubtitle =>
      'ж— йњЂд»Ће¤ґејЂе§‹пјЊз›ґжЋҐй‡Ќж–°ж‰“ејЂдЅ жњЂиї‘зљ„е­—е№•дјљиЇќгЂ‚';

  @override
  String get homeRecentJobsTitle => 'жњЂиї‘д»»еЉЎ';

  @override
  String get homeSearchPlaceholder => 'жђњзґўз”µеЅ±ж€–е‰§й›†...';

  @override
  String get homeStatesSubtitle =>
      'еЉ иЅЅгЂЃз©єзЉ¶жЂЃгЂЃй‡ЌиЇ•гЂЃж ЎйЄЊд»ҐеЏЉжЁЎж‹џз¦»зєїењєж™ЇпјЊд»Ћз¬¬дёЂе¤©иµ·е°±жЇ UX зљ„дёЂйѓЁе€†гЂ‚';

  @override
  String get homeStatesTitle => 'е®Ње–„зљ„зЉ¶жЂЃдЅ“йЄЊ';

  @override
  String get homeTrendingNow => 'еЅ“е‰Ќзѓ­й—Ё';

  @override
  String get homeTrustSubtitle =>
      'д»Ље¤©д»ЌжЇжЁЎж‹џз‰€пјЊдЅ†з»“жћ„е·Із»ЏжЊ‰зњџж­ЈеЏЇдёЉзєїзљ„дє§е“ЃжќҐи®ѕи®ЎгЂ‚';

  @override
  String get homeTrustTitle => 'дёєд»Ђд№€е›ўйџдјљдїЎд»»е®ѓ';

  @override
  String get homeViewAll => 'жџҐзњ‹е…ЁйѓЁ';

  @override
  String get homeWelcomeSubtitle => 'жџҐж‰ѕе№¶зї»иЇ‘е­—е№•';

  @override
  String get homeWelcomeTitle => 'ж¬ўиїЋе›ћжќҐ';

  @override
  String jobConfidence(Object level) {
    return 'еЏЇдїЎеє¦пјљ$level';
  }

  @override
  String get jobOpenPreview => 'ж‰“ејЂйў„и§€';

  @override
  String get jobReuseSubtitle => 'е¤Ќз”Ёе­—е№•';

  @override
  String get jobReuseTranslation => 'е¤Ќз”Ёзї»иЇ‘';

  @override
  String get legalBodyAbout =>
      'SubFlix жЇдёЂж¬ѕеЃЏй«зє§дЅ“йЄЊзљ„ Flutter е®ўж€·з«ЇпјЊдё“жіЁдєЋ AI е­—е№•зї»иЇ‘гЂ‚ж­¤з‰€жњ¬дЅїз”Ё mock д»“еє“гЂЃдєєе·Ґе»¶иїџе’Њжњ¬ењ°жЊЃд№…еЊ–пјЊд»ҐдѕїењЁжЋҐе…Ґзњџе®ћеђЋз«Їе‰Ќе…€е®Ње–„ UI дёЋжћ¶жћ„гЂ‚';

  @override
  String get legalBodyPrivacy =>
      'SubFlix еЅ“е‰Ќд»…йЂљиї‡жњ¬ењ°жЊЃд№…еЊ–ењЁи®ѕе¤‡дёЉдїќе­жЁЎж‹џеЃЏеҐЅе’Њзї»иЇ‘еЋ†еЏІгЂ‚жњЄжќҐжЋҐе…ҐеђЋз«ЇеђЋпјЊеЏЇж›їжЌўдёєеё¦иє«д»ЅйЄЊиЇЃзљ„е­е‚ЁгЂЃе®Ўи®Ўи®°еЅ•д»ҐеЏЉжњЌеЉЎе™Ёз®Ўзђ†зљ„дїќз•™з­–з•ҐгЂ‚';

  @override
  String get legalBodySupport =>
      'з›®е‰Ќж”ЇжЊЃйЎµеЏЄжЇеЌ дЅЌе†…е®№гЂ‚ж­ЈејЏз‰€жњ¬дё­пјЊиї™дёЂйѓЁе€†еЏЇд»ҐжЋҐе…Ґй‚®д»¶гЂЃй—®йўеЏЌй¦€д»ҐеЏЉй«зє§иґ¦ж€·ж”ЇжЊЃпјЊеђЊж—¶дїќжЊЃеє”з”ЁжЎ†жћ¶дёЌеЏгЂ‚';

  @override
  String get legalBodyTerms =>
      'иї™дёЄжЁЎж‹џз‰€жњ¬ж—ЁењЁйЄЊиЇЃдє§е“ЃжµЃзЁ‹гЂЃUI зЉ¶жЂЃе’Њжћ¶жћ„иѕ№з•ЊгЂ‚з­‰еђЋз»­жЋҐе…Ґж­ЈејЏзљ„ NestJS дёЋ Postgres еђЋз«ЇеђЋпјЊжі•еѕ‹е±‚йќўеЏЇд»Ґж‰©е±•дёєзњџе®ћзљ„жњЌеЉЎжќЎж¬ѕдёЋж•°жЌ®е¤„зђ†иЇґжЋгЂ‚';

  @override
  String get legalPlaceholderBody =>
      'ж­¤йЎµйќўењЁжј”з¤єеє”з”Ёдё­еЏЄжЇеЌ дЅЌе†…е®№гЂ‚иЇ·ж›їжЌўдёєдЅ ж­ЈејЏзЋЇеўѓдё­зљ„жі•еѕ‹ж–‡жњ¬гЂ‚';

  @override
  String get legalTitleAbout => 'е…ідєЋ SubFlix';

  @override
  String get legalTitlePrivacy => 'йљђз§Ѓж”їз­–';

  @override
  String get legalTitleSupport => 'ж”ЇжЊЃ';

  @override
  String get legalTitleTerms => 'жњЌеЉЎжќЎж¬ѕ';

  @override
  String get mediaTypeMovie => 'з”µеЅ±';

  @override
  String get mediaTypeSeries => 'е‰§й›†';

  @override
  String get metadataEstimatedDuration => 'йў„и®Ўж—¶й•ї';

  @override
  String get metadataFormat => 'ж јејЏ';

  @override
  String get metadataLanguages => 'иЇ­иЁЂ';

  @override
  String get metadataLines => 'иЎЊж•°';

  @override
  String get navHistory => 'еЋ†еЏІ';

  @override
  String get navHome => 'й¦–йЎµ';

  @override
  String get navSettings => 'и®ѕзЅ®';

  @override
  String get noTitlesMatchedMessage =>
      'ж€‘д»¬ењЁжЁЎж‹џз›®еЅ•дё­ж‰ѕдёЌе€°иї™дёЄж ‡йўгЂ‚иЇ·е°ќиЇ•ж›ґе®Ѕжі›зљ„жђњзґўпјЊж€–дЅїз”Ёе»єи®®ж ‡йўгЂ‚';

  @override
  String get noTitlesMatchedTitle => 'жІЎжњ‰еЊ№й…Ќз»“жћњ';

  @override
  String get onboardingContinue => 'з»§з»­';

  @override
  String get onboardingEnterApp => 'иї›е…Ґ SubFlix';

  @override
  String get onboardingNext => 'дё‹дёЂж­Ґ';

  @override
  String get onboardingPage1Description =>
      'жђњзґўж ‡йўгЂЃжџҐзњ‹еЏЇз”Ёзљ„и‹±ж–‡е­—е№•жќҐжєђпјЊз„¶еђЋеђЇеЉЁдёЂдёЄе‡ д№ЋеЌіж—¶зљ„зї»иЇ‘жµЃзЁ‹гЂ‚';

  @override
  String get onboardingPage1Eyebrow => 'жђњзґўе№¶иЋ·еЏ–';

  @override
  String get onboardingPage1Highlight1 =>
      'еЏЇйў„жµ‹зљ„жЁЎж‹џз›®еЅ•пјЊж–№дѕїзЁіе®љејЂеЏ‘';

  @override
  String get onboardingPage1Highlight2 =>
      'е­—е№•жќҐжєђиґЁй‡Џж ‡з­ѕдёЋж јејЏж ‡иЇ†';

  @override
  String get onboardingPage1Highlight3 =>
      'еђЋз»­еЏЇж— зјќе€‡жЌўе€°зњџе®ћеђЋз«Ї';

  @override
  String get onboardingPage1Title =>
      'ж‰ѕе€°з”µеЅ±ж€–е‰§й›†пјЊе№¶ж‹‰еЏ–еЏЇз›ґжЋҐзї»иЇ‘зљ„е­—е№•гЂ‚';

  @override
  String get onboardingPage2Description =>
      'еЇје…Ґе­—е№•ж–‡д»¶гЂЃж ЎйЄЊж јејЏпјЊе№¶ењЁдёЌз¦»ејЂеє”з”Ёзљ„жѓ…е†µдё‹иµ°е®Њж•ґеҐ—зІѕи‡ґзї»иЇ‘жµЃзЁ‹гЂ‚';

  @override
  String get onboardingPage2Eyebrow => 'дЅїз”Ёи‡Єе·±зљ„ж–‡д»¶';

  @override
  String get onboardingPage2Highlight1 =>
      'жњ¬ењ°ж–‡д»¶ж ЎйЄЊдёЋдјй›…зљ„й‡ЌиЇ•зЉ¶жЂЃ';

  @override
  String get onboardingPage2Highlight2 =>
      'дёЉдј дёЋжђњзґўдїќжЊЃдёЂи‡ґзљ„зї»иЇ‘и®ѕзЅ®';

  @override
  String get onboardingPage2Highlight3 =>
      'еЇје‡єе‰Ќе…€йў„и§€пјЊи®©з»“жћњж›ґйЂЏжЋ';

  @override
  String get onboardingPage2Title =>
      'е¦‚жћњдЅ е·Із»Џжњ‰и„љжњ¬пјЊеЏЇз›ґжЋҐдёЉдј  `.srt` ж€– `.vtt` ж–‡д»¶гЂ‚';

  @override
  String get onboardingPage3Description =>
      'ењЁеЋџж–‡гЂЃиЇ‘ж–‡е’ЊеЏЊиЇ­и§†е›ѕд№‹й—ґе€‡жЌўпјЊе›ћзњ‹еЋ†еЏІи®°еЅ•пјЊе№¶ењЁз»“жћњж»Ўж„ЏеђЋеЇје‡єе№Іе‡Ђзљ„е­—е№•ж–‡д»¶гЂ‚';

  @override
  String get onboardingPage3Eyebrow => 'зї»иЇ‘е№¶еЇје‡є';

  @override
  String get onboardingPage3Highlight1 =>
      'её¦е…ѓж•°жЌ®дёЋжђњзґўзљ„еї«йЂџйў„и§€жЋ§е€¶';

  @override
  String get onboardingPage3Highlight2 =>
      'еЋ†еЏІи®°еЅ•и®©ж—§д»»еЉЎе§‹з»€еЏЄе·®дёЂж¬Ўз‚№е‡»';

  @override
  String get onboardingPage3Highlight3 =>
      'и®ѕи®Ўеѕ—еѓЏй«зє§еЄ’дЅ“е·Ґе…·пјЊиЂЊдёЌжЇжј”з¤єйЎµ';

  @override
  String get onboardingPage3Title =>
      'йЂ‰ж‹©з›®ж ‡иЇ­иЁЂгЂЃйў„и§€е­—е№•пјЊе№¶з«‹еЌіеЇје‡єгЂ‚';

  @override
  String get onboardingSkip => 'и·іиї‡';

  @override
  String get onboardingStart => 'ејЂе§‹зї»иЇ‘';

  @override
  String get previewFailedTitle => 'йў„и§€еЉ иЅЅе¤±иґҐ';

  @override
  String get previewModeBilingual => 'еЏЊиЇ­';

  @override
  String get previewModeOriginal => 'еЋџж–‡';

  @override
  String get previewModeTranslated => 'иЇ‘ж–‡';

  @override
  String get previewNoMatchesMessage =>
      'иЇ·е°ќиЇ•е…¶д»–жђњзґўиЇЌпјЊж€–жё…й™¤з­›йЂ‰д»ҐжџҐзњ‹е®Њж•ґзї»иЇ‘гЂ‚';

  @override
  String get previewNoMatchesTitle => 'жІЎжњ‰еЊ№й…Ќзљ„е­—е№•иЎЊ';

  @override
  String get previewNotReadyMessage =>
      'зї»иЇ‘е·Іе®Њж€ђпјЊдЅ†еђЋз«Їе°љжњЄиї”е›ћйў„и§€ cueгЂ‚иЇ·зЁЌеђЋй‡Ќж–°еЉ иЅЅж­¤йЎµйќўгЂ‚';

  @override
  String get previewNotReadyTitle => 'йў„и§€ cue жљ‚ж—¶дёЌеЏЇз”Ё';

  @override
  String get retry => 'й‡ЌиЇ•';

  @override
  String get retryTranslation => 'й‡Ќж–°зї»иЇ‘';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'ж€‘д»¬ж— жі•е€¤ж–­еє”еЉ иЅЅе“ЄдёЂе­ЈгЂ‚иЇ·д»Ћжђњзґўй‡Ќж–°ејЂе§‹гЂ‚';

  @override
  String get routeMissingSeasonEpisodesTitle => 'жњ¬е­Је‰§й›†';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'ж€‘д»¬ж— жі•е€¤ж–­еє”еЉ иЅЅе“ЄйѓЁе‰§й›†гЂ‚иЇ·д»Ћжђњзґўй‡Ќж–°ејЂе§‹гЂ‚';

  @override
  String get routeMissingSeriesSeasonsTitle => 'е‰§й›†е­Је€—иЎЁ';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'ж€‘д»¬ж— жі•е€¤ж–­еє”дёєе“ЄдёЄж ‡йўеЉ иЅЅе­—е№•жќҐжєђгЂ‚иЇ·д»Ћжђњзґўй‡Ќж–°ејЂе§‹гЂ‚';

  @override
  String get routeMissingSubtitleSourcesTitle => 'е­—е№•жќҐжєђ';

  @override
  String get routeMissingTranslationProgressMessage =>
      'жІЎжњ‰жЏђдѕ›зї»иЇ‘иЇ·ж±‚гЂ‚иЇ·д»Ћжђњзґўж€–дёЉдј ејЂе§‹ж–°зљ„зї»иЇ‘гЂ‚';

  @override
  String get routeMissingTranslationProgressTitle => 'зї»иЇ‘иї›еє¦';

  @override
  String get routeMissingTranslationSetupMessage =>
      'ж‰“ејЂзї»иЇ‘и®ѕзЅ®йЎµйќўе‰ЌпјЊеї…йЎ»е…€жњ‰дёЂдёЄе­—е№•жќҐжєђгЂ‚';

  @override
  String get routeMissingTranslationSetupTitle => 'зї»иЇ‘и®ѕзЅ®';

  @override
  String get searchFailedTitle => 'жђњзґўе¤±иґҐ';

  @override
  String searchFoundResults(Object count, Object query) {
    return 'ж‰ѕе€° $count жќЎдёЋвЂњ$queryвЂќз›ёе…ізљ„з»“жћњ';
  }

  @override
  String get searchHintText => 'жђњзґў DuneгЂЃBreaking BadгЂЃSeverance...';

  @override
  String get searchLoadingLabel => 'ж­ЈењЁжђњзґў...';

  @override
  String get searchMockMessage =>
      'иЇ•иЇ• InceptionгЂЃDuneгЂЃBreaking BadгЂЃSeverance ж€– The Last of UsпјЊдЅ“йЄЊе­—е№•жќҐжєђжµЃзЁ‹гЂ‚';

  @override
  String get searchMockTitle => 'ењЁжЁЎж‹џз›®еЅ•дё­жђњзґўд»»дЅ•е†…е®№';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'ж‰ѕе€°з‰‡еђЌгЂЃжџҐзњ‹е­—е№•жќҐжєђпјЊе№¶йЂљиї‡е‡ ж¬Ўз‚№е‡»еђЇеЉЁзї»иЇ‘д»»еЉЎгЂ‚';

  @override
  String get searchMovieOrSeriesTitle => 'жђњзґўз”µеЅ±ж€–е‰§й›†';

  @override
  String searchNoResultsFor(Object query) {
    return 'жІЎжњ‰ж‰ѕе€°вЂњ$queryвЂќзљ„з»“жћњ';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'зѓ­еє¦ $score';
  }

  @override
  String get searchTitles => 'жђњзґўз‰‡еђЌ';

  @override
  String get searchTrendingTitle => 'зѓ­й—Ёжђњзґў';

  @override
  String get searchTryDifferentKeywords => 'иЇ•иЇ•е…¶д»–е…ій”®иЇЌгЂ‚';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'з¬¬ $episodeNumber й›†';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'зє¦ $runtime е€†й’џ';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount й›†$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'з¬¬ $seasonNumber е­Ј';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'з¬¬ $seasonNumber е­Ј';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount й›†$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'йЂ‰ж‹© $title зљ„жџђдёЂе­Јд»ҐжµЏи§€еЏЇз”Ёе‰§й›†гЂ‚';
  }

  @override
  String get seriesSeasonsTitle => 'йЂ‰ж‹©е­Ј';

  @override
  String get settingsAboutTitle => 'е…ідєЋ SubFlix';

  @override
  String get settingsCacheCleared => 'зј“е­е·Іжё…й™¤';

  @override
  String get settingsClearCache => 'жё…й™¤зј“е­';

  @override
  String get settingsContactTitle => 'иЃ”зі»ж€‘д»¬';

  @override
  String get settingsFailedTitle => 'и®ѕзЅ®еЉ иЅЅе¤±иґҐ';

  @override
  String get settingsHelpCenterTitle => 'её®еЉ©дё­еїѓ';

  @override
  String get settingsHistoryClearedSnack => 'е·Іжё…й™¤ж­¤и®ѕе¤‡зљ„зї»иЇ‘еЋ†еЏІ';

  @override
  String get settingsLanguageLabel => 'й¦–йЂ‰з›®ж ‡иЇ­иЁЂ';

  @override
  String get settingsMaintenanceSubtitle =>
      'жё…й™¤ж­¤и®ѕе¤‡дёЉз”±еђЋз«Їз®Ўзђ†зљ„зї»иЇ‘д»»еЉЎпјЊе№¶д»Ћз©єеЋ†еЏІзЉ¶жЂЃй‡Ќж–°ејЂе§‹гЂ‚';

  @override
  String get settingsMaintenanceTitle => 'з»ґжЉ¤';

  @override
  String get settingsNotificationsSubtitle => 'з®Ўзђ†йЂљзџҐеЃЏеҐЅ';

  @override
  String get settingsNotificationsTitle => 'йЂљзџҐ';

  @override
  String get settingsPremiumSubtitle =>
      'еђЋз»­ж€‘д»¬еЏЇд»ҐењЁиї™й‡ЊжЋҐе…Ґи®ўй…гЂЃи®Ўиґ№е’Њдє‘йЎ№з›®еђЊж­ҐгЂ‚';

  @override
  String get settingsPremiumTitle => 'й«зє§еЉџиѓЅеЌ дЅЌ';

  @override
  String get settingsPrivacySubtitle => 'жЁЎж‹џйљђз§Ѓе†…е®№';

  @override
  String get settingsPrivacyTitle => 'йљђз§Ѓж”їз­–';

  @override
  String get settingsProfileName => 'SubFlix з”Ёж€·';

  @override
  String get settingsProfileTier => 'й«зє§дјље‘';

  @override
  String get settingsSubtitle => 'з®Ўзђ†дЅ зљ„еЃЏеҐЅ';

  @override
  String get settingsSupportSubtitle => 'жЁЎж‹џеё®еЉ©дёЋиЃ”зі»йЎµйќў';

  @override
  String get settingsSupportTitle => 'ж”ЇжЊЃеЌ дЅЌ';

  @override
  String get settingsTermsSubtitle => 'жЁЎж‹џжќЎж¬ѕе†…е®№';

  @override
  String get settingsTermsTitle => 'жњЌеЉЎжќЎж¬ѕ';

  @override
  String get settingsThemeLabel => 'е¤–и§‚';

  @override
  String get settingsTitle => 'и®ѕзЅ®';

  @override
  String settingsVersion(Object version) {
    return 'з‰€жњ¬ $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'ж­ЈењЁе‡†е¤‡дЅ зљ„е­—е№•е·ҐдЅње®¤';

  @override
  String get splashSubtitle => 'AI й©±еЉЁзљ„е­—е№•зї»иЇ‘';

  @override
  String get startTranslation => 'ејЂе§‹зї»иЇ‘';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads ж¬Ўдё‹иЅЅ';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format е­—е№•жќҐжєђ';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount иЎЊ';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'иЇ„е€† $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'йЂ‰ж‹©е­—е№•жќҐжєђеђЋпјЊеЌіеЏЇиї›е…Ґй’€еЇ№е­—е№•ж—¶й—ґиЅґдјеЊ–иї‡зљ„зІѕи‡ґзї»иЇ‘и®ѕзЅ®гЂ‚';

  @override
  String get subtitleSourcesBannerTitle => 'еЏЇдЅїз”Ё AI зї»иЇ‘';

  @override
  String get subtitleSourcesFailedTitle => 'ж— жі•еЉ иЅЅе­—е№•жќҐжєђ';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'дёє $title$target йЂ‰ж‹©дёЂдёЄе­—е№•жќҐжєђпјЊз„¶еђЋењЁдё‹дёЂж­ҐйЂ‰ж‹©з›®ж ‡иЇ­иЁЂгЂ‚';
  }

  @override
  String get subtitleSourcesTitle => 'и‹±ж–‡е­—е№•жќҐжєђ';

  @override
  String get targetLanguage => 'з›®ж ‡иЇ­иЁЂ';

  @override
  String get themeDark => 'ж·±и‰І';

  @override
  String get themeLight => 'жµ…и‰І';

  @override
  String get themeSystem => 'и·џйљЏзі»з»џ';

  @override
  String get translateSetupAutoDetect => 'и‡ЄеЉЁиЇ†е€«ж јејЏ';

  @override
  String get translateSetupAutoDetectBody =>
      'и‡ЄеЉЁйЂ‰ж‹©еђ€йЂ‚зљ„е­—е№•иѕ“е‡єз»“жћ„гЂ‚';

  @override
  String get translateSetupLanguageTitle => 'зї»иЇ‘дёє';

  @override
  String get translateSetupOptionsTitle => 'йЂ‰йЎ№';

  @override
  String get translateSetupPreserveTiming => 'дїќз•™ж—¶й—ґиЅґ';

  @override
  String get translateSetupPreserveTimingBody =>
      'и®©еЋџе§‹е­—е№•ж—¶й—ґдёЋжєђж–‡д»¶дїќжЊЃдёЂи‡ґгЂ‚';

  @override
  String translateSetupReadyBody(Object language) {
    return 'ж€‘д»¬зљ„зї»иЇ‘жµЃзЁ‹дјље°†иї™д»Ѕе­—е№•иЅ¬жЌўдёє $languageпјЊеђЊж—¶дїќз•™ж—¶й—ґиЅґе№¶дїќжЊЃжё…ж™°зљ„ cue з»“жћ„гЂ‚';
  }

  @override
  String get translateSetupReadyTitle => 'AI зї»иЇ‘е·Іе°±з»Є';

  @override
  String get translateSetupSelectLanguage => 'йЂ‰ж‹©иЇ­иЁЂ';

  @override
  String get translateSetupSourceTitle => 'жєђе­—е№•';

  @override
  String get translateSetupSubtitle =>
      'йЂ‰ж‹©з›®ж ‡иЇ­иЁЂпјЊжџҐзњ‹е­—е№•жќҐжєђпјЊз„¶еђЋеђЇеЉЁеђЋз«Їзї»иЇ‘д»»еЉЎгЂ‚';

  @override
  String get translateSetupTitle => 'зї»иЇ‘и®ѕзЅ®';

  @override
  String get translationFailedMessage => 'е‡єдє†з‚№й—®йўгЂ‚';

  @override
  String get translationFailedTitle => 'зї»иЇ‘жњЄиѓЅе®Њж€ђ';

  @override
  String get translationPreviewHeader => 'жџҐзњ‹зї»иЇ‘еђЋзљ„е­—е№•';

  @override
  String get translationPreviewSearchHint => 'жђњзґўе­—е№•иЎЊ';

  @override
  String get translationPreviewSubtitle =>
      'ењЁ cue дё­жђњзґўгЂЃе€‡жЌўйў„и§€жЁЎејЏпјЊе№¶ењЁзЎ®и®¤з»“жћњж— иЇЇеђЋеЇје‡єгЂ‚';

  @override
  String get translationPreviewTitle => 'зї»иЇ‘йў„и§€';

  @override
  String get translationProgressHeadline => 'AI е­—е№•зї»иЇ‘иї›иЎЊдё­';

  @override
  String get translationProgressTitle => 'зї»иЇ‘иї›еє¦';

  @override
  String get translationResultCompleteSubtitle =>
      'дЅ зљ„е­—е№•е·Із»ЏеЏЇд»Ґйў„и§€ж€–дё‹иЅЅгЂ‚';

  @override
  String get translationResultCompleteTitle => 'зї»иЇ‘е®Њж€ђ';

  @override
  String get translationResultConfidenceLabel => 'зї»иЇ‘еЏЇдїЎеє¦';

  @override
  String get translationResultDetailsTitle => 'зї»иЇ‘иЇ¦жѓ…';

  @override
  String get translationResultDownloadCta => 'дё‹иЅЅе­—е№•';

  @override
  String get translationResultHomeCta => 'иї”е›ћй¦–йЎµ';

  @override
  String get translationResultMediaLabel => 'дЅње“Ѓж ‡йў';

  @override
  String get translationResultMethodAi => 'AI зї»иЇ‘';

  @override
  String get translationResultMetricsTitle => 'иґЁй‡ЏжЊ‡ж ‡';

  @override
  String get translationResultPreviewCta => 'йў„и§€е­—е№•';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'е¤„зђ†иЂ—ж—¶ $duration';
  }

  @override
  String get translationResultSourceLabel => 'жєђиЇ­иЁЂ';

  @override
  String get translationResultTargetLabel => 'з›®ж ‡иЇ­иЁЂ';

  @override
  String get translationResultTimingLabel => 'ж—¶й—ґзІѕеє¦';

  @override
  String get translationResultTimingPreserved => 'ж—¶й—ґе·Ідїќз•™';

  @override
  String get translationResultWarning =>
      'жџђдє›дё“дёљжњЇиЇ­д»ЌеЏЇиѓЅйњЂи¦Ѓдєєе·Ґеї«йЂџе¤Ќж ёпјЊд»ҐзЎ®дїќиЇ­еўѓе‡†зЎ®гЂ‚';

  @override
  String get translationStageAligning =>
      'ж­ЈењЁеЇ№йЅђж—¶й—ґж€іе’Њењєж™ЇдёЉдё‹ж–‡';

  @override
  String get translationStageGenerating => 'ж­ЈењЁз”џж€ђе­—е№•зї»иЇ‘';

  @override
  String get translationStageIdle => 'з­‰еѕ…зї»иЇ‘иЇ·ж±‚';

  @override
  String get translationStagePreparing => 'ж­ЈењЁе‡†е¤‡е­—е№•еЊ…';

  @override
  String get translationStageQueued => 'е·ІеЉ е…Ґзї»иЇ‘йџе€—';

  @override
  String get translationStageReadability => 'ж­ЈењЁиї›иЎЊеЏЇиЇ»жЂ§дјеЊ–';

  @override
  String get translationStageReady => 'зї»иЇ‘е·Іе®Њж€ђ';

  @override
  String get tryAgain => 'е†ЌиЇ•дёЂж¬Ў';

  @override
  String get uploadChooseFile => 'йЂ‰ж‹©е­—е№•ж–‡д»¶';

  @override
  String get uploadChooseFileShort => 'йЂ‰ж‹©ж–‡д»¶';

  @override
  String get uploadContinueSetup => 'з»§з»­иї›иЎЊзї»иЇ‘и®ѕзЅ®';

  @override
  String get uploadEnglishSource => 'и‹±ж–‡жќҐжєђ';

  @override
  String get uploadFailedFallback => 'иЇ·е°ќиЇ•е…¶д»–е­—е№•ж–‡д»¶гЂ‚';

  @override
  String get uploadFailedMessage =>
      'ж€‘д»¬ж— жі•иЇ»еЏ–иї™дёЄе­—е№•ж–‡д»¶гЂ‚иЇ·е°ќиЇ•е…¶д»–ж–‡д»¶пјЊж€–дЅїз”Ёж›ґе°Џзљ„еЇје‡єж–‡д»¶гЂ‚';

  @override
  String get uploadFailedTitle => 'ж–‡д»¶еЇје…Ґе¤±иґҐ';

  @override
  String get uploadIntroSubtitle =>
      'еЇје…Ґи‹±ж–‡ `.srt` ж€– `.vtt` ж–‡д»¶пјЊдє¤з»™еђЋз«Їж ЎйЄЊе№¶и§ЈжћђпјЊз„¶еђЋз»§з»­иї›е…Ґзї»иЇ‘и®ѕзЅ®гЂ‚';

  @override
  String get uploadIntroTitle => 'дЅїз”ЁдЅ и‡Єе·±зљ„е­—е№•ж–‡д»¶';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount иЎЊ';
  }

  @override
  String get uploadMetadataTitle => 'е­—е№•иЇ¦жѓ…';

  @override
  String get uploadOpeningPicker => 'ж­ЈењЁж‰“ејЂйЂ‰ж‹©е™Ё...';

  @override
  String get uploadPickSubtitle => 'йЂ‰ж‹©е­—е№•ж–‡д»¶';

  @override
  String get uploadPickedFile => 'е·ІйЂ‰ж‹©е­—е№•ж–‡д»¶';

  @override
  String get uploadReadyTitle => 'еЏЇд»ҐејЂе§‹зї»иЇ‘';

  @override
  String get uploadSubtitleTitle => 'дёЉдј е­—е№•';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'и‹±ж–‡ `.srt` е’Њ `.vtt` е­—е№•ж–‡д»¶';

  @override
  String get uploadSupportedFormatsTitle => 'ж”ЇжЊЃзљ„ж јејЏ';

  @override
  String get uploadUseDemoFile => 'дЅїз”Ёжј”з¤єж–‡д»¶';
}
