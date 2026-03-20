// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'खाता';

  @override
  String get authAlreadySignedInTitle => 'आप पहले से साइन इन हैं';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'यह डिवाइस पहले से $email के रूप में जुड़ा हुआ है।';
  }

  @override
  String get authBackToAccount => 'खाते पर वापस जाएँ';

  @override
  String get authBackToSignIn => 'साइन इन पर वापस जाएँ';

  @override
  String get authCheckInboxTitle => 'अपना इनबॉक्स देखें';

  @override
  String get authConfirmEmailAction => 'ईमेल की पुष्टि करें';

  @override
  String authConfirmEmailHint(Object email) {
    return '$email पर भेजा गया सत्यापन टोकन इस्तेमाल करें।';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'इस खाते को सक्रिय करना पूरा करने के लिए अपने ईमेल का सत्यापन टोकन पेस्ट करें।';

  @override
  String get authConfirmEmailSuccess =>
      'ईमेल की पुष्टि हो गई। अब आप साइन इन कर सकते हैं।';

  @override
  String get authConfirmEmailTitle => 'अपना ईमेल सत्यापित करें';

  @override
  String get authConfirmPasswordLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get authContinueToReset => 'रीसेट पर आगे बढ़ें';

  @override
  String get authContinueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get authCreateAccountAction => 'खाता बनाएँ';

  @override
  String authDebugTokenLabel(Object token) {
    return 'डीबग टोकन: $token';
  }

  @override
  String get authDisplayNameLabel => 'डिस्प्ले नाम';

  @override
  String get authEmailLabel => 'ईमेल पता';

  @override
  String get authEyebrow => 'सुरक्षित स्थान';

  @override
  String get authFieldRequired => 'यह फ़ील्ड आवश्यक है।';

  @override
  String get authForgotPasswordAction => 'रीसेट लिंक भेजें';

  @override
  String get authForgotPasswordDebugMessage =>
      'इस डीबग वातावरण के लिए एक रीसेट टोकन लौटाया गया है। आप सीधे रीसेट फ़ॉर्म पर जा सकते हैं।';

  @override
  String get authForgotPasswordLink => 'पासवर्ड भूल गए?';

  @override
  String get authForgotPasswordSubtitle =>
      'अपना ईमेल दर्ज करें और हम इस खाते के लिए बैकएंड से पासवर्ड रीसेट का अनुरोध करेंगे।';

  @override
  String get authForgotPasswordSuccess =>
      'यदि खाता मौजूद है, तो पासवर्ड रीसेट संदेश भेज दिया गया है।';

  @override
  String get authForgotPasswordTitle => 'अपना पासवर्ड रीसेट करें';

  @override
  String get authGoogleHelper =>
      'Google साइन-इन Firebase OAuth का उपयोग करता है और यह तब काम करेगा जब यह ऐप Firebase प्रोजेक्ट से जुड़ जाएगा।';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'पहले से खाता है? साइन इन करें';

  @override
  String get authInvalidEmail => 'एक मान्य ईमेल पता दर्ज करें।';

  @override
  String get authNewPasswordLabel => 'नया पासवर्ड';

  @override
  String get authNoAccountLink => 'खाता चाहिए? एक बनाएँ';

  @override
  String get authOrDivider => 'या';

  @override
  String get authPasswordLabel => 'पासवर्ड';

  @override
  String get authPasswordMismatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get authPasswordTooShort => 'कम से कम 8 अक्षर इस्तेमाल करें।';

  @override
  String get authProfileRefreshed => 'खाते का डेटा अपडेट किया गया।';

  @override
  String get authRefreshProfileAction => 'प्रोफ़ाइल रीफ़्रेश करें';

  @override
  String get authRefreshProfileSubtitle =>
      'बैकएंड से नवीनतम प्रोफ़ाइल डेटा लोड करें।';

  @override
  String get authResetPasswordAction => 'नया पासवर्ड सहेजें';

  @override
  String authResetPasswordHint(Object email) {
    return 'अपने ईमेल में मिले टोकन का उपयोग करके $email का पासवर्ड रीसेट करें।';
  }

  @override
  String get authResetPasswordSubtitle =>
      'रीसेट टोकन दर्ज करें और इस खाते के लिए नया पासवर्ड चुनें।';

  @override
  String get authResetPasswordSuccess =>
      'पासवर्ड अपडेट हो गया। कृपया फिर से साइन इन करें।';

  @override
  String get authResetPasswordTitle => 'नया पासवर्ड चुनें';

  @override
  String get authSignInAction => 'साइन इन करें';

  @override
  String get authSignInSubtitle =>
      'इस ऐप को अपने SubFlix खाते से जोड़ें ताकि प्रोफ़ाइल डेटा सिंक हो सके और प्रमाणित बैकएंड प्रवाह उपलब्ध हो सकें।';

  @override
  String get authSignInSuccess => 'सफलतापूर्वक साइन इन किया गया।';

  @override
  String get authSignInTitle => 'फिर से स्वागत है';

  @override
  String authSignedInCardSubtitle(Object email) {
    return '$email के रूप में जुड़ा हुआ';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'अपने खाते को प्रबंधित करने, Firebase OAuth इस्तेमाल करने और भविष्य की सिंक के लिए प्रमाणित सुविधाएँ तैयार रखने हेतु साइन इन करें।';

  @override
  String get authSignedOutCardTitle => 'SubFlix में साइन इन करें';

  @override
  String get authSignOutAction => 'साइन आउट';

  @override
  String get authSignOutSubtitle =>
      'इस डिवाइस की वर्तमान सत्र को रद्द करें और स्थानीय टोकन साफ़ करें।';

  @override
  String get authSignOutSuccess => 'इस डिवाइस पर साइन आउट कर दिया गया।';

  @override
  String get authSignUpAction => 'मेरा खाता बनाएँ';

  @override
  String get authSignUpSubtitle =>
      'एक खाता बनाएँ ताकि यह ऐप प्रमाणित प्रोफ़ाइल और बैकएंड सत्र प्रवाह का उपयोग कर सके।';

  @override
  String get authSignUpSuccess => 'खाता बन गया। ईमेल सत्यापन जारी रखें।';

  @override
  String get authSignUpTitle => 'अपना खाता बनाएँ';

  @override
  String get authVerificationStatusTitle => 'ईमेल सत्यापन';

  @override
  String get authVerificationTokenLabel => 'सत्यापन टोकन';

  @override
  String get authVerifiedStatus => 'सत्यापित';

  @override
  String get authUnverifiedStatus => 'सत्यापन लंबित';

  @override
  String get brandSubtitleCompact =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤‡а¤‚а¤џаҐ‡а¤Іа¤їа¤њаҐ‡а¤‚а¤ё';

  @override
  String get brandSubtitleFull =>
      'AI а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐЌа¤џаҐ‚а¤Ўа¤їа¤ЇаҐ‹';

  @override
  String get comingSoonMessage =>
      'а¤№а¤® а¤…а¤­аҐЂ а¤Їа¤№ а¤ёаҐЌа¤•аҐЌа¤°аҐЂа¤Ё а¤¤аҐ€а¤Їа¤ѕа¤° а¤•а¤° а¤°а¤№аҐ‡ а¤№аҐ€а¤‚аҐ¤';

  @override
  String get comingSoonTitle => 'а¤ња¤ІаҐЌа¤¦ а¤† а¤°а¤№а¤ѕ а¤№аҐ€';

  @override
  String exportFailedSnack(Object error) {
    return 'а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤…а¤ёа¤«а¤І а¤°а¤№а¤ѕ: $error';
  }

  @override
  String get exportSubtitleLabel =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName а¤•аҐ‹ $path а¤Єа¤° а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤їа¤Їа¤ѕ а¤—а¤Їа¤ѕ';
  }

  @override
  String get exportingLabel =>
      'а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤їа¤Їа¤ѕ а¤ња¤ѕ а¤°а¤№а¤ѕ а¤№аҐ€...';

  @override
  String get heroBadge =>
      'а¤ЄаҐЌа¤°аҐЂа¤®а¤їа¤Їа¤® а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤µа¤°аҐЌа¤•а¤«а¤јаҐЌа¤ІаҐ‹';

  @override
  String get heroBody =>
      'а¤–аҐ‹а¤ња¤ЁаҐ‡ а¤ЇаҐ‹а¤—аҐЌа¤Ї а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤•аҐ€а¤џа¤ІаҐ‰а¤— а¤Їа¤ѕ а¤ёаҐЂа¤§аҐЂ а¤«а¤ја¤ѕа¤‡а¤І а¤…а¤Єа¤ІаҐ‹а¤Ў а¤®аҐ‡а¤‚ а¤ёаҐ‡ а¤љаҐЃа¤ЁаҐ‡а¤‚, а¤«а¤їа¤° а¤•аҐЃа¤› а¤®а¤їа¤Ёа¤џаҐ‹а¤‚ а¤®аҐ‡а¤‚ а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° polished а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get heroHeadline =>
      'а¤ёаҐЌа¤џаҐ‚а¤Ўа¤їа¤ЇаҐ‹-а¤—аҐЌа¤°аҐ‡а¤Ў а¤«а¤јаҐЌа¤ІаҐ‹ а¤•аҐ‡ а¤ёа¤ѕа¤Ґ а¤«а¤ја¤їа¤ІаҐЌа¤® а¤”а¤° а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤•а¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get heroSearchCta =>
      'а¤«а¤ја¤їа¤ІаҐЌа¤® / а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String get heroStatLanguagesTitle => '10 а¤­а¤ѕа¤·а¤ѕа¤Џа¤Ѓ';

  @override
  String get heroStatLanguagesValue =>
      'а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤°';

  @override
  String get heroStatMockTitle => 'Mock APIs';

  @override
  String get heroStatMockValue =>
      'а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў-а¤°аҐ‡а¤ЎаҐЂ а¤ІаҐ‡а¤Їа¤°';

  @override
  String get heroStatPathsTitle => '2 а¤°а¤ѕа¤ёаҐЌа¤¤аҐ‡';

  @override
  String get heroStatPathsValue => 'а¤–аҐ‹а¤њ а¤Їа¤ѕ а¤…а¤Єа¤ІаҐ‹а¤Ў';

  @override
  String get heroSubtitle =>
      'а¤«а¤ја¤їа¤ІаҐЌа¤® а¤”а¤° а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤•аҐ€а¤џа¤ІаҐ‰а¤— а¤–аҐ‹а¤њаҐ‡а¤‚, а¤ёаҐЌа¤°аҐ‹а¤¤ а¤љаҐЃа¤ЁаҐ‡а¤‚ а¤”а¤° а¤•аҐЃа¤› а¤№аҐЂ а¤®а¤їа¤Ёа¤џаҐ‹а¤‚ а¤®аҐ‡а¤‚ polished а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get heroTitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤¤аҐ‡а¤њаҐЂ а¤ёаҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•а¤°аҐ‡а¤‚';

  @override
  String get heroUploadCta =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤Єа¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚';

  @override
  String historyCountLabel(Object count) {
    return '$count а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦';
  }

  @override
  String get historyEmptyMessage =>
      'а¤њаҐ€а¤ёаҐ‡ а¤№аҐЂ а¤†а¤Є а¤–аҐ‹а¤њ а¤Їа¤ѕ а¤…а¤Єа¤ІаҐ‹а¤Ў а¤«а¤јаҐЌа¤ІаҐ‹ а¤ЄаҐ‚а¤°а¤ѕ а¤•а¤°аҐ‡а¤‚а¤—аҐ‡, а¤†а¤Єа¤•аҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤њаҐ‰а¤¬ а¤Їа¤№а¤ѕа¤Ѓ а¤¦а¤їа¤–аҐ‡а¤‚а¤—аҐ‡аҐ¤';

  @override
  String get historyEmptyTitle => 'а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤–а¤ѕа¤ІаҐЂ а¤№аҐ€';

  @override
  String get historyFailedItemMessage =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤…а¤ёа¤«а¤І а¤°а¤№а¤ѕаҐ¤ а¤«а¤їа¤° а¤ёаҐ‡ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°а¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤џаҐ€а¤Є а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get historyFailedTitle =>
      'а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤ІаҐ‹а¤Ў а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•а¤ѕ';

  @override
  String get historyFilterAiTranslated => 'AI а¤ёаҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤';

  @override
  String get historyFilterAll => 'а¤ёа¤­аҐЂ';

  @override
  String get historyFilterCompleted => 'а¤ЄаҐ‚а¤°аҐЌа¤Ј';

  @override
  String get historyFilterFailed => 'а¤…а¤ёа¤«а¤І';

  @override
  String get historyFilterMovies => 'а¤«а¤ја¤їа¤ІаҐЌа¤®аҐ‡а¤‚';

  @override
  String get historyFilterReused =>
      'а¤¦аҐ‹а¤¬а¤ѕа¤°а¤ѕ а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І';

  @override
  String get historyFilterSeries => 'а¤ёаҐЂа¤°аҐЂа¤ња¤ј';

  @override
  String get historySubtitle =>
      'а¤ЄаҐЃа¤°а¤ѕа¤ЁаҐ‡ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤њаҐ‰а¤¬ а¤«а¤їа¤° а¤ёаҐ‡ а¤–аҐ‹а¤ІаҐ‡а¤‚, а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤¦аҐ‹а¤¬а¤ѕа¤°а¤ѕ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤Їа¤ѕ а¤¬а¤ѕа¤¦ а¤®аҐ‡а¤‚ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get historyTitle => 'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤‡а¤¤а¤їа¤№а¤ѕа¤ё';

  @override
  String get homeFailedRecentTitle =>
      'а¤№а¤ѕа¤І а¤•аҐ‡ а¤њаҐ‰а¤¬ а¤ІаҐ‹а¤Ў а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•аҐ‡';

  @override
  String get homeFutureSubtitle =>
      'а¤¬а¤¦а¤ІаҐ‡ а¤ња¤ѕ а¤ёа¤•а¤ЁаҐ‡ а¤µа¤ѕа¤ІаҐ‡ mock repositories UI а¤•аҐ‹а¤Ў а¤•аҐ‹ а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў а¤¬а¤¦а¤Іа¤ѕа¤µаҐ‹а¤‚ а¤ёаҐ‡ а¤ёаҐЃа¤°а¤•аҐЌа¤·а¤їа¤¤ а¤°а¤–а¤¤аҐ‡ а¤№аҐ€а¤‚аҐ¤';

  @override
  String get homeFutureTitle =>
      'а¤­а¤µа¤їа¤·аҐЌа¤Ї а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤° repositories';

  @override
  String get homeNoRecentMessage =>
      'а¤•а¤їа¤ёаҐЂ а¤«а¤ја¤їа¤ІаҐЌа¤® а¤•аҐЂ а¤–аҐ‹а¤њ а¤ёаҐ‡ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚ а¤Їа¤ѕ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤…а¤Єа¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚, а¤†а¤Єа¤•аҐ‡ а¤№а¤ѕа¤І а¤•аҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤Їа¤№а¤ѕа¤Ѓ а¤¦а¤їа¤–аҐ‡а¤‚а¤—аҐ‡аҐ¤';

  @override
  String get homeNoRecentTitle =>
      'а¤…а¤­аҐЂ а¤•аҐ‹а¤€ а¤№а¤ѕа¤Іа¤їа¤Їа¤ѕ а¤њаҐ‰а¤¬ а¤Ёа¤№аҐЂа¤‚';

  @override
  String get homePreviewSubtitle =>
      'а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤ёаҐ‡ а¤Єа¤№а¤ІаҐ‡ а¤Єа¤°а¤їа¤Ја¤ѕа¤®аҐ‹а¤‚ а¤•аҐ‹ а¤®аҐ‚а¤І, а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤ а¤Їа¤ѕ а¤¦аҐЌа¤µа¤їа¤­а¤ѕа¤·аҐЂ а¤°аҐ‚а¤Є а¤®аҐ‡а¤‚ а¤¦аҐ‡а¤–аҐ‡а¤‚аҐ¤';

  @override
  String get homePreviewTitle =>
      'а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚-а¤•аҐ‡а¤‚а¤¦аҐЌа¤°а¤їа¤¤ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤«а¤јаҐЌа¤ІаҐ‹';

  @override
  String get homeQuickHistory => 'а¤‡а¤¤а¤їа¤№а¤ѕа¤ё';

  @override
  String get homeQuickSearch => 'а¤–аҐ‹а¤њ';

  @override
  String get homeQuickUpload => 'а¤…а¤Єа¤ІаҐ‹а¤Ў';

  @override
  String get homeRecentJobsSubtitle =>
      'а¤¶аҐЃа¤°аҐ‚ а¤ёаҐ‡ а¤¶аҐЃа¤°аҐ‚ а¤•а¤їа¤Џ а¤¬а¤їа¤Ёа¤ѕ а¤…а¤Єа¤ЁаҐЂ а¤¤а¤ѕа¤ња¤ја¤ѕ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐ‡а¤¶а¤Ё а¤«а¤їа¤° а¤–аҐ‹а¤ІаҐ‡а¤‚аҐ¤';

  @override
  String get homeRecentJobsTitle => 'а¤№а¤ѕа¤І а¤•аҐ‡ а¤њаҐ‰а¤¬';

  @override
  String get homeSearchPlaceholder =>
      'а¤«а¤ја¤їа¤ІаҐЌа¤®аҐ‡а¤‚ а¤Їа¤ѕ а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤–аҐ‹а¤њаҐ‡а¤‚...';

  @override
  String get homeStatesSubtitle =>
      'а¤ІаҐ‹а¤Ўа¤їа¤‚а¤—, а¤–а¤ѕа¤ІаҐЂ а¤ёаҐЌа¤Ґа¤їа¤¤а¤ї, retry, validation а¤”а¤° mock offline scenarios а¤¶аҐЃа¤°аҐ‚ а¤ёаҐ‡ а¤№аҐЂ UX а¤•а¤ѕ а¤№а¤їа¤ёаҐЌа¤ёа¤ѕ а¤№аҐ€а¤‚аҐ¤';

  @override
  String get homeStatesTitle =>
      'а¤ёа¤­аҐЂ а¤ња¤ја¤°аҐ‚а¤°аҐЂ states а¤¶а¤ѕа¤®а¤їа¤І';

  @override
  String get homeTrendingNow => 'а¤…а¤­аҐЂ а¤џаҐЌа¤°аҐ‡а¤‚а¤Ў а¤®аҐ‡а¤‚';

  @override
  String get homeTrustSubtitle =>
      'а¤†а¤њ а¤­а¤ІаҐ‡ а¤®аҐ‰а¤• а¤№аҐ‹, а¤ІаҐ‡а¤•а¤їа¤Ё а¤‡а¤ёаҐ‡ а¤…а¤ёа¤ІаҐЂ а¤ЄаҐЌа¤°аҐ‹а¤Ўа¤•аҐЌа¤џ а¤•аҐЂ а¤¤а¤°а¤№ а¤ёа¤‚а¤°а¤ља¤їа¤¤ а¤•а¤їа¤Їа¤ѕ а¤—а¤Їа¤ѕ а¤№аҐ€аҐ¤';

  @override
  String get homeTrustTitle =>
      'а¤џаҐЂа¤®аҐ‡а¤‚ а¤‡а¤ё а¤Єа¤° а¤­а¤°аҐ‹а¤ёа¤ѕ а¤•аҐЌа¤ЇаҐ‹а¤‚ а¤•а¤°а¤¤аҐЂ а¤№аҐ€а¤‚';

  @override
  String get homeViewAll => 'а¤ёа¤¬ а¤¦аҐ‡а¤–аҐ‡а¤‚';

  @override
  String get homeWelcomeSubtitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤–аҐ‹а¤њаҐ‡а¤‚ а¤”а¤° а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•а¤°аҐ‡а¤‚';

  @override
  String get homeWelcomeTitle => 'а¤«а¤їа¤° а¤ёаҐ‡ а¤ёаҐЌа¤µа¤ѕа¤—а¤¤ а¤№аҐ€';

  @override
  String jobConfidence(Object level) {
    return 'а¤µа¤їа¤¶аҐЌа¤µа¤ѕа¤ё а¤ёаҐЌа¤¤а¤°: $level';
  }

  @override
  String get jobOpenPreview => 'а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤–аҐ‹а¤ІаҐ‡а¤‚';

  @override
  String get jobReuseSubtitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤¦аҐ‹а¤¬а¤ѕа¤°а¤ѕ а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І а¤•а¤°аҐ‡а¤‚';

  @override
  String get jobReuseTranslation =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¦аҐ‹а¤¬а¤ѕа¤°а¤ѕ а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І а¤•а¤°аҐ‡а¤‚';

  @override
  String get legalBodyAbout =>
      'SubFlix AI а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤Џа¤• premium-style Flutter client а¤№аҐ€аҐ¤ а¤Їа¤№ build mock repositories, artificial latency а¤”а¤° local persistence а¤•а¤ѕ а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І а¤•а¤°а¤¤аҐЂ а¤№аҐ€ а¤¤а¤ѕа¤•а¤ї а¤…а¤ёа¤ІаҐЂ backend а¤њаҐЃа¤Ўа¤ја¤ЁаҐ‡ а¤ёаҐ‡ а¤Єа¤№а¤ІаҐ‡ UI а¤”а¤° architecture а¤µа¤їа¤•а¤ёа¤їа¤¤ а¤№аҐ‹ а¤ёа¤•аҐ‡а¤‚аҐ¤';

  @override
  String get legalBodyPrivacy =>
      'SubFlix а¤«а¤їа¤Іа¤№а¤ѕа¤І а¤•аҐ‡а¤µа¤І mock preferences а¤”а¤° translation history а¤•аҐ‹ local persistence а¤•аҐ‡ а¤ња¤°а¤їа¤Џ а¤Ўа¤їа¤µа¤ѕа¤‡а¤ё а¤Єа¤° а¤°а¤–а¤¤а¤ѕ а¤№аҐ€аҐ¤ а¤­а¤µа¤їа¤·аҐЌа¤Ї а¤®аҐ‡а¤‚ backend integration а¤‡а¤ёаҐ‡ authenticated storage, audit trails а¤”а¤° server-managed retention policies а¤ёаҐ‡ а¤¬а¤¦а¤І а¤ёа¤•а¤¤аҐЂ а¤№аҐ€аҐ¤';

  @override
  String get legalBodySupport =>
      'а¤…а¤­аҐЂ а¤•аҐ‡ а¤Іа¤їа¤Џ support а¤•аҐ‡а¤µа¤І а¤Џа¤• placeholder а¤№аҐ€аҐ¤ а¤ЄаҐЌа¤°аҐ‹а¤Ўа¤•аҐЌа¤¶а¤Ё а¤°а¤їа¤ІаҐЂа¤ња¤ј а¤®аҐ‡а¤‚ а¤Їа¤№ а¤ёаҐ‡а¤•аҐЌа¤¶а¤Ё а¤€а¤®аҐ‡а¤І, issue reporting а¤”а¤° premium account help а¤ёаҐ‡ а¤њаҐЃа¤Ўа¤ј а¤ёа¤•а¤¤а¤ѕ а¤№аҐ€, а¤¬а¤їа¤Ёа¤ѕ app shell а¤¬а¤¦а¤ІаҐ‡аҐ¤';

  @override
  String get legalBodyTerms =>
      'а¤Їа¤№ mock build а¤ЄаҐЌа¤°аҐ‹а¤Ўа¤•аҐЌа¤џ а¤«аҐЌа¤ІаҐ‹, UI states а¤”а¤° architecture boundaries а¤•аҐ‹ а¤Єа¤°а¤–а¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¬а¤Ёа¤ѕа¤€ а¤—а¤€ а¤№аҐ€аҐ¤ а¤ња¤¬ а¤¬а¤ѕа¤¦ а¤®аҐ‡а¤‚ production NestJS а¤”а¤° Postgres backend а¤њаҐЃа¤Ўа¤ј а¤ња¤ѕа¤Џа¤—а¤ѕ, а¤¤а¤¬ а¤•а¤ѕа¤ЁаҐ‚а¤ЁаҐЂ а¤№а¤їа¤ёаҐЌа¤ёаҐ‡ а¤•аҐ‹ а¤µа¤ѕа¤ёаҐЌа¤¤а¤µа¤їа¤• а¤ёаҐ‡а¤µа¤ѕ а¤¶а¤°аҐЌа¤¤аҐ‹а¤‚ а¤”а¤° data processing language а¤•аҐ‡ а¤ёа¤ѕа¤Ґ а¤¬а¤ўа¤ја¤ѕа¤Їа¤ѕ а¤ња¤ѕ а¤ёа¤•а¤¤а¤ѕ а¤№аҐ€аҐ¤';

  @override
  String get legalPlaceholderBody =>
      'а¤Їа¤№ а¤ЄаҐ‡а¤њ а¤ЎаҐ‡а¤®аҐ‹ а¤ђа¤Є а¤®аҐ‡а¤‚ а¤Џа¤• а¤ЄаҐЌа¤ІаҐ‡а¤ёа¤№аҐ‹а¤ІаҐЌа¤Ўа¤° а¤№аҐ€аҐ¤ а¤‡а¤ёаҐ‡ а¤…а¤Єа¤ЁаҐ‡ а¤ЄаҐЌа¤°аҐ‹а¤Ўа¤•аҐЌа¤¶а¤Ё а¤•а¤ѕа¤ЁаҐ‚а¤ЁаҐЂ а¤•а¤‚а¤џаҐ‡а¤‚а¤џ а¤ёаҐ‡ а¤њаҐ‹а¤Ўа¤јаҐ‡а¤‚аҐ¤';

  @override
  String get legalTitleAbout => 'SubFlix а¤•аҐ‡ а¤¬а¤ѕа¤°аҐ‡ а¤®аҐ‡а¤‚';

  @override
  String get legalTitlePrivacy => 'а¤—аҐ‹а¤Єа¤ЁаҐЂа¤Їа¤¤а¤ѕ а¤ЁаҐЂа¤¤а¤ї';

  @override
  String get legalTitleSupport => 'а¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ';

  @override
  String get legalTitleTerms => 'а¤ёаҐ‡а¤µа¤ѕ а¤•аҐЂ а¤¶а¤°аҐЌа¤¤аҐ‡а¤‚';

  @override
  String get mediaTypeMovie => 'а¤«а¤ја¤їа¤ІаҐЌа¤®';

  @override
  String get mediaTypeSeries => 'а¤ёаҐЂа¤°аҐЂа¤ња¤ј';

  @override
  String get metadataEstimatedDuration =>
      'а¤…а¤ЁаҐЃа¤®а¤ѕа¤Ёа¤їа¤¤ а¤…а¤µа¤§а¤ї';

  @override
  String get metadataFormat => 'а¤«а¤јаҐ‰а¤°аҐЌа¤®аҐ€а¤џ';

  @override
  String get metadataLanguages => 'а¤­а¤ѕа¤·а¤ѕа¤Џа¤Ѓ';

  @override
  String get metadataLines => 'а¤Єа¤‚а¤•аҐЌа¤¤а¤їа¤Їа¤ѕа¤Ѓ';

  @override
  String get navHistory => 'а¤‡а¤¤а¤їа¤№а¤ѕа¤ё';

  @override
  String get navHome => 'а¤№аҐ‹а¤®';

  @override
  String get navSettings => 'а¤ёаҐ‡а¤џа¤їа¤‚а¤—аҐЌа¤ё';

  @override
  String get noTitlesMatchedMessage =>
      'а¤№а¤®аҐ‡а¤‚ а¤Їа¤№ а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤®аҐ‰а¤• а¤•аҐ€а¤џа¤ІаҐ‰а¤— а¤®аҐ‡а¤‚ а¤Ёа¤№аҐЂа¤‚ а¤®а¤їа¤Іа¤ѕаҐ¤ а¤ҐаҐ‹а¤Ўа¤ја¤ѕ а¤µаҐЌа¤Їа¤ѕа¤Єа¤• а¤–аҐ‹а¤њаҐ‡а¤‚ а¤Їа¤ѕ а¤ёаҐЃа¤ќа¤ѕа¤Џ а¤—а¤Џ а¤¶аҐЂа¤°аҐЌа¤·а¤•аҐ‹а¤‚ а¤®аҐ‡а¤‚ а¤ёаҐ‡ а¤•аҐ‹а¤€ а¤љаҐЃа¤ЁаҐ‡а¤‚аҐ¤';

  @override
  String get noTitlesMatchedTitle =>
      'а¤•аҐ‹а¤€ а¤®а¤їа¤Іа¤ѕа¤Ё а¤Ёа¤№аҐЂа¤‚ а¤®а¤їа¤Іа¤ѕ';

  @override
  String get onboardingContinue => 'а¤ња¤ѕа¤°аҐЂ а¤°а¤–аҐ‡а¤‚';

  @override
  String get onboardingEnterApp =>
      'SubFlix а¤®аҐ‡а¤‚ а¤ЄаҐЌа¤°а¤µаҐ‡а¤¶ а¤•а¤°аҐ‡а¤‚';

  @override
  String get onboardingNext => 'а¤…а¤—а¤Іа¤ѕ';

  @override
  String get onboardingPage1Description =>
      'а¤•аҐ‹а¤€ а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤–аҐ‹а¤њаҐ‡а¤‚, а¤‰а¤Єа¤Іа¤¬аҐЌа¤§ а¤…а¤‚а¤—аҐЌа¤°аҐ‡а¤ња¤јаҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° а¤ђа¤ёа¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤«а¤јаҐЌа¤ІаҐ‹ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚ а¤њаҐ‹ а¤¤аҐЃа¤°а¤‚а¤¤ а¤®а¤№а¤ёаҐ‚а¤ё а¤№аҐ‹аҐ¤';

  @override
  String get onboardingPage1Eyebrow => 'а¤–аҐ‹а¤њаҐ‡а¤‚ а¤”а¤° а¤Іа¤ѕа¤Џа¤Ѓ';

  @override
  String get onboardingPage1Highlight1 =>
      'а¤µа¤їа¤¶аҐЌа¤µа¤ёа¤ЁаҐЂа¤Ї а¤µа¤їа¤•а¤ѕа¤ё а¤•аҐ‡ а¤Іа¤їа¤Џ deterministic mock catalog';

  @override
  String get onboardingPage1Highlight2 =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ quality labels а¤”а¤° format badges';

  @override
  String get onboardingPage1Highlight3 =>
      'а¤¬а¤ѕа¤¦ а¤®аҐ‡а¤‚ а¤…а¤ёа¤ІаҐЂ backend а¤ёаҐ‡ а¤њаҐ‹а¤Ўа¤ја¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤°';

  @override
  String get onboardingPage1Title =>
      'а¤«а¤ја¤їа¤ІаҐЌа¤®аҐ‡а¤‚ а¤Їа¤ѕ а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤ўаҐ‚а¤Ѓа¤ўаҐ‡а¤‚ а¤”а¤° а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤° а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Єа¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get onboardingPage2Description =>
      'а¤…а¤Єа¤ЁаҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤‡а¤®аҐЌа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚, а¤«а¤јаҐ‰а¤°аҐЌа¤®аҐ€а¤џ а¤µаҐ€а¤Іа¤їа¤ЎаҐ‡а¤џ а¤•а¤°аҐ‡а¤‚ а¤”а¤° а¤ђа¤Є а¤›аҐ‹а¤Ўа¤јаҐ‡ а¤¬а¤їа¤Ёа¤ѕ а¤µа¤№аҐЂ polished translation pipeline а¤ља¤Іа¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get onboardingPage2Eyebrow =>
      'а¤…а¤Єа¤ЁаҐЂ а¤«а¤ја¤ѕа¤‡а¤І а¤Іа¤ѕа¤Џа¤Ѓ';

  @override
  String get onboardingPage2Highlight1 =>
      'а¤ІаҐ‹а¤•а¤І а¤«а¤ја¤ѕа¤‡а¤І а¤µаҐ€а¤Іа¤їа¤ЎаҐ‡а¤¶а¤Ё а¤”а¤° а¤ёа¤№а¤њ retry states';

  @override
  String get onboardingPage2Highlight2 =>
      'а¤…а¤Єа¤ІаҐ‹а¤Ў а¤”а¤° а¤–аҐ‹а¤њ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤Џа¤•а¤ёа¤®а¤ѕа¤Ё translation setup';

  @override
  String get onboardingPage2Highlight3 =>
      'а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤ёаҐ‡ а¤Єа¤№а¤ІаҐ‡ а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚, а¤¤а¤ѕа¤•а¤ї а¤•аҐЃа¤› а¤­аҐЂ а¤§аҐЃа¤‚а¤§а¤Іа¤ѕ а¤Ё а¤Іа¤—аҐ‡';

  @override
  String get onboardingPage2Title =>
      'а¤ња¤¬ а¤ёаҐЌа¤•аҐЌа¤°а¤їа¤ЄаҐЌа¤џ а¤†а¤Єа¤•аҐ‡ а¤Єа¤ѕа¤ё а¤№аҐ‹, а¤¤а¤¬ `.srt` а¤Їа¤ѕ `.vtt` а¤«а¤ја¤ѕа¤‡а¤ІаҐ‡а¤‚ а¤…а¤Єа¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get onboardingPage3Description =>
      'а¤®аҐ‚а¤І, а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤ а¤”а¤° а¤¦аҐЌа¤µа¤їа¤­а¤ѕа¤·аҐЂ а¤¦аҐѓа¤¶аҐЌа¤Ї а¤®аҐ‡а¤‚ а¤¬а¤¦а¤ІаҐ‡а¤‚, а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤«а¤їа¤° а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° а¤ња¤¬ а¤Єа¤°а¤їа¤Ја¤ѕа¤® а¤ёа¤№аҐЂ а¤Іа¤—аҐ‡ а¤¤а¤¬ а¤ёа¤ѕа¤«а¤ј-а¤ёаҐЃа¤Ґа¤°аҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤ІаҐ‡а¤‚ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get onboardingPage3Eyebrow =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤”а¤° а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ';

  @override
  String get onboardingPage3Highlight1 =>
      'а¤®аҐ‡а¤џа¤ѕа¤ЎаҐ‡а¤џа¤ѕ а¤”а¤° а¤–аҐ‹а¤њ а¤•аҐ‡ а¤ёа¤ѕа¤Ґ а¤¤аҐ‡а¤ња¤ј а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤Ёа¤їа¤Їа¤‚а¤¤аҐЌа¤°а¤Ј';

  @override
  String get onboardingPage3Highlight2 =>
      'а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤ЄаҐЃа¤°а¤ѕа¤ЁаҐ‡ а¤њаҐ‰а¤¬ а¤•аҐ‹ а¤¬а¤ё а¤Џа¤• а¤џаҐ€а¤Є а¤¦аҐ‚а¤° а¤°а¤–а¤¤а¤ѕ а¤№аҐ€';

  @override
  String get onboardingPage3Highlight3 =>
      'а¤ЎаҐ‡а¤®аҐ‹ а¤Ёа¤№аҐЂа¤‚, а¤Џа¤• а¤ЄаҐЌа¤°аҐЂа¤®а¤їа¤Їа¤® а¤®аҐЂа¤Ўа¤їа¤Їа¤ѕ а¤џаҐ‚а¤І а¤њаҐ€а¤ёа¤ѕ а¤Ўа¤їа¤ња¤ја¤ѕа¤‡а¤Ё';

  @override
  String get onboardingPage3Title =>
      'а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕа¤Џа¤Ѓ а¤љаҐЃа¤ЁаҐ‡а¤‚, а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° а¤¤аҐЃа¤°а¤‚а¤¤ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get onboardingSkip => 'а¤›аҐ‹а¤Ўа¤јаҐ‡а¤‚';

  @override
  String get onboardingStart => 'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚';

  @override
  String get previewFailedTitle =>
      'а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤ІаҐ‹а¤Ў а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•а¤ѕ';

  @override
  String get previewModeBilingual => 'а¤¦аҐЌа¤µа¤їа¤­а¤ѕа¤·аҐЂ';

  @override
  String get previewModeOriginal => 'а¤®аҐ‚а¤І';

  @override
  String get previewModeTranslated => 'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤';

  @override
  String get previewNoMatchesMessage =>
      'а¤•аҐ‹а¤€ а¤¦аҐ‚а¤ёа¤°а¤ѕ а¤–аҐ‹а¤њ а¤¶а¤¬аҐЌа¤¦ а¤†а¤ња¤ја¤®а¤ѕа¤Џа¤Ѓ а¤Їа¤ѕ а¤ЄаҐ‚а¤°а¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¦аҐ‡а¤–а¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤«а¤ја¤їа¤ІаҐЌа¤џа¤° а¤№а¤џа¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get previewNoMatchesTitle =>
      'а¤•аҐ‹а¤€ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Єа¤‚а¤•аҐЌа¤¤а¤ї а¤®аҐ‡а¤І а¤Ёа¤№аҐЂа¤‚ а¤–а¤ѕа¤€';

  @override
  String get previewNotReadyMessage =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐ‚а¤°а¤ѕ а¤№аҐ‹ а¤—а¤Їа¤ѕ, а¤ІаҐ‡а¤•а¤їа¤Ё а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў а¤ЁаҐ‡ а¤…а¤­аҐЂ а¤¤а¤• а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ cues а¤Ёа¤№аҐЂа¤‚ а¤­аҐ‡а¤њаҐ‡аҐ¤ а¤Џа¤• а¤•аҐЌа¤·а¤Ј а¤¬а¤ѕа¤¦ а¤Їа¤№ а¤ёаҐЌа¤•аҐЌа¤°аҐЂа¤Ё а¤«а¤їа¤° а¤ёаҐ‡ а¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get previewNotReadyTitle =>
      'а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ cues а¤…а¤­аҐЂ а¤‰а¤Єа¤Іа¤¬аҐЌа¤§ а¤Ёа¤№аҐЂа¤‚ а¤№аҐ€а¤‚';

  @override
  String get retry => 'а¤«а¤їа¤° а¤ёаҐ‡ а¤ЄаҐЌа¤°а¤Їа¤ѕа¤ё а¤•а¤°аҐ‡а¤‚';

  @override
  String get retryTranslation =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤«а¤їа¤° а¤ёаҐ‡ а¤•а¤°аҐ‡а¤‚';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'а¤№а¤® а¤¤а¤Ї а¤Ёа¤№аҐЂа¤‚ а¤•а¤° а¤ёа¤•аҐ‡ а¤•а¤ї а¤•аҐЊа¤Ё-а¤ёа¤ѕ а¤ёаҐЂа¤ња¤ја¤Ё а¤ІаҐ‹а¤Ў а¤•а¤°а¤Ёа¤ѕ а¤№аҐ€аҐ¤ а¤–аҐ‹а¤њ а¤ёаҐ‡ а¤«а¤їа¤° а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get routeMissingSeasonEpisodesTitle =>
      'а¤ёаҐЂа¤ња¤ја¤Ё а¤Џа¤Єа¤їа¤ёаҐ‹а¤Ў';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'а¤№а¤® а¤¤а¤Ї а¤Ёа¤№аҐЂа¤‚ а¤•а¤° а¤ёа¤•аҐ‡ а¤•а¤ї а¤•аҐЊа¤Ё-а¤ёаҐЂ а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤ІаҐ‹а¤Ў а¤•а¤°а¤ЁаҐЂ а¤№аҐ€аҐ¤ а¤–аҐ‹а¤њ а¤ёаҐ‡ а¤«а¤їа¤° а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get routeMissingSeriesSeasonsTitle =>
      'а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤ёаҐЂа¤ња¤ја¤Ё';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'а¤№а¤® а¤¤а¤Ї а¤Ёа¤№аҐЂа¤‚ а¤•а¤° а¤ёа¤•аҐ‡ а¤•а¤ї а¤•а¤їа¤ё а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤•аҐ‡ а¤Іа¤їа¤Џ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤ІаҐ‹а¤Ў а¤•а¤°а¤ЁаҐ‡ а¤№аҐ€а¤‚аҐ¤ а¤–аҐ‹а¤њ а¤ёаҐ‡ а¤«а¤їа¤° а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get routeMissingSubtitleSourcesTitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤';

  @override
  String get routeMissingTranslationProgressMessage =>
      'а¤•аҐ‹а¤€ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤…а¤ЁаҐЃа¤°аҐ‹а¤§ а¤Ёа¤№аҐЂа¤‚ а¤¦а¤їа¤Їа¤ѕ а¤—а¤Їа¤ѕаҐ¤ а¤–аҐ‹а¤њ а¤Їа¤ѕ а¤…а¤Єа¤ІаҐ‹а¤Ў а¤ёаҐ‡ а¤Ёа¤Їа¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get routeMissingTranslationProgressTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐЌа¤°а¤—а¤¤а¤ї';

  @override
  String get routeMissingTranslationSetupMessage =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є а¤ёаҐЌа¤•аҐЌа¤°аҐЂа¤Ё а¤–аҐ‹а¤Іа¤ЁаҐ‡ а¤ёаҐ‡ а¤Єа¤№а¤ІаҐ‡ а¤Џа¤• а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤ња¤ја¤°аҐ‚а¤°аҐЂ а¤№аҐ€аҐ¤';

  @override
  String get routeMissingTranslationSetupTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є';

  @override
  String get searchFailedTitle => 'а¤–аҐ‹а¤њ а¤…а¤ёа¤«а¤І а¤°а¤№аҐЂ';

  @override
  String searchFoundResults(Object count, Object query) {
    return '\"$query\" а¤•аҐ‡ а¤Іа¤їа¤Џ $count а¤Єа¤°а¤їа¤Ја¤ѕа¤® а¤®а¤їа¤ІаҐ‡';
  }

  @override
  String get searchHintText =>
      'Dune, Breaking Bad, Severance а¤–аҐ‹а¤њаҐ‡а¤‚...';

  @override
  String get searchLoadingLabel => 'а¤–аҐ‹а¤њ а¤ња¤ѕа¤°аҐЂ а¤№аҐ€...';

  @override
  String get searchMockMessage =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤аҐ‹а¤‚ а¤•а¤ѕ а¤«а¤јаҐЌа¤ІаҐ‹ а¤¦аҐ‡а¤–а¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ Inception, Dune, Breaking Bad, Severance а¤Їа¤ѕ The Last of Us а¤њаҐ€а¤ёаҐ‡ а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤†а¤ња¤ја¤®а¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get searchMockTitle =>
      'а¤®аҐ‰а¤• а¤•аҐ€а¤џа¤ІаҐ‰а¤— а¤®аҐ‡а¤‚ а¤•аҐЃа¤› а¤­аҐЂ а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'а¤•аҐ‹а¤€ а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤ўаҐ‚а¤Ѓа¤ўаҐ‡а¤‚, а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° а¤•аҐЃа¤› а¤џаҐ€а¤Є а¤®аҐ‡а¤‚ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get searchMovieOrSeriesTitle =>
      'а¤«а¤ја¤їа¤ІаҐЌа¤® а¤Їа¤ѕ а¤ёаҐЂа¤°аҐЂа¤ња¤ј а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String searchNoResultsFor(Object query) {
    return '\"$query\" а¤•аҐ‡ а¤Іа¤їа¤Џ а¤•аҐ‹а¤€ а¤Єа¤°а¤їа¤Ја¤ѕа¤® а¤Ёа¤№аҐЂа¤‚ а¤®а¤їа¤Іа¤ѕ';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'а¤ІаҐ‹а¤•а¤ЄаҐЌа¤°а¤їа¤Їа¤¤а¤ѕ $score';
  }

  @override
  String get searchTitles => 'а¤¶аҐЂа¤°аҐЌа¤·а¤• а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String get searchTrendingTitle =>
      'а¤џаҐЌа¤°аҐ‡а¤‚а¤Ўа¤їа¤‚а¤— а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String get searchTryDifferentKeywords =>
      'а¤•аҐЃа¤› а¤…а¤Іа¤— а¤•аҐЂа¤µа¤°аҐЌа¤ЎаҐЌа¤ё а¤†а¤ња¤ја¤®а¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'а¤Џа¤Єа¤їа¤ёаҐ‹а¤Ў $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'а¤Іа¤—а¤­а¤— $runtime а¤®а¤їа¤Ёа¤џ';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount а¤Џа¤Єа¤їа¤ёаҐ‹а¤Ў$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'а¤ёаҐЂа¤ња¤ја¤Ё $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'а¤ёаҐЂа¤ња¤ја¤Ё $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount а¤Џа¤Єа¤їа¤ёаҐ‹а¤Ў$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'а¤‰а¤Єа¤Іа¤¬аҐЌа¤§ а¤Џа¤Єа¤їа¤ёаҐ‹а¤Ў а¤¦аҐ‡а¤–а¤ЁаҐ‡ а¤•аҐ‡ а¤Іа¤їа¤Џ $title а¤•а¤ѕ а¤Џа¤• а¤ёаҐЂа¤ња¤ја¤Ё а¤љаҐЃа¤ЁаҐ‡а¤‚аҐ¤';
  }

  @override
  String get seriesSeasonsTitle => 'а¤Џа¤• а¤ёаҐЂа¤ња¤ја¤Ё а¤љаҐЃа¤ЁаҐ‡а¤‚';

  @override
  String get settingsAboutTitle => 'SubFlix а¤•аҐ‡ а¤¬а¤ѕа¤°аҐ‡ а¤®аҐ‡а¤‚';

  @override
  String get settingsCacheCleared => 'а¤•аҐ€а¤¶ а¤ёа¤ѕа¤«а¤ј а¤№аҐ‹ а¤—а¤Їа¤ѕ';

  @override
  String get settingsClearCache => 'а¤•аҐ€а¤¶ а¤ёа¤ѕа¤«а¤ј а¤•а¤°аҐ‡а¤‚';

  @override
  String get settingsContactTitle =>
      'а¤№а¤®а¤ёаҐ‡ а¤ёа¤‚а¤Єа¤°аҐЌа¤• а¤•а¤°аҐ‡а¤‚';

  @override
  String get settingsFailedTitle =>
      'а¤ёаҐ‡а¤џа¤їа¤‚а¤—аҐЌа¤ё а¤ІаҐ‹а¤Ў а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•аҐЂа¤‚';

  @override
  String get settingsHelpCenterTitle => 'а¤ёа¤№а¤ѕа¤Їа¤¤а¤ѕ а¤•аҐ‡а¤‚а¤¦аҐЌа¤°';

  @override
  String get settingsHistoryClearedSnack =>
      'а¤‡а¤ё а¤Ўа¤їа¤µа¤ѕа¤‡а¤ё а¤•а¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤ёа¤ѕа¤«а¤ј а¤•а¤° а¤¦а¤їа¤Їа¤ѕ а¤—а¤Їа¤ѕ';

  @override
  String get settingsLanguageLabel =>
      'а¤Єа¤ёа¤‚а¤¦аҐЂа¤¦а¤ѕ а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕ';

  @override
  String get settingsMaintenanceSubtitle =>
      'а¤‡а¤ё а¤Ўа¤їа¤µа¤ѕа¤‡а¤ё а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў-а¤ёаҐЌа¤µа¤ѕа¤®а¤їа¤¤аҐЌа¤µ а¤µа¤ѕа¤ІаҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤њаҐ‰а¤¬ а¤ёа¤ѕа¤«а¤ј а¤•а¤°аҐ‡а¤‚ а¤”а¤° а¤–а¤ѕа¤ІаҐЂ а¤‡а¤¤а¤їа¤№а¤ѕа¤ё а¤ёаҐ‡ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get settingsMaintenanceTitle => 'а¤°а¤–а¤°а¤–а¤ѕа¤µ';

  @override
  String get settingsNotificationsSubtitle =>
      'а¤ёаҐ‚а¤ља¤Ёа¤ѕ а¤ЄаҐЌа¤°а¤ѕа¤Ґа¤®а¤їа¤•а¤¤а¤ѕа¤Џа¤Ѓ а¤ЄаҐЌа¤°а¤¬а¤‚а¤§а¤їа¤¤ а¤•а¤°аҐ‡а¤‚';

  @override
  String get settingsNotificationsTitle => 'а¤ёаҐ‚а¤ља¤Ёа¤ѕа¤Џа¤Ѓ';

  @override
  String get settingsPremiumSubtitle =>
      'а¤†а¤—аҐ‡ а¤ља¤Іа¤•а¤° а¤№а¤® а¤Їа¤№а¤ѕа¤Ѓ а¤ёа¤¬аҐЌа¤ёа¤•аҐЌа¤°а¤їа¤ЄаҐЌа¤¶а¤Ё, а¤¬а¤їа¤Іа¤їа¤‚а¤— а¤”а¤° а¤•аҐЌа¤Іа¤ѕа¤‰а¤Ў а¤ЄаҐЌа¤°аҐ‹а¤њаҐ‡а¤•аҐЌа¤џ а¤ёа¤їа¤‚а¤• а¤њаҐ‹а¤Ўа¤ј а¤ёа¤•а¤¤аҐ‡ а¤№аҐ€а¤‚аҐ¤';

  @override
  String get settingsPremiumTitle =>
      'а¤ЄаҐЌа¤°аҐЂа¤®а¤їа¤Їа¤® а¤ЄаҐЌа¤ІаҐ‡а¤ёа¤№аҐ‹а¤ІаҐЌа¤Ўа¤°';

  @override
  String get settingsPrivacySubtitle =>
      'а¤®аҐ‰а¤• а¤—аҐ‹а¤Єа¤ЁаҐЂа¤Їа¤¤а¤ѕ а¤ёа¤ѕа¤®а¤—аҐЌа¤°аҐЂ';

  @override
  String get settingsPrivacyTitle => 'а¤—аҐ‹а¤Єа¤ЁаҐЂа¤Їа¤¤а¤ѕ а¤ЁаҐЂа¤¤а¤ї';

  @override
  String get settingsProfileName => 'SubFlix а¤‰а¤Єа¤ЇаҐ‹а¤—а¤•а¤°аҐЌа¤¤а¤ѕ';

  @override
  String get settingsProfileTier => 'а¤ЄаҐЌа¤°аҐЂа¤®а¤їа¤Їа¤® а¤ёа¤¦а¤ёаҐЌа¤Ї';

  @override
  String get settingsSubtitle =>
      'а¤…а¤Єа¤ЁаҐЂ а¤Єа¤ёа¤‚а¤¦ а¤ЄаҐЌа¤°а¤¬а¤‚а¤§а¤їа¤¤ а¤•а¤°аҐ‡а¤‚';

  @override
  String get settingsSupportSubtitle =>
      'а¤®аҐ‰а¤• а¤ёа¤№а¤ѕа¤Їа¤¤а¤ѕ а¤”а¤° а¤ёа¤‚а¤Єа¤°аҐЌа¤• а¤ЄаҐ‡а¤њ';

  @override
  String get settingsSupportTitle =>
      'а¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤ЄаҐЌа¤ІаҐ‡а¤ёа¤№аҐ‹а¤ІаҐЌа¤Ўа¤°';

  @override
  String get settingsTermsSubtitle =>
      'а¤®аҐ‰а¤• а¤¶а¤°аҐЌа¤¤аҐ‡а¤‚ а¤ёа¤ѕа¤®а¤—аҐЌа¤°аҐЂ';

  @override
  String get settingsTermsTitle => 'а¤ёаҐ‡а¤µа¤ѕ а¤•аҐЂ а¤¶а¤°аҐЌа¤¤аҐ‡а¤‚';

  @override
  String get settingsThemeLabel => 'а¤¦а¤їа¤–а¤ѕа¤µа¤џ';

  @override
  String get settingsTitle => 'а¤ёаҐ‡а¤џа¤їа¤‚а¤—аҐЌа¤ё';

  @override
  String settingsVersion(Object version) {
    return 'а¤ёа¤‚а¤ёаҐЌа¤•а¤°а¤Ј $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing =>
      'а¤†а¤Єа¤•а¤ѕ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤џаҐ‚а¤Ўа¤їа¤ЇаҐ‹ а¤¤аҐ€а¤Їа¤ѕа¤° а¤•а¤їа¤Їа¤ѕ а¤ња¤ѕ а¤°а¤№а¤ѕ а¤№аҐ€';

  @override
  String get splashSubtitle =>
      'AI-а¤ёа¤‚а¤ља¤ѕа¤Іа¤їа¤¤ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦';

  @override
  String get startTranslation => 'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads а¤Ўа¤ѕа¤‰а¤Ёа¤ІаҐ‹а¤Ў';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount а¤Єа¤‚а¤•аҐЌа¤¤а¤їа¤Їа¤ѕа¤Ѓ';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'а¤°аҐ‡а¤џа¤їа¤‚а¤— $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'а¤Џа¤• а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤љаҐЃа¤ЁаҐ‡а¤‚ а¤”а¤° а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤•аҐ‡ а¤Іа¤їа¤Џ а¤…а¤ЁаҐЃа¤•аҐ‚а¤Іа¤їа¤¤, polished а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є а¤Єа¤° а¤†а¤—аҐ‡ а¤¬а¤ўа¤јаҐ‡а¤‚аҐ¤';

  @override
  String get subtitleSourcesBannerTitle =>
      'AI а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤‰а¤Єа¤Іа¤¬аҐЌа¤§ а¤№аҐ€';

  @override
  String get subtitleSourcesFailedTitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤ІаҐ‹а¤Ў а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•аҐ‡';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return '$title$target а¤•аҐ‡ а¤Іа¤їа¤Џ а¤Џа¤• а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤љаҐЃа¤ЁаҐ‡а¤‚, а¤«а¤їа¤° а¤…а¤—а¤ІаҐ‡ а¤ља¤°а¤Ј а¤®аҐ‡а¤‚ а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕ а¤љаҐЃа¤ЁаҐ‡а¤‚аҐ¤';
  }

  @override
  String get subtitleSourcesTitle =>
      'а¤…а¤‚а¤—аҐЌа¤°аҐ‡а¤ња¤јаҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤';

  @override
  String get targetLanguage => 'а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕ';

  @override
  String get themeDark => 'а¤Ўа¤ѕа¤°аҐЌа¤•';

  @override
  String get themeLight => 'а¤Іа¤ѕа¤‡а¤џ';

  @override
  String get themeSystem => 'а¤ёа¤їа¤ёаҐЌа¤џа¤®';

  @override
  String get translateSetupAutoDetect =>
      'а¤«а¤јаҐ‰а¤°аҐЌа¤®аҐ€а¤џ а¤ёаҐЌа¤µа¤¤а¤ѓ а¤Єа¤№а¤ља¤ѕа¤ЁаҐ‡а¤‚';

  @override
  String get translateSetupAutoDetectBody =>
      'а¤ёа¤№аҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤†а¤‰а¤џа¤ЄаҐЃа¤џ а¤ёа¤‚а¤°а¤ља¤Ёа¤ѕ а¤…а¤Єа¤ЁаҐ‡ а¤†а¤Є а¤љаҐЃа¤ЁаҐ‡а¤‚аҐ¤';

  @override
  String get translateSetupLanguageTitle => 'а¤•а¤їа¤ё а¤­а¤ѕа¤·а¤ѕ а¤®аҐ‡а¤‚';

  @override
  String get translateSetupOptionsTitle => 'а¤µа¤їа¤•а¤ІаҐЌа¤Є';

  @override
  String get translateSetupPreserveTiming =>
      'а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤ёаҐЃа¤°а¤•аҐЌа¤·а¤їа¤¤ а¤°а¤–аҐ‡а¤‚';

  @override
  String get translateSetupPreserveTimingBody =>
      'а¤®аҐ‚а¤І а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤•аҐ‹ а¤ёаҐЌа¤°аҐ‹а¤¤ а¤«а¤ја¤ѕа¤‡а¤І а¤•аҐ‡ а¤ёа¤ѕа¤Ґ а¤®а¤їа¤Іа¤ѕа¤•а¤° а¤°а¤–аҐ‡а¤‚аҐ¤';

  @override
  String translateSetupReadyBody(Object language) {
    return 'а¤№а¤®а¤ѕа¤°а¤ѕ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤«а¤јаҐЌа¤ІаҐ‹ а¤‡а¤ё а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤•аҐ‹ $language а¤®аҐ‡а¤‚ а¤¬а¤¦а¤ІаҐ‡а¤—а¤ѕ, а¤ёа¤ѕа¤Ґ а¤№аҐЂ а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤”а¤° cue а¤ёа¤‚а¤°а¤ља¤Ёа¤ѕ а¤•аҐ‹ а¤ёа¤ѕа¤«а¤ј-а¤ёаҐЃа¤Ґа¤°а¤ѕ а¤¬а¤Ёа¤ѕа¤Џ а¤°а¤–аҐ‡а¤—а¤ѕаҐ¤';
  }

  @override
  String get translateSetupReadyTitle =>
      'AI а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¤аҐ€а¤Їа¤ѕа¤° а¤№аҐ€';

  @override
  String get translateSetupSelectLanguage => 'а¤­а¤ѕа¤·а¤ѕ а¤љаҐЃа¤ЁаҐ‡а¤‚';

  @override
  String get translateSetupSourceTitle =>
      'а¤ёаҐЌа¤°аҐ‹а¤¤ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І';

  @override
  String get translateSetupSubtitle =>
      'а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕ а¤љаҐЃа¤ЁаҐ‡а¤‚, а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ёаҐЌа¤°аҐ‹а¤¤ а¤¦аҐ‡а¤–аҐ‡а¤‚ а¤”а¤° а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤њаҐ‰а¤¬ а¤¶аҐЃа¤°аҐ‚ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get translateSetupTitle => 'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є';

  @override
  String get translationFailedMessage =>
      'а¤•аҐЃа¤› а¤—а¤Ўа¤ја¤¬а¤Ўа¤ј а¤№аҐ‹ а¤—а¤€аҐ¤';

  @override
  String get translationFailedTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐ‚а¤°а¤ѕ а¤Ёа¤№аҐЂа¤‚ а¤№аҐ‹ а¤ёа¤•а¤ѕ';

  @override
  String get translationPreviewHeader =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤¦аҐ‡а¤–аҐ‡а¤‚';

  @override
  String get translationPreviewSearchHint =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Єа¤‚а¤•аҐЌа¤¤а¤їа¤Їа¤ѕа¤Ѓ а¤–аҐ‹а¤њаҐ‡а¤‚';

  @override
  String get translationPreviewSubtitle =>
      'cues а¤•аҐ‡ а¤…а¤‚а¤¦а¤° а¤–аҐ‹а¤њаҐ‡а¤‚, а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤®аҐ‹а¤Ў а¤¬а¤¦а¤ІаҐ‡а¤‚ а¤”а¤° а¤ња¤¬ а¤Єа¤°а¤їа¤Ја¤ѕа¤® а¤ёа¤№аҐЂ а¤Іа¤—аҐ‡ а¤¤а¤¬ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚аҐ¤';

  @override
  String get translationPreviewTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚';

  @override
  String get translationProgressHeadline =>
      'AI а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ња¤ѕа¤°аҐЂ а¤№аҐ€';

  @override
  String get translationProgressTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐЌа¤°а¤—а¤¤а¤ї';

  @override
  String get translationResultCompleteSubtitle =>
      'а¤†а¤Єа¤•а¤ѕ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤¬ а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚ а¤Їа¤ѕ а¤Ўа¤ѕа¤‰а¤Ёа¤ІаҐ‹а¤Ў а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤° а¤№аҐ€аҐ¤';

  @override
  String get translationResultCompleteTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ЄаҐ‚а¤°а¤ѕ а¤№аҐЃа¤†';

  @override
  String get translationResultConfidenceLabel =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤µа¤їа¤¶аҐЌа¤µа¤ёа¤ЁаҐЂа¤Їа¤¤а¤ѕ';

  @override
  String get translationResultDetailsTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤µа¤їа¤µа¤°а¤Ј';

  @override
  String get translationResultDownloadCta =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤Ўа¤ѕа¤‰а¤Ёа¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚';

  @override
  String get translationResultHomeCta =>
      'а¤№аҐ‹а¤® а¤Єа¤° а¤µа¤ѕа¤Єа¤ё а¤ња¤ѕа¤Џа¤Ѓ';

  @override
  String get translationResultMediaLabel =>
      'а¤®аҐЂа¤Ўа¤їа¤Їа¤ѕ а¤¶аҐЂа¤°аҐЌа¤·а¤•';

  @override
  String get translationResultMethodAi => 'AI а¤ёаҐ‡ а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦а¤їа¤¤';

  @override
  String get translationResultMetricsTitle =>
      'а¤—аҐЃа¤Ја¤µа¤¤аҐЌа¤¤а¤ѕ а¤®аҐ‡а¤џаҐЌа¤°а¤їа¤•аҐЌа¤ё';

  @override
  String get translationResultPreviewCta =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ЄаҐЌа¤°аҐЂа¤µаҐЌа¤ЇаҐ‚';

  @override
  String translationResultProcessedIn(Object duration) {
    return '$duration а¤®аҐ‡а¤‚ а¤ЄаҐЌа¤°аҐ‹а¤ёаҐ‡а¤ё а¤№аҐЃа¤†';
  }

  @override
  String get translationResultSourceLabel => 'а¤ёаҐЌа¤°аҐ‹а¤¤ а¤­а¤ѕа¤·а¤ѕ';

  @override
  String get translationResultTargetLabel => 'а¤Іа¤•аҐЌа¤·а¤їа¤¤ а¤­а¤ѕа¤·а¤ѕ';

  @override
  String get translationResultTimingLabel =>
      'а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤ёа¤џаҐЂа¤•а¤¤а¤ѕ';

  @override
  String get translationResultTimingPreserved =>
      'а¤џа¤ѕа¤‡а¤®а¤їа¤‚а¤— а¤ёаҐЃа¤°а¤•аҐЌа¤·а¤їа¤¤ а¤°а¤–аҐЂ а¤—а¤€';

  @override
  String get translationResultWarning =>
      'а¤•аҐЃа¤› а¤¤а¤•а¤ЁаҐЂа¤•аҐЂ а¤¶а¤¬аҐЌа¤¦аҐ‹а¤‚ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤ёа¤‚а¤¦а¤°аҐЌа¤­ а¤•аҐ‡ а¤№а¤їа¤ёа¤ѕа¤¬ а¤ёаҐ‡ а¤¤аҐ‡а¤ња¤ј а¤®а¤ѕа¤Ёа¤µаҐЂа¤Ї а¤ёа¤®аҐЂа¤•аҐЌа¤·а¤ѕ а¤…а¤­аҐЂ а¤­аҐЂ а¤•а¤ѕа¤® а¤† а¤ёа¤•а¤¤аҐЂ а¤№аҐ€аҐ¤';

  @override
  String get translationStageAligning =>
      'а¤џа¤ѕа¤‡а¤®а¤ёаҐЌа¤џаҐ€а¤®аҐЌа¤Є а¤”а¤° а¤ёаҐЂа¤Ё а¤ёа¤‚а¤¦а¤°аҐЌа¤­ а¤®а¤їа¤Іа¤ѕа¤Џ а¤ња¤ѕ а¤°а¤№аҐ‡ а¤№аҐ€а¤‚';

  @override
  String get translationStageGenerating =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¬а¤Ёа¤ѕа¤Їа¤ѕ а¤ња¤ѕ а¤°а¤№а¤ѕ а¤№аҐ€';

  @override
  String get translationStageIdle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤…а¤ЁаҐЃа¤°аҐ‹а¤§ а¤•аҐЂ а¤ЄаҐЌа¤°а¤¤аҐЂа¤•аҐЌа¤·а¤ѕ а¤®аҐ‡а¤‚';

  @override
  String get translationStagePreparing =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤ЄаҐ€а¤•аҐ‡а¤њ а¤¤аҐ€а¤Їа¤ѕа¤° а¤•а¤їа¤Їа¤ѕ а¤ња¤ѕ а¤°а¤№а¤ѕ а¤№аҐ€';

  @override
  String get translationStageQueued =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•а¤¤а¤ѕа¤° а¤®аҐ‡а¤‚ а¤№аҐ€';

  @override
  String get translationStageReadability =>
      'а¤Єа¤ўа¤ја¤ЁаҐ‡-а¤Іа¤ѕа¤Їа¤• а¤¬а¤Ёа¤ѕа¤ЁаҐ‡ а¤•аҐЂ а¤ња¤ѕа¤Ѓа¤љ а¤Іа¤ѕа¤—аҐ‚ а¤•аҐЂ а¤ња¤ѕ а¤°а¤№аҐЂ а¤№аҐ€';

  @override
  String get translationStageReady =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤¤аҐ€а¤Їа¤ѕа¤° а¤№аҐ€';

  @override
  String get tryAgain => 'а¤«а¤їа¤° а¤ёаҐ‡ а¤•аҐ‹а¤¶а¤їа¤¶ а¤•а¤°аҐ‡а¤‚';

  @override
  String get uploadChooseFile =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤љаҐЃа¤ЁаҐ‡а¤‚';

  @override
  String get uploadChooseFileShort => 'а¤«а¤ја¤ѕа¤‡а¤І а¤љаҐЃа¤ЁаҐ‡а¤‚';

  @override
  String get uploadContinueSetup =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є а¤Єа¤° а¤†а¤—аҐ‡ а¤¬а¤ўа¤јаҐ‡а¤‚';

  @override
  String get uploadEnglishSource =>
      'а¤…а¤‚а¤—аҐЌа¤°аҐ‡а¤ња¤јаҐЂ а¤ёаҐЌа¤°аҐ‹а¤¤';

  @override
  String get uploadFailedFallback =>
      'а¤•аҐѓа¤Єа¤Їа¤ѕ а¤•аҐ‹а¤€ а¤¦аҐ‚а¤ёа¤°аҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤†а¤ња¤ја¤®а¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get uploadFailedMessage =>
      'а¤№а¤® а¤‡а¤ё а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤•аҐ‹ а¤Єа¤ўа¤ј а¤Ёа¤№аҐЂа¤‚ а¤ёа¤•аҐ‡аҐ¤ а¤•аҐ‹а¤€ а¤¦аҐ‚а¤ёа¤°аҐЂ а¤«а¤ја¤ѕа¤‡а¤І а¤Їа¤ѕ а¤›аҐ‹а¤џа¤ѕ а¤Џа¤•аҐЌа¤ёа¤ЄаҐ‹а¤°аҐЌа¤џ а¤†а¤ња¤ја¤®а¤ѕа¤Џа¤ЃаҐ¤';

  @override
  String get uploadFailedTitle =>
      'а¤«а¤ја¤ѕа¤‡а¤І а¤‡а¤®аҐЌа¤ЄаҐ‹а¤°аҐЌа¤џ а¤…а¤ёа¤«а¤І а¤°а¤№а¤ѕ';

  @override
  String get uploadIntroSubtitle =>
      'а¤Џа¤• а¤…а¤‚а¤—аҐЌа¤°аҐ‡а¤ња¤јаҐЂ `.srt` а¤Їа¤ѕ `.vtt` а¤«а¤ја¤ѕа¤‡а¤І а¤‡а¤®аҐЌа¤ЄаҐ‹а¤°аҐЌа¤џ а¤•а¤°аҐ‡а¤‚, а¤¬аҐ€а¤•а¤Џа¤‚а¤Ў а¤ёаҐ‡ а¤‰а¤ёаҐ‡ а¤µаҐ€а¤Іа¤їа¤ЎаҐ‡а¤џ а¤”а¤° а¤Єа¤ѕа¤°аҐЌа¤ё а¤•а¤°а¤µа¤ѕа¤Џа¤Ѓ, а¤«а¤їа¤° а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤ёаҐ‡а¤џа¤…а¤Є а¤Єа¤° а¤†а¤—аҐ‡ а¤¬а¤ўа¤јаҐ‡а¤‚аҐ¤';

  @override
  String get uploadIntroTitle =>
      'а¤…а¤Єа¤ЁаҐЂ а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І а¤•а¤°аҐ‡а¤‚';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount а¤Єа¤‚а¤•аҐЌа¤¤а¤їа¤Їа¤ѕа¤Ѓ';
  }

  @override
  String get uploadMetadataTitle => 'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤µа¤їа¤µа¤°а¤Ј';

  @override
  String get uploadOpeningPicker =>
      'а¤«а¤ја¤ѕа¤‡а¤І а¤Єа¤їа¤•а¤° а¤–аҐЃа¤І а¤°а¤№а¤ѕ а¤№аҐ€...';

  @override
  String get uploadPickSubtitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤љаҐЃа¤ЁаҐ‡а¤‚';

  @override
  String get uploadPickedFile =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤І а¤љаҐЃа¤ЁаҐЂ а¤—а¤€';

  @override
  String get uploadReadyTitle =>
      'а¤…а¤ЁаҐЃа¤µа¤ѕа¤¦ а¤•аҐ‡ а¤Іа¤їа¤Џ а¤¤аҐ€а¤Їа¤ѕа¤°';

  @override
  String get uploadSubtitleTitle =>
      'а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤…а¤Єа¤ІаҐ‹а¤Ў а¤•а¤°аҐ‡а¤‚';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'а¤…а¤‚а¤—аҐЌа¤°аҐ‡а¤ња¤јаҐЂ `.srt` а¤”а¤° `.vtt` а¤ёа¤¬а¤џа¤ѕа¤‡а¤џа¤І а¤«а¤ја¤ѕа¤‡а¤ІаҐ‡а¤‚';

  @override
  String get uploadSupportedFormatsTitle =>
      'а¤ёа¤®а¤°аҐЌа¤Ґа¤їа¤¤ а¤«а¤јаҐ‰а¤°аҐЌа¤®аҐ€а¤џ';

  @override
  String get uploadUseDemoFile =>
      'а¤ЎаҐ‡а¤®аҐ‹ а¤«а¤ја¤ѕа¤‡а¤І а¤‡а¤ёаҐЌа¤¤аҐ‡а¤®а¤ѕа¤І а¤•а¤°аҐ‡а¤‚';
}
