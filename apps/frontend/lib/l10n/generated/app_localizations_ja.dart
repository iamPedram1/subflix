// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'アカウント';

  @override
  String get authAlreadySignedInTitle => 'すでにサインインしています';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'このデバイスはすでに $email として接続されています。';
  }

  @override
  String get authBackToAccount => 'アカウントに戻る';

  @override
  String get authBackToSignIn => 'サインインに戻る';

  @override
  String get authCheckInboxTitle => '受信トレイを確認してください';

  @override
  String get authConfirmEmailAction => 'メールを確認する';

  @override
  String authConfirmEmailHint(Object email) {
    return '$email に送信された確認トークンを使用してください。';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'このアカウントの有効化を完了するため、メール内の確認トークンを貼り付けてください。';

  @override
  String get authConfirmEmailSuccess => 'メールが確認されました。サインインできます。';

  @override
  String get authConfirmEmailTitle => 'メールを確認してください';

  @override
  String get authConfirmPasswordLabel => 'パスワードを確認';

  @override
  String get authContinueToReset => 'リセットに進む';

  @override
  String get authContinueWithGoogle => 'Google で続行';

  @override
  String get authCreateAccountAction => 'アカウントを作成';

  @override
  String authDebugTokenLabel(Object token) {
    return 'デバッグトークン: $token';
  }

  @override
  String get authDisplayNameLabel => '表示名';

  @override
  String get authEmailLabel => 'メールアドレス';

  @override
  String get authEyebrow => '安全なワークスペース';

  @override
  String get authFieldRequired => 'この項目は必須です。';

  @override
  String get authForgotPasswordAction => 'リセットリンクを送信';

  @override
  String get authForgotPasswordDebugMessage =>
      'このデバッグ環境ではリセットトークンが返されました。リセットフォームへ直接進めます。';

  @override
  String get authForgotPasswordLink => 'パスワードをお忘れですか？';

  @override
  String get authForgotPasswordSubtitle =>
      'メールアドレスを入力すると、このアカウントのパスワード再設定をバックエンドに依頼します。';

  @override
  String get authForgotPasswordSuccess => 'アカウントが存在する場合、パスワード再設定メッセージが送信されました。';

  @override
  String get authForgotPasswordTitle => 'パスワードをリセット';

  @override
  String get authGoogleHelper =>
      'Google サインインは Firebase OAuth を使用しており、このアプリが Firebase プロジェクトに接続されると利用できます。';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'すでにアカウントをお持ちですか？ サインイン';

  @override
  String get authInvalidEmail => '有効なメールアドレスを入力してください。';

  @override
  String get authNewPasswordLabel => '新しいパスワード';

  @override
  String get authNoAccountLink => 'アカウントが必要ですか？ 作成しましょう';

  @override
  String get authOrDivider => 'または';

  @override
  String get authPasswordLabel => 'パスワード';

  @override
  String get authPasswordMismatch => 'パスワードが一致しません。';

  @override
  String get authPasswordTooShort => '8 文字以上使用してください。';

  @override
  String get authProfileRefreshed => 'アカウント情報を更新しました。';

  @override
  String get authRefreshProfileAction => 'プロフィールを更新';

  @override
  String get authRefreshProfileSubtitle => 'バックエンドから最新のプロフィール情報を読み込みます。';

  @override
  String get authResetPasswordAction => '新しいパスワードを保存';

  @override
  String authResetPasswordHint(Object email) {
    return 'メールに届いたトークンを使って $email のパスワードをリセットしてください。';
  }

  @override
  String get authResetPasswordSubtitle =>
      'リセットトークンを入力し、このアカウント用の新しいパスワードを選択してください。';

  @override
  String get authResetPasswordSuccess => 'パスワードが更新されました。もう一度サインインしてください。';

  @override
  String get authResetPasswordTitle => '新しいパスワードを選択';

  @override
  String get authSignInAction => 'サインイン';

  @override
  String get authSignInSubtitle =>
      'このアプリを SubFlix アカウントに接続して、プロフィールデータを同期し、認証済みバックエンドフローを利用できるようにします。';

  @override
  String get authSignInSuccess => 'サインインに成功しました。';

  @override
  String get authSignInTitle => 'おかえりなさい';

  @override
  String authSignedInCardSubtitle(Object email) {
    return '$email として接続中';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'アカウント管理や Firebase OAuth の利用、将来の同期に備えた認証機能の準備のためにサインインしてください。';

  @override
  String get authSignedOutCardTitle => 'SubFlix にサインイン';

  @override
  String get authSignOutAction => 'サインアウト';

  @override
  String get authSignOutSubtitle => 'このデバイスの現在のセッションを無効にし、ローカルトークンを削除します。';

  @override
  String get authSignOutSuccess => 'このデバイスでサインアウトしました。';

  @override
  String get authSignUpAction => 'アカウントを作成する';

  @override
  String get authSignUpSubtitle =>
      'このアプリが認証済みプロフィールとバックエンドのセッションフローを使えるように、アカウントを作成してください。';

  @override
  String get authSignUpSuccess => 'アカウントが作成されました。メール確認へ進んでください。';

  @override
  String get authSignUpTitle => 'アカウントを作成';

  @override
  String get authVerificationStatusTitle => 'メール確認';

  @override
  String get authVerificationTokenLabel => '確認トークン';

  @override
  String get authVerifiedStatus => '確認済み';

  @override
  String get authUnverifiedStatus => '確認待ち';

  @override
  String get brandSubtitleCompact => 'е­—е№•г‚¤гѓігѓ†гѓЄг‚ёг‚§гѓіг‚№';

  @override
  String get brandSubtitleFull => 'AIе­—е№•зї»иЁіг‚№г‚їг‚ёг‚Є';

  @override
  String get comingSoonMessage => 'гЃ“гЃ®з”»йќўгЃЇгЃѕгЃ жє–е‚™дё­гЃ§гЃ™гЂ‚';

  @override
  String get comingSoonTitle => 'иї‘ж—Ґе…¬й–‹';

  @override
  String exportFailedSnack(Object error) {
    return 'ж›ёгЃЌе‡єгЃ—гЃ«е¤±ж•—гЃ—гЃѕгЃ—гЃџ: $error';
  }

  @override
  String get exportSubtitleLabel => 'зї»иЁіжё€гЃїе­—е№•г‚’ж›ёгЃЌе‡єгЃ™';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName г‚’ $path гЃ«ж›ёгЃЌе‡єгЃ—гЃѕгЃ—гЃџ';
  }

  @override
  String get exportingLabel => 'ж›ёгЃЌе‡єгЃ—дё­...';

  @override
  String get heroBadge => 'гѓ—гѓ¬гѓџг‚ўгѓ е­—е№•гѓЇгѓјг‚Їгѓ•гѓ­гѓј';

  @override
  String get heroBody =>
      'ж¤њзґўеЏЇиѓЅгЃЄг‚їг‚¤гѓ€гѓ«г‚«г‚їгѓ­г‚°гЃ‹з›ґжЋҐгѓ•г‚Ўг‚¤гѓ«г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰г‚’йЃёгЃігЂЃж•°е€†гЃ§жґ—з·ґгЃ•г‚ЊгЃџе­—е№•г‚’гѓ—гѓ¬гѓ“гѓҐгѓјгѓ»ж›ёгЃЌе‡єгЃ—гЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get heroHeadline =>
      'г‚№г‚їг‚ёг‚Єе“ЃиіЄгЃ®гѓ•гѓ­гѓјгЃ§ж з”»гѓ»г‚·гѓЄгѓјг‚єе­—е№•г‚’зї»иЁігЂ‚';

  @override
  String get heroSearchCta => 'ж з”» / г‚·гѓЄгѓјг‚єг‚’ж¤њзґў';

  @override
  String get heroStatLanguagesTitle => '10иЁЂиЄћ';

  @override
  String get heroStatLanguagesValue => 'гѓ—гѓ¬гѓ“гѓҐгѓјеЏЇиѓЅ';

  @override
  String get heroStatMockTitle => 'гѓўгѓѓг‚ЇAPI';

  @override
  String get heroStatMockValue => 'гѓђгѓѓг‚Їг‚Ёгѓігѓ‰жЋҐз¶љжє–е‚™жё€гЃї';

  @override
  String get heroStatPathsTitle => '2гЃ¤гЃ®зµЊи·Ї';

  @override
  String get heroStatPathsValue => 'ж¤њзґўгЃѕгЃџгЃЇг‚ўгѓѓгѓ—гѓ­гѓјгѓ‰';

  @override
  String get heroSubtitle =>
      'ж з”»гѓ»г‚·гѓЄгѓјг‚єгЃ®г‚«г‚їгѓ­г‚°г‚’ж¤њзґўгЃ—гЂЃг‚Ѕгѓјг‚№г‚’йЃёгЃігЂЃж•°е€†гЃ§жґ—з·ґгЃ•г‚ЊгЃџзї»иЁіг‚’е‡єеЉ›гЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get heroTitle => 'е­—е№•г‚’г‚‚гЃЈгЃЁйЂџгЃЏзї»иЁі';

  @override
  String get heroUploadCta => 'е­—е№•г‚’г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰';

  @override
  String historyCountLabel(Object count) {
    return '$count д»¶гЃ®зї»иЁі';
  }

  @override
  String get historyEmptyMessage =>
      'ж¤њзґўгЃѕгЃџгЃЇг‚ўгѓѓгѓ—гѓ­гѓјгѓ‰гЃ®жµЃг‚Њг‚’е®Њдє†гЃ™г‚‹гЃЁгЂЃзї»иЁіжё€гЃїе­—е№•г‚ёгѓ§гѓ–гЃЊгЃ“гЃ“гЃ«иЎЁз¤єгЃ•г‚ЊгЃѕгЃ™гЂ‚';

  @override
  String get historyEmptyTitle => 'е±Ґж­ґгЃЇз©єгЃ§гЃ™';

  @override
  String get historyFailedItemMessage =>
      'зї»иЁігЃ«е¤±ж•—гЃ—гЃѕгЃ—гЃџгЂ‚г‚їгѓѓгѓ—гЃ—гЃ¦г‚„г‚Љз›ґгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get historyFailedTitle => 'е±Ґж­ґг‚’иЄ­гЃїиѕјг‚ЃгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';

  @override
  String get historyFilterAiTranslated => 'AIзї»иЁі';

  @override
  String get historyFilterAll => 'гЃ™гЃ№гЃ¦';

  @override
  String get historyFilterCompleted => 'е®Њдє†';

  @override
  String get historyFilterFailed => 'е¤±ж•—';

  @override
  String get historyFilterMovies => 'ж з”»';

  @override
  String get historyFilterReused => 'е†Ќе€©з”Ё';

  @override
  String get historyFilterSeries => 'г‚·гѓЄгѓјг‚є';

  @override
  String get historySubtitle =>
      'д»Ґе‰ЌгЃ®е­—е№•г‚ёгѓ§гѓ–г‚’й–‹гЃЌз›ґгЃ—гЂЃе†Ќеє¦гѓ—гѓ¬гѓ“гѓҐгѓјгЃ—гЃџг‚ЉгЂЃгЃ‚гЃЁгЃ§ж›ёгЃЌе‡єгЃ—гЃџг‚ЉгЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get historyTitle => 'зї»иЁіе±Ґж­ґ';

  @override
  String get homeFailedRecentTitle =>
      'жњЂиї‘гЃ®г‚ёгѓ§гѓ–г‚’иЄ­гЃїиѕјг‚ЃгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';

  @override
  String get homeFutureSubtitle =>
      'е·®гЃ—ж›їгЃ€еЏЇиѓЅгЃЄгѓўгѓѓг‚ЇгѓЄгѓќг‚ёгѓ€гѓЄгЃ«г‚€г‚ЉгЂЃUIг‚ігѓјгѓ‰гЃЇгѓђгѓѓг‚Їг‚Ёгѓігѓ‰е¤‰ж›ґгЃ®еЅ±йџїг‚’еЏ—гЃ‘гЃ«гЃЏгЃЏгЃЄг‚ЉгЃѕгЃ™гЂ‚';

  @override
  String get homeFutureTitle => 'е°†жќҐеЇѕеїњгЃ®гѓЄгѓќг‚ёгѓ€гѓЄ';

  @override
  String get homeNoRecentMessage =>
      'ж з”»ж¤њзґўг‚’е§‹г‚Ѓг‚‹гЃ‹е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰гЃ™г‚‹гЃЁгЂЃжњЂиї‘гЃ®зї»иЁігЃЊгЃ“гЃ“гЃ«иЎЁз¤єгЃ•г‚ЊгЃѕгЃ™гЂ‚';

  @override
  String get homeNoRecentTitle => 'жњЂиї‘гЃ®г‚ёгѓ§гѓ–гЃЇгЃѕгЃ гЃ‚г‚ЉгЃѕгЃ›г‚“';

  @override
  String get homePreviewSubtitle =>
      'ж›ёгЃЌе‡єгЃ—е‰ЌгЃ«гЂЃеЋџж–‡гѓ»зї»иЁігѓ»гѓђг‚¤гѓЄгѓіг‚¬гѓ«иЎЁз¤єгЃ§зµђжћњг‚’зўєиЄЌгЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get homePreviewTitle => 'гѓ—гѓ¬гѓ“гѓҐгѓјй‡Ќи¦–гЃ®зї»иЁігѓ•гѓ­гѓј';

  @override
  String get homeQuickHistory => 'е±Ґж­ґ';

  @override
  String get homeQuickSearch => 'ж¤њзґў';

  @override
  String get homeQuickUpload => 'г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰';

  @override
  String get homeRecentJobsSubtitle =>
      'жњЂе€ќгЃ‹г‚‰г‚„г‚Љз›ґгЃ•гЃљгЃ«гЂЃжњЂж–°гЃ®е­—е№•г‚»гѓѓг‚·гѓ§гѓіг‚’й–‹гЃЌз›ґгЃ›гЃѕгЃ™гЂ‚';

  @override
  String get homeRecentJobsTitle => 'жњЂиї‘гЃ®г‚ёгѓ§гѓ–';

  @override
  String get homeSearchPlaceholder => 'ж з”»г‚„г‚·гѓЄгѓјг‚єг‚’ж¤њзґў...';

  @override
  String get homeStatesSubtitle =>
      'иЄ­гЃїиѕјгЃїгЂЃз©єзЉ¶ж…‹гЂЃе†Ќи©¦иЎЊгЂЃж¤њиЁјгЂЃгѓўгѓѓг‚ЇгЃ®г‚Єгѓ•гѓ©г‚¤гѓізЉ¶ж…‹гЃѕгЃ§е€ќж—ҐгЃ‹г‚‰UXгЃ«еђ«гЃѕг‚ЊгЃ¦гЃ„гЃѕгЃ™гЂ‚';

  @override
  String get homeStatesTitle => 'дёЃеЇ§гЃЄзЉ¶ж…‹иЁ­иЁ€иѕјгЃї';

  @override
  String get homeTrendingNow => 'д»ЉгЃ®гѓ€гѓ¬гѓігѓ‰';

  @override
  String get homeTrustSubtitle =>
      'д»ЉгЃЇгѓўгѓѓг‚ЇгЃ§г‚‚гЂЃе®џйЃ‹з”ЁгЃ§гЃЌг‚‹иЈЅе“ЃгЃ®г‚€гЃ†гЃ«иЁ­иЁ€гЃ•г‚ЊгЃ¦гЃ„гЃѕгЃ™гЂ‚';

  @override
  String get homeTrustTitle => 'гѓЃгѓјгѓ гЃ«дїЎй јгЃ•г‚Њг‚‹зђ†з”±';

  @override
  String get homeViewAll => 'гЃ™гЃ№гЃ¦и¦‹г‚‹';

  @override
  String get homeWelcomeSubtitle => 'е­—е№•г‚’и¦‹гЃ¤гЃ‘гЃ¦зї»иЁі';

  @override
  String get homeWelcomeTitle => 'гЃЉгЃ‹гЃ€г‚ЉгЃЄгЃ•гЃ„';

  @override
  String jobConfidence(Object level) {
    return 'дїЎй јеє¦: $level';
  }

  @override
  String get jobOpenPreview => 'гѓ—гѓ¬гѓ“гѓҐгѓјг‚’й–‹гЃЏ';

  @override
  String get jobReuseSubtitle => 'е­—е№•г‚’е†Ќе€©з”Ё';

  @override
  String get jobReuseTranslation => 'зї»иЁіг‚’е†Ќе€©з”Ё';

  @override
  String get legalBodyAbout =>
      'SubFlix гЃЇ AI е­—е№•зї»иЁіеђ‘гЃ‘гЃ®гѓ—гѓ¬гѓџг‚ўгѓ еї—еђ‘ Flutter г‚Їгѓ©г‚¤г‚ўгѓігѓ€гЃ§гЃ™гЂ‚гЃ“гЃ®гѓ“гѓ«гѓ‰гЃ§гЃЇгЂЃе®џйљ›гЃ®гѓђгѓѓг‚Їг‚Ёгѓігѓ‰жЋҐз¶ље‰ЌгЃ« UI гЃЁг‚ўгѓјг‚­гѓ†г‚ЇгѓЃгѓЈг‚’и‚ІгЃ¦г‚‹гЃџг‚ЃгЂЃгѓўгѓѓг‚ЇгѓЄгѓќг‚ёгѓ€гѓЄгЂЃдєєе·Ґзљ„гЃЄйЃ…е»¶гЂЃгѓ­гѓјг‚«гѓ«дїќе­г‚’дЅїгЃЈгЃ¦гЃ„гЃѕгЃ™гЂ‚';

  @override
  String get legalBodyPrivacy =>
      'SubFlix гЃЇзЏѕењЁгЂЃгѓўгѓѓг‚ЇгЃ®иЁ­е®љгЃЁзї»иЁіе±Ґж­ґгЃ®гЃїг‚’гѓ­гѓјг‚«гѓ«дїќе­гЃ—гЃ¦гЃ„гЃѕгЃ™гЂ‚е°†жќҐзљ„гЃЄгѓђгѓѓг‚Їг‚Ёгѓігѓ‰йЂЈжђєгЃ«г‚€г‚ЉгЂЃиЄЌиЁјд»гЃЌдїќе­гЂЃз›Јжџ»гѓ­г‚°гЂЃг‚µгѓјгѓђгѓјз®Ўзђ†гЃ®дїќжЊЃгѓќгѓЄг‚·гѓјгЃёзЅ®гЃЌжЏ›гЃ€г‚‰г‚ЊгЃѕгЃ™гЂ‚';

  @override
  String get legalBodySupport =>
      'г‚µгѓќгѓјгѓ€гЃЇзЏѕењЁгѓ—гѓ¬гѓјг‚№гѓ›гѓ«гѓЂгѓјгЃ§гЃ™гЂ‚жњ¬з•ЄгЃ§гЃЇгЂЃг‚ўгѓ—гѓЄж§‹йЂ г‚’е¤‰гЃ€гЃљгЃ«гѓЎгѓјгѓ«гЂЃе•ЏйЎЊе ±е‘ЉгЂЃгѓ—гѓ¬гѓџг‚ўгѓ дјље“Ўеђ‘гЃ‘ж”ЇжЏґгЃёжЋҐз¶љгЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get legalBodyTerms =>
      'гЃ“гЃ®гѓўгѓѓг‚Їгѓ“гѓ«гѓ‰гЃЇгЂЃиЈЅе“Ѓгѓ•гѓ­гѓјгЂЃUIзЉ¶ж…‹гЂЃг‚ўгѓјг‚­гѓ†г‚ЇгѓЃгѓЈеўѓз•Њг‚’ж¤њиЁјгЃ™г‚‹гЃџг‚ЃгЃ®г‚‚гЃ®гЃ§гЃ™гЂ‚е°†жќҐ NestJS гЃЁ Postgres гЃ®жњ¬з•Єгѓђгѓѓг‚Їг‚Ёгѓігѓ‰гЃЊжЋҐз¶љгЃ•г‚Њг‚ЊгЃ°гЂЃе®џйљ›гЃ®е€©з”Ёи¦Џзґ„г‚„гѓ‡гѓјг‚їе‡¦зђ†ж–‡иЁЂг‚’иїЅеЉ гЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get legalPlaceholderBody =>
      'гЃ“гЃ®гѓљгѓјг‚ёгЃЇгѓ‡гѓўг‚ўгѓ—гѓЄе†…гЃ®гѓ—гѓ¬гѓјг‚№гѓ›гѓ«гѓЂгѓјгЃ§гЃ™гЂ‚жњ¬з•Єз”ЁгЃ®жі•зљ„г‚ігѓігѓ†гѓігѓ„гЃ«е·®гЃ—ж›їгЃ€гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get legalTitleAbout => 'SubFlix гЃ«гЃ¤гЃ„гЃ¦';

  @override
  String get legalTitlePrivacy => 'гѓ—гѓ©г‚¤гѓђг‚·гѓјгѓќгѓЄг‚·гѓј';

  @override
  String get legalTitleSupport => 'г‚µгѓќгѓјгѓ€';

  @override
  String get legalTitleTerms => 'е€©з”Ёи¦Џзґ„';

  @override
  String get mediaTypeMovie => 'ж з”»';

  @override
  String get mediaTypeSeries => 'г‚·гѓЄгѓјг‚є';

  @override
  String get metadataEstimatedDuration => 'жЋЁе®љж™‚й–“';

  @override
  String get metadataFormat => 'еЅўејЏ';

  @override
  String get metadataLanguages => 'иЁЂиЄћ';

  @override
  String get metadataLines => 'иЎЊж•°';

  @override
  String get navHistory => 'е±Ґж­ґ';

  @override
  String get navHome => 'гѓ›гѓјгѓ ';

  @override
  String get navSettings => 'иЁ­е®љ';

  @override
  String get noTitlesMatchedMessage =>
      'гЃ“гЃ®г‚їг‚¤гѓ€гѓ«гЃЇгѓўгѓѓг‚Їг‚«г‚їгѓ­г‚°гЃ§и¦‹гЃ¤гЃ‹г‚ЉгЃѕгЃ›г‚“гЃ§гЃ—гЃџгЂ‚г‚€г‚ЉеєѓгЃ„жќЎд»¶гЃ§ж¤њзґўгЃ™г‚‹гЃ‹гЂЃеЂ™иЈњгЃ®г‚їг‚¤гѓ€гѓ«г‚’и©¦гЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get noTitlesMatchedTitle => 'дёЂи‡ґгЃ™г‚‹зµђжћњгЃЊгЃ‚г‚ЉгЃѕгЃ›г‚“';

  @override
  String get onboardingContinue => 'з¶љгЃ‘г‚‹';

  @override
  String get onboardingEnterApp => 'SubFlix гЃ«е…Ґг‚‹';

  @override
  String get onboardingNext => 'ж¬ЎгЃё';

  @override
  String get onboardingPage1Description =>
      'г‚їг‚¤гѓ€гѓ«г‚’ж¤њзґўгЃ—гЂЃе€©з”ЁеЏЇиѓЅгЃЄи‹±иЄће­—е№•г‚Ѕгѓјг‚№г‚’зўєиЄЌгЃ—гЃ¦гЂЃгЃ™гЃђгЃ«дЅїгЃ€г‚‹зї»иЁігѓ•гѓ­гѓјг‚’й–‹е§‹гЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get onboardingPage1Eyebrow => 'ж¤њзґўгЃ—гЃ¦еЏ–еѕ—';

  @override
  String get onboardingPage1Highlight1 =>
      'й–‹з™єгЃ—г‚„гЃ™гЃ„ж±єе®љи«–зљ„гѓўгѓѓг‚Їг‚«г‚їгѓ­г‚°';

  @override
  String get onboardingPage1Highlight2 =>
      'е­—е№•г‚Ѕгѓјг‚№гЃ®е“ЃиіЄгѓ©гѓ™гѓ«гЃЁеЅўејЏгѓђгѓѓг‚ё';

  @override
  String get onboardingPage1Highlight3 =>
      'еѕЊгЃ‹г‚‰е®џгѓђгѓѓг‚Їг‚Ёгѓігѓ‰гЃёе·®гЃ—ж›їгЃ€еЏЇиѓЅ';

  @override
  String get onboardingPage1Title =>
      'ж з”»г‚„г‚·гѓЄгѓјг‚єг‚’жЋўгЃ—гЃ¦гЂЃгЃ™гЃђзї»иЁігЃ§гЃЌг‚‹е­—е№•г‚’еЏ–еѕ—гЂ‚';

  @override
  String get onboardingPage2Description =>
      'е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’еЏ–г‚ЉиѕјгЃїгЂЃеЅўејЏг‚’ж¤њиЁјгЃ—гЂЃеђЊгЃжґ—з·ґгЃ•г‚ЊгЃџзї»иЁігѓ‘г‚¤гѓ—гѓ©г‚¤гѓіг‚’г‚ўгѓ—гѓЄе†…гЃ§е®џиЎЊгЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get onboardingPage2Eyebrow => 'и‡Єе€†гЃ®гѓ•г‚Ўг‚¤гѓ«г‚’дЅїгЃ†';

  @override
  String get onboardingPage2Highlight1 =>
      'гѓ­гѓјг‚«гѓ«ж¤њиЁјгЃЁдёЃеЇ§гЃЄе†Ќи©¦иЎЊзЉ¶ж…‹';

  @override
  String get onboardingPage2Highlight2 =>
      'ж¤њзґўгЃЁг‚ўгѓѓгѓ—гѓ­гѓјгѓ‰гЃ§дёЂиІ«гЃ—гЃџиЁ­е®љ';

  @override
  String get onboardingPage2Highlight3 =>
      'дёЌйЂЏжЋгЃ•г‚’гЃЄгЃЏгЃ™гЃџг‚ЃгЂЃж›ёгЃЌе‡єгЃ—е‰ЌгЃ«зўєиЄЌ';

  @override
  String get onboardingPage2Title =>
      'гЃ™гЃ§гЃ«еЏ°жњ¬гЃЊгЃ‚г‚‹гЃЄг‚‰ `.srt` / `.vtt` г‚’г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰гЂ‚';

  @override
  String get onboardingPage3Description =>
      'еЋџж–‡гѓ»зї»иЁігѓ»гѓђг‚¤гѓЄгѓіг‚¬гѓ«иЎЁз¤єг‚’е€‡г‚Љж›їгЃ€гЂЃе±Ґж­ґг‚’и¦‹иї”гЃ—гЂЃд»•дёЉгЃЊг‚ЉгЃ«зґЌеѕ—гЃ—гЃџг‚‰гЃЌг‚ЊгЃ„гЃЄе­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’ж›ёгЃЌе‡єгЃ›гЃѕгЃ™гЂ‚';

  @override
  String get onboardingPage3Eyebrow => 'зї»иЁігЃ—гЃ¦ж›ёгЃЌе‡єгЃ™';

  @override
  String get onboardingPage3Highlight1 =>
      'гѓЎг‚їгѓ‡гѓјг‚їгЃЁж¤њзґўд»гЃЌгЃ®й«йЂџгѓ—гѓ¬гѓ“гѓҐгѓјж“ЌдЅњ';

  @override
  String get onboardingPage3Highlight2 =>
      'е±Ґж­ґгЃ‹г‚‰д»Ґе‰ЌгЃ®г‚ёгѓ§гѓ–гЃ«гЃ™гЃђж€»г‚Њг‚‹';

  @override
  String get onboardingPage3Highlight3 =>
      'гѓ‡гѓўгЃ§гЃЇгЃЄгЃЏгЂЃгѓ—гѓ¬гѓџг‚ўгѓ гЃЄгѓЎгѓ‡г‚Јг‚ўгѓ„гѓјгѓ«гЃ®г‚€гЃ†гЃЄиЁ­иЁ€';

  @override
  String get onboardingPage3Title =>
      'еЇѕи±ЎиЁЂиЄћг‚’йЃёгЃігЂЃе­—е№•г‚’зўєиЄЌгЃ—гЃ¦гЂЃгЃ™гЃђж›ёгЃЌе‡єгЃ—гЂ‚';

  @override
  String get onboardingSkip => 'г‚№г‚­гѓѓгѓ—';

  @override
  String get onboardingStart => 'зї»иЁіг‚’е§‹г‚Ѓг‚‹';

  @override
  String get previewFailedTitle =>
      'гѓ—гѓ¬гѓ“гѓҐгѓјгЃ®иЄ­гЃїиѕјгЃїгЃ«е¤±ж•—гЃ—гЃѕгЃ—гЃџ';

  @override
  String get previewModeBilingual => 'гѓђг‚¤гѓЄгѓіг‚¬гѓ«';

  @override
  String get previewModeOriginal => 'еЋџж–‡';

  @override
  String get previewModeTranslated => 'зї»иЁіж–‡';

  @override
  String get previewNoMatchesMessage =>
      'е€ҐгЃ®ж¤њзґўиЄћг‚’и©¦гЃ™гЃ‹гЂЃгѓ•г‚Јгѓ«г‚їгѓјг‚’и§Јй™¤гЃ—гЃ¦е…Ёж–‡г‚’зўєиЄЌгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get previewNoMatchesTitle => 'дёЂи‡ґгЃ™г‚‹е­—е№•иЎЊгЃЊгЃ‚г‚ЉгЃѕгЃ›г‚“';

  @override
  String get previewNotReadyMessage =>
      'зї»иЁігЃЇе®Њдє†гЃ—гЃѕгЃ—гЃџгЃЊгЂЃгѓђгѓѓг‚Їг‚Ёгѓігѓ‰гЃ‹г‚‰гѓ—гѓ¬гѓ“гѓҐгѓј cue гЃЊгЃѕгЃ иї”гЃЈгЃ¦гЃЌгЃ¦гЃ„гЃѕгЃ›г‚“гЂ‚е°‘гЃ—еѕ…гЃЈгЃ¦е†ЌиЄ­гЃїиѕјгЃїгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get previewNotReadyTitle =>
      'гѓ—гѓ¬гѓ“гѓҐгѓјз”Ё cue гЃЇгЃѕгЃ е€©з”ЁгЃ§гЃЌгЃѕгЃ›г‚“';

  @override
  String get retry => 'е†Ќи©¦иЎЊ';

  @override
  String get retryTranslation => 'зї»иЁіг‚’е†Ќи©¦иЎЊ';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'гЃ©гЃ®г‚·гѓјг‚єгѓіг‚’иЄ­гЃїиѕјг‚ЂгЃ№гЃЌгЃ‹е€¤ж–­гЃ§гЃЌгЃѕгЃ›г‚“гЃ§гЃ—гЃџгЂ‚ж¤њзґўгЃ‹г‚‰г‚„г‚Љз›ґгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get routeMissingSeasonEpisodesTitle =>
      'г‚·гѓјг‚єгѓігЃ®г‚Ёгѓ”г‚Ѕгѓјгѓ‰';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'гЃ©гЃ®г‚·гѓЄгѓјг‚єг‚’иЄ­гЃїиѕјг‚ЂгЃ№гЃЌгЃ‹е€¤ж–­гЃ§гЃЌгЃѕгЃ›г‚“гЃ§гЃ—гЃџгЂ‚ж¤њзґўгЃ‹г‚‰г‚„г‚Љз›ґгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get routeMissingSeriesSeasonsTitle => 'г‚·гѓЄгѓјг‚єгЃ®г‚·гѓјг‚єгѓі';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'гЃ©гЃ®г‚їг‚¤гѓ€гѓ«гЃ®е­—е№•г‚Ѕгѓјг‚№г‚’иЄ­гЃїиѕјг‚ЂгЃ№гЃЌгЃ‹е€¤ж–­гЃ§гЃЌгЃѕгЃ›г‚“гЃ§гЃ—гЃџгЂ‚ж¤њзґўгЃ‹г‚‰г‚„г‚Љз›ґгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get routeMissingSubtitleSourcesTitle => 'е­—е№•г‚Ѕгѓјг‚№';

  @override
  String get routeMissingTranslationProgressMessage =>
      'зї»иЁігѓЄг‚Їг‚Ёг‚№гѓ€гЃЊгЃ‚г‚ЉгЃѕгЃ›г‚“гЂ‚ж¤њзґўгЃѕгЃџгЃЇг‚ўгѓѓгѓ—гѓ­гѓјгѓ‰гЃ‹г‚‰ж–°гЃ—гЃ„зї»иЁіг‚’е§‹г‚ЃгЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get routeMissingTranslationProgressTitle => 'зї»иЁігЃ®йЂІиЎЊзЉ¶жіЃ';

  @override
  String get routeMissingTranslationSetupMessage =>
      'зї»иЁіиЁ­е®љз”»йќўг‚’й–‹гЃЏе‰ЌгЃ«е­—е№•г‚Ѕгѓјг‚№гЃЊеї…и¦ЃгЃ§гЃ™гЂ‚';

  @override
  String get routeMissingTranslationSetupTitle => 'зї»иЁіиЁ­е®љ';

  @override
  String get searchFailedTitle => 'ж¤њзґўгЃ«е¤±ж•—гЃ—гЃѕгЃ—гЃџ';

  @override
  String searchFoundResults(Object count, Object query) {
    return '\"$query\" гЃ®зµђжћњгЃЊ $count д»¶и¦‹гЃ¤гЃ‹г‚ЉгЃѕгЃ—гЃџ';
  }

  @override
  String get searchHintText =>
      'DuneгЂЃBreaking BadгЂЃSeverance гЃЄгЃ©г‚’ж¤њзґў...';

  @override
  String get searchLoadingLabel => 'ж¤њзґўдё­...';

  @override
  String get searchMockMessage =>
      'InceptionгЂЃDuneгЂЃBreaking BadгЂЃSeveranceгЂЃThe Last of Us гЃЄгЃ©г‚’и©¦гЃ—гЃ¦гЂЃе­—е№•г‚Ѕгѓјг‚№гЃ®жµЃг‚Њг‚’зўєиЄЌгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get searchMockTitle => 'гѓўгѓѓг‚Їг‚«г‚їгѓ­г‚°е†…г‚’ж¤њзґў';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'г‚їг‚¤гѓ€гѓ«г‚’и¦‹гЃ¤гЃ‘гЃ¦е­—е№•г‚Ѕгѓјг‚№г‚’зўєиЄЌгЃ—гЂЃж•°е›ћгЃ®г‚їгѓѓгѓ—гЃ§зї»иЁіг‚ёгѓ§гѓ–г‚’й–‹е§‹гЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get searchMovieOrSeriesTitle => 'ж з”»гѓ»г‚·гѓЄгѓјг‚єг‚’ж¤њзґў';

  @override
  String searchNoResultsFor(Object query) {
    return '\"$query\" гЃ®зµђжћњгЃЇи¦‹гЃ¤гЃ‹г‚ЉгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'дєєж°—еє¦ $score';
  }

  @override
  String get searchTitles => 'г‚їг‚¤гѓ€гѓ«г‚’ж¤њзґў';

  @override
  String get searchTrendingTitle => 'дєєж°—гЃ®ж¤њзґў';

  @override
  String get searchTryDifferentKeywords =>
      'е€ҐгЃ®г‚­гѓјгѓЇгѓјгѓ‰гЃ§ж¤њзґўгЃ—гЃ¦гЃїгЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'г‚Ёгѓ”г‚Ѕгѓјгѓ‰ $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'зґ„ $runtime е€†';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount и©±$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'г‚·гѓјг‚єгѓі $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'г‚·гѓјг‚єгѓі $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount и©±$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return '$title гЃ®г‚·гѓјг‚єгѓіг‚’йЃёг‚“гЃ§гЂЃе€©з”ЁеЏЇиѓЅгЃЄг‚Ёгѓ”г‚Ѕгѓјгѓ‰г‚’зўєиЄЌгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';
  }

  @override
  String get seriesSeasonsTitle => 'г‚·гѓјг‚єгѓіг‚’йЃёжЉћ';

  @override
  String get settingsAboutTitle => 'SubFlix гЃ«гЃ¤гЃ„гЃ¦';

  @override
  String get settingsCacheCleared => 'г‚­гѓЈгѓѓг‚·гѓҐг‚’ж¶€еЋ»гЃ—гЃѕгЃ—гЃџ';

  @override
  String get settingsClearCache => 'г‚­гѓЈгѓѓг‚·гѓҐг‚’ж¶€еЋ»';

  @override
  String get settingsContactTitle => 'гЃЉе•ЏгЃ„еђ€г‚ЏгЃ›';

  @override
  String get settingsFailedTitle => 'иЁ­е®љг‚’иЄ­гЃїиѕјг‚ЃгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';

  @override
  String get settingsHelpCenterTitle => 'гѓгѓ«гѓ—г‚»гѓіг‚їгѓј';

  @override
  String get settingsHistoryClearedSnack =>
      'гЃ“гЃ®з«Їжњ«гЃ®зї»иЁіе±Ґж­ґг‚’ж¶€еЋ»гЃ—гЃѕгЃ—гЃџ';

  @override
  String get settingsLanguageLabel => 'е„Єе…€гЃ™г‚‹зї»иЁіе…€иЁЂиЄћ';

  @override
  String get settingsMaintenanceSubtitle =>
      'гЃ“гЃ®з«Їжњ«гЃ®гѓђгѓѓг‚Їг‚Ёгѓігѓ‰з®Ўзђ†зї»иЁіг‚ёгѓ§гѓ–г‚’ж¶€еЋ»гЃ—гЂЃе±Ґж­ґг‚’з©єгЃ®зЉ¶ж…‹гЃ‹г‚‰е§‹г‚ЃгЃѕгЃ™гЂ‚';

  @override
  String get settingsMaintenanceTitle => 'гѓЎгѓігѓ†гѓЉгѓіг‚№';

  @override
  String get settingsNotificationsSubtitle => 'йЂљзџҐиЁ­е®љг‚’з®Ўзђ†';

  @override
  String get settingsNotificationsTitle => 'йЂљзџҐ';

  @override
  String get settingsPremiumSubtitle =>
      'д»ЉеѕЊгЂЃиіјиЄ­гѓ»и«‹ж±‚гѓ»г‚Їгѓ©г‚¦гѓ‰гѓ—гѓ­г‚ёг‚§г‚Їгѓ€еђЊжњџг‚’гЃ“гЃ“гЃ«жЋҐз¶љгЃ§гЃЌгЃѕгЃ™гЂ‚';

  @override
  String get settingsPremiumTitle =>
      'гѓ—гѓ¬гѓџг‚ўгѓ з”Ёгѓ—гѓ¬гѓјг‚№гѓ›гѓ«гѓЂгѓј';

  @override
  String get settingsPrivacySubtitle => 'гѓўгѓѓг‚ЇгЃ®гѓ—гѓ©г‚¤гѓђг‚·гѓје†…е®№';

  @override
  String get settingsPrivacyTitle => 'гѓ—гѓ©г‚¤гѓђг‚·гѓјгѓќгѓЄг‚·гѓј';

  @override
  String get settingsProfileName => 'SubFlix гѓ¦гѓјг‚¶гѓј';

  @override
  String get settingsProfileTier => 'гѓ—гѓ¬гѓџг‚ўгѓ дјље“Ў';

  @override
  String get settingsSubtitle => 'еҐЅгЃїг‚’з®Ўзђ†';

  @override
  String get settingsSupportSubtitle =>
      'гѓўгѓѓг‚ЇгЃ®гѓгѓ«гѓ—гѓ»е•ЏгЃ„еђ€г‚ЏгЃ›гѓљгѓјг‚ё';

  @override
  String get settingsSupportTitle => 'г‚µгѓќгѓјгѓ€з”Ёгѓ—гѓ¬гѓјг‚№гѓ›гѓ«гѓЂгѓј';

  @override
  String get settingsTermsSubtitle => 'гѓўгѓѓг‚ЇгЃ®и¦Џзґ„е†…е®№';

  @override
  String get settingsTermsTitle => 'е€©з”Ёи¦Џзґ„';

  @override
  String get settingsThemeLabel => 'е¤–и¦і';

  @override
  String get settingsTitle => 'иЁ­е®љ';

  @override
  String settingsVersion(Object version) {
    return 'гѓђгѓјг‚ёгѓ§гѓі $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'гЃ‚гЃЄгЃџгЃ®е­—е№•г‚№г‚їг‚ёг‚Єг‚’жє–е‚™дё­';

  @override
  String get splashSubtitle => 'AIгЃ«г‚€г‚‹е­—е№•зї»иЁі';

  @override
  String get startTranslation => 'зї»иЁіг‚’й–‹е§‹';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads гѓЂг‚¦гѓігѓ­гѓјгѓ‰';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format е­—е№•г‚Ѕгѓјг‚№';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount иЎЊ';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'и©•дѕЎ $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'е­—е№•г‚Ѕгѓјг‚№г‚’йЃёжЉћгЃ™г‚‹гЃЁгЂЃе­—е№•г‚їг‚¤гѓџгѓіг‚°гЃ«жњЂйЃ©еЊ–гЃ•г‚ЊгЃџзї»иЁіиЁ­е®љгЃёйЂІгЃїгЃѕгЃ™гЂ‚';

  @override
  String get subtitleSourcesBannerTitle => 'AIзї»иЁігЃЊе€©з”ЁгЃ§гЃЌгЃѕгЃ™';

  @override
  String get subtitleSourcesFailedTitle =>
      'е­—е№•г‚Ѕгѓјг‚№г‚’иЄ­гЃїиѕјг‚ЃгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return '$title$target гЃ®е­—е№•г‚Ѕгѓјг‚№г‚’йЃёгЃігЂЃж¬ЎгЃ®г‚№гѓ†гѓѓгѓ—гЃ§еЇѕи±ЎиЁЂиЄћг‚’йЃёжЉћгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';
  }

  @override
  String get subtitleSourcesTitle => 'и‹±иЄће­—е№•г‚Ѕгѓјг‚№';

  @override
  String get targetLanguage => 'еЇѕи±ЎиЁЂиЄћ';

  @override
  String get themeDark => 'гѓЂгѓјг‚Ї';

  @override
  String get themeLight => 'гѓ©г‚¤гѓ€';

  @override
  String get themeSystem => 'г‚·г‚№гѓ†гѓ ';

  @override
  String get translateSetupAutoDetect => 'еЅўејЏг‚’и‡Єе‹•ж¤ње‡є';

  @override
  String get translateSetupAutoDetectBody =>
      'е­—е№•гЃ®е‡єеЉ›ж§‹йЂ г‚’и‡Єе‹•гЃ§жњЂйЃ©еЊ–гЃ—гЃѕгЃ™гЂ‚';

  @override
  String get translateSetupLanguageTitle => 'зї»иЁіе…€';

  @override
  String get translateSetupOptionsTitle => 'г‚Єгѓ—г‚·гѓ§гѓі';

  @override
  String get translateSetupPreserveTiming => 'г‚їг‚¤гѓџгѓіг‚°г‚’дїќжЊЃ';

  @override
  String get translateSetupPreserveTimingBody =>
      'е…ѓгѓ•г‚Ўг‚¤гѓ«гЃ«еђ€г‚ЏгЃ›гЃ¦е­—е№•гЃ®г‚їг‚¤гѓџгѓіг‚°г‚’з¶­жЊЃгЃ—гЃѕгЃ™гЂ‚';

  @override
  String translateSetupReadyBody(Object language) {
    return 'гЃ“гЃ®е­—е№•гЃЇгЂЃг‚їг‚¤гѓџгѓіг‚°гЃЁ cue ж§‹йЂ г‚’дїќгЃЈгЃџгЃѕгЃѕ $language гЃ«е¤‰жЏ›гЃ•г‚ЊгЃѕгЃ™гЂ‚';
  }

  @override
  String get translateSetupReadyTitle => 'AIзї»иЁігЃ®жє–е‚™е®Њдє†';

  @override
  String get translateSetupSelectLanguage => 'иЁЂиЄћг‚’йЃёжЉћ';

  @override
  String get translateSetupSourceTitle => 'е…ѓгЃ®е­—е№•';

  @override
  String get translateSetupSubtitle =>
      'еЇѕи±ЎиЁЂиЄћг‚’йЃёгЃігЂЃе­—е№•г‚Ѕгѓјг‚№г‚’зўєиЄЌгЃ—гЃ¦гЃ‹г‚‰гЂЃгѓђгѓѓг‚Їг‚Ёгѓігѓ‰зї»иЁіг‚ёгѓ§гѓ–г‚’й–‹е§‹гЃ—гЃѕгЃ™гЂ‚';

  @override
  String get translateSetupTitle => 'зї»иЁіиЁ­е®љ';

  @override
  String get translationFailedMessage => 'е•ЏйЎЊгЃЊз™єз”џгЃ—гЃѕгЃ—гЃџгЂ‚';

  @override
  String get translationFailedTitle =>
      'зї»иЁіг‚’е®Њдє†гЃ§гЃЌгЃѕгЃ›г‚“гЃ§гЃ—гЃџ';

  @override
  String get translationPreviewHeader => 'зї»иЁігЃ•г‚ЊгЃџе­—е№•г‚’зўєиЄЌ';

  @override
  String get translationPreviewSearchHint => 'е­—е№•иЎЊг‚’ж¤њзґў';

  @override
  String get translationPreviewSubtitle =>
      'cue е†…г‚’ж¤њзґўгЃ—гЂЃиЎЁз¤єгѓўгѓјгѓ‰г‚’е€‡г‚Љж›їгЃ€гЂЃзґЌеѕ—гЃ§гЃЌгЃџг‚‰ж›ёгЃЌе‡єгЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get translationPreviewTitle => 'зї»иЁігѓ—гѓ¬гѓ“гѓҐгѓј';

  @override
  String get translationProgressHeadline => 'AIе­—е№•зї»иЁіг‚’е®џиЎЊдё­гЃ§гЃ™';

  @override
  String get translationProgressTitle => 'зї»иЁігЃ®йЂІиЎЊзЉ¶жіЃ';

  @override
  String get translationResultCompleteSubtitle =>
      'е­—е№•гЃЇгѓ—гѓ¬гѓ“гѓҐгѓјгЃѕгЃџгЃЇгѓЂг‚¦гѓігѓ­гѓјгѓ‰гЃ®жє–е‚™гЃЊгЃ§гЃЌгЃ¦гЃ„гЃѕгЃ™гЂ‚';

  @override
  String get translationResultCompleteTitle => 'зї»иЁігЃЊе®Њдє†гЃ—гЃѕгЃ—гЃџ';

  @override
  String get translationResultConfidenceLabel => 'зї»иЁігЃ®дїЎй јеє¦';

  @override
  String get translationResultDetailsTitle => 'зї»иЁігЃ®и©ізґ°';

  @override
  String get translationResultDownloadCta => 'е­—е№•г‚’гѓЂг‚¦гѓігѓ­гѓјгѓ‰';

  @override
  String get translationResultHomeCta => 'гѓ›гѓјгѓ гЃ«ж€»г‚‹';

  @override
  String get translationResultMediaLabel => 'дЅње“Ѓг‚їг‚¤гѓ€гѓ«';

  @override
  String get translationResultMethodAi => 'AIгЃ§зї»иЁіжё€гЃї';

  @override
  String get translationResultMetricsTitle => 'е“ЃиіЄжЊ‡жЁ™';

  @override
  String get translationResultPreviewCta => 'е­—е№•г‚’гѓ—гѓ¬гѓ“гѓҐгѓј';

  @override
  String translationResultProcessedIn(Object duration) {
    return '$duration гЃ§е‡¦зђ†е®Њдє†';
  }

  @override
  String get translationResultSourceLabel => 'е…ѓгЃ®иЁЂиЄћ';

  @override
  String get translationResultTargetLabel => 'зї»иЁіе…€гЃ®иЁЂиЄћ';

  @override
  String get translationResultTimingLabel => 'г‚їг‚¤гѓџгѓіг‚°зІѕеє¦';

  @override
  String get translationResultTimingPreserved => 'г‚їг‚¤гѓџгѓіг‚°дїќжЊЃ';

  @override
  String get translationResultWarning =>
      'дёЂйѓЁгЃ®е°‚й–Ђз”ЁиЄћгЃЇгЂЃж–‡и„€зўєиЄЌгЃ®гЃџг‚ЃгЃ«дєєгЃ®и»ЅгЃ„и¦‹з›ґгЃ—гЃЊгЃ‚г‚‹гЃЁг‚€г‚Ље®‰еїѓгЃ§гЃ™гЂ‚';

  @override
  String get translationStageAligning =>
      'г‚їг‚¤гѓ г‚№г‚їгѓігѓ—гЃЁг‚·гѓјгѓіж–‡и„€г‚’иЄїж•ґдё­';

  @override
  String get translationStageGenerating => 'е­—е№•зї»иЁіг‚’з”џж€ђдё­';

  @override
  String get translationStageIdle => 'зї»иЁігѓЄг‚Їг‚Ёг‚№гѓ€г‚’еѕ…ж©џдё­';

  @override
  String get translationStagePreparing => 'е­—е№•гѓ‘гѓѓг‚±гѓјг‚ёг‚’жє–е‚™дё­';

  @override
  String get translationStageQueued =>
      'зї»иЁіеѕ…гЃЎг‚­гѓҐгѓјгЃ«е…Ґг‚ЉгЃѕгЃ—гЃџ';

  @override
  String get translationStageReadability => 'иЄ­гЃїг‚„гЃ™гЃ•иЄїж•ґг‚’йЃ©з”Ёдё­';

  @override
  String get translationStageReady => 'зї»иЁігЃ®жє–е‚™е®Њдє†';

  @override
  String get tryAgain => 'г‚‚гЃ†дёЂеє¦и©¦гЃ™';

  @override
  String get uploadChooseFile => 'е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’йЃёжЉћ';

  @override
  String get uploadChooseFileShort => 'гѓ•г‚Ўг‚¤гѓ«г‚’йЃёжЉћ';

  @override
  String get uploadContinueSetup => 'зї»иЁіиЁ­е®љгЃёйЂІг‚Ђ';

  @override
  String get uploadEnglishSource => 'и‹±иЄћг‚Ѕгѓјг‚№';

  @override
  String get uploadFailedFallback =>
      'е€ҐгЃ®е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’гЃЉи©¦гЃ—гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get uploadFailedMessage =>
      'гЃ“гЃ®е­—е№•гѓ•г‚Ўг‚¤гѓ«гЃЇиЄ­гЃїиѕјг‚ЃгЃѕгЃ›г‚“гЃ§гЃ—гЃџгЂ‚е€ҐгЃ®гѓ•г‚Ўг‚¤гѓ«гЃ‹гЂЃг‚€г‚Ље°ЏгЃ•гЃ„ж›ёгЃЌе‡єгЃ—г‚’и©¦гЃ—гЃ¦гЃЏгЃ гЃ•гЃ„гЂ‚';

  @override
  String get uploadFailedTitle =>
      'гѓ•г‚Ўг‚¤гѓ«гЃ®еЏ–г‚ЉиѕјгЃїгЃ«е¤±ж•—гЃ—гЃѕгЃ—гЃџ';

  @override
  String get uploadIntroSubtitle =>
      'и‹±иЄћгЃ® `.srt` гЃѕгЃџгЃЇ `.vtt` гѓ•г‚Ўг‚¤гѓ«г‚’еЏ–г‚ЉиѕјгЃїгЂЃгѓђгѓѓг‚Їг‚Ёгѓігѓ‰гЃ§ж¤њиЁјгѓ»и§ЈжћђгЃ—гЃџгЃ‚гЃЁгЂЃзї»иЁіиЁ­е®љгЃёйЂІгЃїгЃѕгЃ™гЂ‚';

  @override
  String get uploadIntroTitle => 'и‡Єе€†гЃ®е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’дЅїгЃ†';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount иЎЊ';
  }

  @override
  String get uploadMetadataTitle => 'е­—е№•гЃ®и©ізґ°';

  @override
  String get uploadOpeningPicker => 'гѓ”гѓѓг‚«гѓјг‚’й–‹гЃ„гЃ¦гЃ„гЃѕгЃ™...';

  @override
  String get uploadPickSubtitle => 'е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’йЃёгЃ¶';

  @override
  String get uploadPickedFile => 'е­—е№•гѓ•г‚Ўг‚¤гѓ«г‚’йЃёжЉћгЃ—гЃѕгЃ—гЃџ';

  @override
  String get uploadReadyTitle => 'зї»иЁігЃ®жє–е‚™гЃЊгЃ§гЃЌгЃѕгЃ—гЃџ';

  @override
  String get uploadSubtitleTitle => 'е­—е№•г‚’г‚ўгѓѓгѓ—гѓ­гѓјгѓ‰';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'и‹±иЄћгЃ® `.srt` / `.vtt` е­—е№•гѓ•г‚Ўг‚¤гѓ«';

  @override
  String get uploadSupportedFormatsTitle => 'еЇѕеїњеЅўејЏ';

  @override
  String get uploadUseDemoFile => 'гѓ‡гѓўгѓ•г‚Ўг‚¤гѓ«г‚’дЅїгЃ†';
}
