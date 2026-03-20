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
  String get authAccountSectionTitle => 'Account';

  @override
  String get authAlreadySignedInTitle => 'You are already signed in';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'This device is already connected as $email.';
  }

  @override
  String get authBackToAccount => 'Back to account';

  @override
  String get authBackToSignIn => 'Back to sign in';

  @override
  String get authCheckInboxTitle => 'Check your inbox';

  @override
  String get authConfirmEmailAction => 'Confirm email';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Use the verification token sent to $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Paste the verification token from your email to finish activating this account.';

  @override
  String get authConfirmEmailSuccess => 'Email confirmed. You can sign in now.';

  @override
  String get authConfirmEmailTitle => 'Verify your email';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authContinueToReset => 'Continue to reset';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authCreateAccountAction => 'Create account';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Debug token: $token';
  }

  @override
  String get authDisplayNameLabel => 'Display name';

  @override
  String get authEmailLabel => 'Email address';

  @override
  String get authEyebrow => 'Secure workspace';

  @override
  String get authFieldRequired => 'This field is required.';

  @override
  String get authForgotPasswordAction => 'Send reset link';

  @override
  String get authForgotPasswordDebugMessage =>
      'A reset token was returned for this debug environment. You can continue directly into the reset form.';

  @override
  String get authForgotPasswordLink => 'Forgot password?';

  @override
  String get authForgotPasswordSubtitle =>
      'Enter your email and we will request a password reset from the backend for this account.';

  @override
  String get authForgotPasswordSuccess =>
      'If the account exists, a password reset message has been sent.';

  @override
  String get authForgotPasswordTitle => 'Reset your password';

  @override
  String get authGoogleHelper =>
      'Google sign-in uses Firebase OAuth and will work once this app is connected to a Firebase project.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'Already have an account? Sign in';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authNewPasswordLabel => 'New password';

  @override
  String get authNoAccountLink => 'Need an account? Create one';

  @override
  String get authOrDivider => 'or';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authPasswordTooShort => 'Use at least 8 characters.';

  @override
  String get authProfileRefreshed => 'Account details refreshed.';

  @override
  String get authRefreshProfileAction => 'Refresh profile';

  @override
  String get authRefreshProfileSubtitle =>
      'Load the latest profile data from the backend.';

  @override
  String get authResetPasswordAction => 'Save new password';

  @override
  String authResetPasswordHint(Object email) {
    return 'Reset the password for $email using the token from your email.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Enter the reset token and choose a new password for this account.';

  @override
  String get authResetPasswordSuccess =>
      'Password updated. Please sign in again.';

  @override
  String get authResetPasswordTitle => 'Choose a new password';

  @override
  String get authSignInAction => 'Sign in';

  @override
  String get authSignInSubtitle =>
      'Connect this app to your SubFlix account to sync profile data and unlock authenticated backend flows.';

  @override
  String get authSignInSuccess => 'Signed in successfully.';

  @override
  String get authSignInTitle => 'Welcome back';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Connected as $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Sign in to manage your account, use Firebase OAuth, and keep authenticated features ready for future sync.';

  @override
  String get authSignedOutCardTitle => 'Sign in to SubFlix';

  @override
  String get authSignOutAction => 'Sign out';

  @override
  String get authSignOutSubtitle =>
      'Revoke the current session for this device and clear local tokens.';

  @override
  String get authSignOutSuccess => 'Signed out on this device.';

  @override
  String get authSignUpAction => 'Create my account';

  @override
  String get authSignUpSubtitle =>
      'Create an account so this app can use the backend\'s authenticated profile and session flows.';

  @override
  String get authSignUpSuccess =>
      'Account created. Continue with email verification.';

  @override
  String get authSignUpTitle => 'Create your account';

  @override
  String get authVerificationStatusTitle => 'Email verification';

  @override
  String get authVerificationTokenLabel => 'Verification token';

  @override
  String get authVerifiedStatus => 'Verified';

  @override
  String get authUnverifiedStatus => 'Verification pending';

  @override
  String get brandSubtitleCompact => '字幕智能';

  @override
  String get brandSubtitleFull => 'AI 字幕翻译工作室';

  @override
  String get comingSoonMessage => '这个页面还在准备中。';

  @override
  String get comingSoonTitle => '即将推出';

  @override
  String exportFailedSnack(Object error) {
    return '导出失败：$error';
  }

  @override
  String get exportSubtitleLabel => '导出翻译后的字幕';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '已将 $fileName 导出到 $path';
  }

  @override
  String get exportingLabel => '正在导出...';

  @override
  String get heroBadge => '高级字幕工作流';

  @override
  String get heroBody => '你可以选择可搜索的片名目录，或直接上传文件，然后在几分钟内完成预览并导出打磨过的字幕。';

  @override
  String get heroHeadline => '用接近工作室级别的流程翻译电影和剧集字幕。';

  @override
  String get heroSearchCta => '搜索电影 / 剧集';

  @override
  String get heroStatLanguagesTitle => '10 种语言';

  @override
  String get heroStatLanguagesValue => '可直接预览';

  @override
  String get heroStatMockTitle => 'Mock API';

  @override
  String get heroStatMockValue => '已为后端接入做好准备';

  @override
  String get heroStatPathsTitle => '2 条路径';

  @override
  String get heroStatPathsValue => '搜索或上传';

  @override
  String get heroSubtitle => '搜索电影和剧集目录、选择来源，并在几分钟内导出打磨过的翻译结果。';

  @override
  String get heroTitle => '更快翻译字幕';

  @override
  String get heroUploadCta => '上传字幕';

  @override
  String historyCountLabel(Object count) {
    return '$count 条翻译';
  }

  @override
  String get historyEmptyMessage => '完成搜索或上传流程后，已翻译的字幕任务会显示在这里。';

  @override
  String get historyEmptyTitle => '历史为空';

  @override
  String get historyFailedItemMessage => '翻译失败。点击重新开始。';

  @override
  String get historyFailedTitle => '无法加载历史记录';

  @override
  String get historyFilterAiTranslated => 'AI 翻译';

  @override
  String get historyFilterAll => '全部';

  @override
  String get historyFilterCompleted => '已完成';

  @override
  String get historyFilterFailed => '失败';

  @override
  String get historyFilterMovies => '电影';

  @override
  String get historyFilterReused => '复用';

  @override
  String get historyFilterSeries => '剧集';

  @override
  String get historySubtitle => '重新打开以前的字幕任务，再次查看预览，或稍后导出。';

  @override
  String get historyTitle => '翻译历史';

  @override
  String get homeFailedRecentTitle => '无法加载最近任务';

  @override
  String get homeFutureSubtitle => '可替换的 mock 仓库让 UI 代码不受后端变化影响。';

  @override
  String get homeFutureTitle => '面向未来的仓库设计';

  @override
  String get homeNoRecentMessage => '先搜索电影或上传字幕文件，你最近的翻译会显示在这里。';

  @override
  String get homeNoRecentTitle => '还没有最近任务';

  @override
  String get homePreviewSubtitle => '可在导出前通过原文、译文或双语视图检查结果。';

  @override
  String get homePreviewTitle => '以预览为先的翻译流程';

  @override
  String get homeQuickHistory => '历史';

  @override
  String get homeQuickSearch => '搜索';

  @override
  String get homeQuickUpload => '上传';

  @override
  String get homeRecentJobsSubtitle => '无需从头开始，直接重新打开你最近的字幕会话。';

  @override
  String get homeRecentJobsTitle => '最近任务';

  @override
  String get homeSearchPlaceholder => '搜索电影或剧集...';

  @override
  String get homeStatesSubtitle => '加载、空状态、重试、校验以及模拟离线场景，从第一天起就是 UX 的一部分。';

  @override
  String get homeStatesTitle => '完善的状态体验';

  @override
  String get homeTrendingNow => '当前热门';

  @override
  String get homeTrustSubtitle => '今天仍是模拟版，但结构已经按真正可上线的产品来设计。';

  @override
  String get homeTrustTitle => '为什么团队会信任它';

  @override
  String get homeViewAll => '查看全部';

  @override
  String get homeWelcomeSubtitle => '查找并翻译字幕';

  @override
  String get homeWelcomeTitle => '欢迎回来';

  @override
  String jobConfidence(Object level) {
    return '可信度：$level';
  }

  @override
  String get jobOpenPreview => '打开预览';

  @override
  String get jobReuseSubtitle => '复用字幕';

  @override
  String get jobReuseTranslation => '复用翻译';

  @override
  String get legalBodyAbout =>
      'SubFlix 是一款偏高级体验的 Flutter 客户端，专注于 AI 字幕翻译。此版本使用 mock 仓库、人工延迟和本地持久化，以便在接入真实后端前先完善 UI 与架构。';

  @override
  String get legalBodyPrivacy =>
      'SubFlix 当前仅通过本地持久化在设备上保存模拟偏好和翻译历史。未来接入后端后，可替换为带身份验证的存储、审计记录以及服务器管理的保留策略。';

  @override
  String get legalBodySupport =>
      '目前支持页只是占位内容。正式版本中，这一部分可以接入邮件、问题反馈以及高级账户支持，同时保持应用框架不变。';

  @override
  String get legalBodyTerms =>
      '这个模拟版本旨在验证产品流程、UI 状态和架构边界。等后续接入正式的 NestJS 与 Postgres 后端后，法律层面可以扩展为真实的服务条款与数据处理说明。';

  @override
  String get legalPlaceholderBody => '此页面在演示应用中只是占位内容。请替换为你正式环境中的法律文本。';

  @override
  String get legalTitleAbout => '关于 SubFlix';

  @override
  String get legalTitlePrivacy => '隐私政策';

  @override
  String get legalTitleSupport => '支持';

  @override
  String get legalTitleTerms => '服务条款';

  @override
  String get mediaTypeMovie => '电影';

  @override
  String get mediaTypeSeries => '剧集';

  @override
  String get metadataEstimatedDuration => '预计时长';

  @override
  String get metadataFormat => '格式';

  @override
  String get metadataLanguages => '语言';

  @override
  String get metadataLines => '行数';

  @override
  String get navHistory => '历史';

  @override
  String get navHome => '首页';

  @override
  String get navSettings => '设置';

  @override
  String get noTitlesMatchedMessage => '我们在模拟目录中找不到这个标题。请尝试更宽泛的搜索，或使用建议标题。';

  @override
  String get noTitlesMatchedTitle => '没有匹配结果';

  @override
  String get onboardingContinue => '继续';

  @override
  String get onboardingEnterApp => '进入 SubFlix';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingPage1Description => '搜索标题、查看可用的英文字幕来源，然后启动一个几乎即时的翻译流程。';

  @override
  String get onboardingPage1Eyebrow => '搜索并获取';

  @override
  String get onboardingPage1Highlight1 => '可预测的模拟目录，方便稳定开发';

  @override
  String get onboardingPage1Highlight2 => '字幕来源质量标签与格式标识';

  @override
  String get onboardingPage1Highlight3 => '后续可无缝切换到真实后端';

  @override
  String get onboardingPage1Title => '找到电影或剧集，并拉取可直接翻译的字幕。';

  @override
  String get onboardingPage2Description => '导入字幕文件、校验格式，并在不离开应用的情况下走完整套精致翻译流程。';

  @override
  String get onboardingPage2Eyebrow => '使用自己的文件';

  @override
  String get onboardingPage2Highlight1 => '本地文件校验与优雅的重试状态';

  @override
  String get onboardingPage2Highlight2 => '上传与搜索保持一致的翻译设置';

  @override
  String get onboardingPage2Highlight3 => '导出前先预览，让结果更透明';

  @override
  String get onboardingPage2Title => '如果你已经有脚本，可直接上传 `.srt` 或 `.vtt` 文件。';

  @override
  String get onboardingPage3Description =>
      '在原文、译文和双语视图之间切换，回看历史记录，并在结果满意后导出干净的字幕文件。';

  @override
  String get onboardingPage3Eyebrow => '翻译并导出';

  @override
  String get onboardingPage3Highlight1 => '带元数据与搜索的快速预览控制';

  @override
  String get onboardingPage3Highlight2 => '历史记录让旧任务始终只差一次点击';

  @override
  String get onboardingPage3Highlight3 => '设计得像高级媒体工具，而不是演示页';

  @override
  String get onboardingPage3Title => '选择目标语言、预览字幕，并立即导出。';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingStart => '开始翻译';

  @override
  String get previewFailedTitle => '预览加载失败';

  @override
  String get previewModeBilingual => '双语';

  @override
  String get previewModeOriginal => '原文';

  @override
  String get previewModeTranslated => '译文';

  @override
  String get previewNoMatchesMessage => '请尝试其他搜索词，或清除筛选以查看完整翻译。';

  @override
  String get previewNoMatchesTitle => '没有匹配的字幕行';

  @override
  String get previewNotReadyMessage => '翻译已完成，但后端尚未返回预览 cue。请稍后重新加载此页面。';

  @override
  String get previewNotReadyTitle => '预览 cue 暂时不可用';

  @override
  String get retry => '重试';

  @override
  String get retryTranslation => '重新翻译';

  @override
  String get routeMissingSeasonEpisodesMessage => '我们无法判断应加载哪一季。请从搜索重新开始。';

  @override
  String get routeMissingSeasonEpisodesTitle => '本季剧集';

  @override
  String get routeMissingSeriesSeasonsMessage => '我们无法判断应加载哪部剧集。请从搜索重新开始。';

  @override
  String get routeMissingSeriesSeasonsTitle => '剧集季列表';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      '我们无法判断应为哪个标题加载字幕来源。请从搜索重新开始。';

  @override
  String get routeMissingSubtitleSourcesTitle => '字幕来源';

  @override
  String get routeMissingTranslationProgressMessage =>
      '没有提供翻译请求。请从搜索或上传开始新的翻译。';

  @override
  String get routeMissingTranslationProgressTitle => '翻译进度';

  @override
  String get routeMissingTranslationSetupMessage => '打开翻译设置页面前，必须先有一个字幕来源。';

  @override
  String get routeMissingTranslationSetupTitle => '翻译设置';

  @override
  String get searchFailedTitle => '搜索失败';

  @override
  String searchFoundResults(Object count, Object query) {
    return '找到 $count 条与“$query”相关的结果';
  }

  @override
  String get searchHintText => '搜索 Dune、Breaking Bad、Severance...';

  @override
  String get searchLoadingLabel => '正在搜索...';

  @override
  String get searchMockMessage =>
      '试试 Inception、Dune、Breaking Bad、Severance 或 The Last of Us，体验字幕来源流程。';

  @override
  String get searchMockTitle => '在模拟目录中搜索任何内容';

  @override
  String get searchMovieOrSeriesSubtitle => '找到片名、查看字幕来源，并通过几次点击启动翻译任务。';

  @override
  String get searchMovieOrSeriesTitle => '搜索电影或剧集';

  @override
  String searchNoResultsFor(Object query) {
    return '没有找到“$query”的结果';
  }

  @override
  String searchResultPopularity(Object score) {
    return '热度 $score';
  }

  @override
  String get searchTitles => '搜索片名';

  @override
  String get searchTrendingTitle => '热门搜索';

  @override
  String get searchTryDifferentKeywords => '试试其他关键词。';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return '第 $episodeNumber 集';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return '约 $runtime 分钟';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount 集$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return '第 $seasonNumber 季';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return '第 $seasonNumber 季';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount 集$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return '选择 $title 的某一季以浏览可用剧集。';
  }

  @override
  String get seriesSeasonsTitle => '选择季';

  @override
  String get settingsAboutTitle => '关于 SubFlix';

  @override
  String get settingsCacheCleared => '缓存已清除';

  @override
  String get settingsClearCache => '清除缓存';

  @override
  String get settingsContactTitle => '联系我们';

  @override
  String get settingsFailedTitle => '设置加载失败';

  @override
  String get settingsHelpCenterTitle => '帮助中心';

  @override
  String get settingsHistoryClearedSnack => '已清除此设备的翻译历史';

  @override
  String get settingsLanguageLabel => '首选目标语言';

  @override
  String get settingsMaintenanceSubtitle => '清除此设备上由后端管理的翻译任务，并从空历史状态重新开始。';

  @override
  String get settingsMaintenanceTitle => '维护';

  @override
  String get settingsNotificationsSubtitle => '管理通知偏好';

  @override
  String get settingsNotificationsTitle => '通知';

  @override
  String get settingsPremiumSubtitle => '后续我们可以在这里接入订阅、计费和云项目同步。';

  @override
  String get settingsPremiumTitle => '高级功能占位';

  @override
  String get settingsPrivacySubtitle => '模拟隐私内容';

  @override
  String get settingsPrivacyTitle => '隐私政策';

  @override
  String get settingsProfileName => 'SubFlix 用户';

  @override
  String get settingsProfileTier => '高级会员';

  @override
  String get settingsSubtitle => '管理你的偏好';

  @override
  String get settingsSupportSubtitle => '模拟帮助与联系页面';

  @override
  String get settingsSupportTitle => '支持占位';

  @override
  String get settingsTermsSubtitle => '模拟条款内容';

  @override
  String get settingsTermsTitle => '服务条款';

  @override
  String get settingsThemeLabel => '外观';

  @override
  String get settingsTitle => '设置';

  @override
  String settingsVersion(Object version) {
    return '版本 $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => '正在准备你的字幕工作室';

  @override
  String get splashSubtitle => 'AI 驱动的字幕翻译';

  @override
  String get startTranslation => '开始翻译';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads 次下载';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format 字幕来源';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount 行';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return '评分 $rating';
  }

  @override
  String get subtitleSourcesBannerMessage => '选择字幕来源后，即可进入针对字幕时间轴优化过的精致翻译设置。';

  @override
  String get subtitleSourcesBannerTitle => '可使用 AI 翻译';

  @override
  String get subtitleSourcesFailedTitle => '无法加载字幕来源';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return '为 $title$target 选择一个字幕来源，然后在下一步选择目标语言。';
  }

  @override
  String get subtitleSourcesTitle => '英文字幕来源';

  @override
  String get targetLanguage => '目标语言';

  @override
  String get themeDark => '深色';

  @override
  String get themeLight => '浅色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get translateSetupAutoDetect => '自动识别格式';

  @override
  String get translateSetupAutoDetectBody => '自动选择合适的字幕输出结构。';

  @override
  String get translateSetupLanguageTitle => '翻译为';

  @override
  String get translateSetupOptionsTitle => '选项';

  @override
  String get translateSetupPreserveTiming => '保留时间轴';

  @override
  String get translateSetupPreserveTimingBody => '让原始字幕时间与源文件保持一致。';

  @override
  String translateSetupReadyBody(Object language) {
    return '我们的翻译流程会将这份字幕转换为 $language，同时保留时间轴并保持清晰的 cue 结构。';
  }

  @override
  String get translateSetupReadyTitle => 'AI 翻译已就绪';

  @override
  String get translateSetupSelectLanguage => '选择语言';

  @override
  String get translateSetupSourceTitle => '源字幕';

  @override
  String get translateSetupSubtitle => '选择目标语言，查看字幕来源，然后启动后端翻译任务。';

  @override
  String get translateSetupTitle => '翻译设置';

  @override
  String get translationFailedMessage => '出了点问题。';

  @override
  String get translationFailedTitle => '翻译未能完成';

  @override
  String get translationPreviewHeader => '查看翻译后的字幕';

  @override
  String get translationPreviewSearchHint => '搜索字幕行';

  @override
  String get translationPreviewSubtitle => '在 cue 中搜索、切换预览模式，并在确认结果无误后导出。';

  @override
  String get translationPreviewTitle => '翻译预览';

  @override
  String get translationProgressHeadline => 'AI 字幕翻译进行中';

  @override
  String get translationProgressTitle => '翻译进度';

  @override
  String get translationResultCompleteSubtitle => '你的字幕已经可以预览或下载。';

  @override
  String get translationResultCompleteTitle => '翻译完成';

  @override
  String get translationResultConfidenceLabel => '翻译可信度';

  @override
  String get translationResultDetailsTitle => '翻译详情';

  @override
  String get translationResultDownloadCta => '下载字幕';

  @override
  String get translationResultHomeCta => '返回首页';

  @override
  String get translationResultMediaLabel => '作品标题';

  @override
  String get translationResultMethodAi => 'AI 翻译';

  @override
  String get translationResultMetricsTitle => '质量指标';

  @override
  String get translationResultPreviewCta => '预览字幕';

  @override
  String translationResultProcessedIn(Object duration) {
    return '处理耗时 $duration';
  }

  @override
  String get translationResultSourceLabel => '源语言';

  @override
  String get translationResultTargetLabel => '目标语言';

  @override
  String get translationResultTimingLabel => '时间精度';

  @override
  String get translationResultTimingPreserved => '时间已保留';

  @override
  String get translationResultWarning => '某些专业术语仍可能需要人工快速复核，以确保语境准确。';

  @override
  String get translationStageAligning => '正在对齐时间戳和场景上下文';

  @override
  String get translationStageGenerating => '正在生成字幕翻译';

  @override
  String get translationStageIdle => '等待翻译请求';

  @override
  String get translationStagePreparing => '正在准备字幕包';

  @override
  String get translationStageQueued => '已加入翻译队列';

  @override
  String get translationStageReadability => '正在进行可读性优化';

  @override
  String get translationStageReady => '翻译已完成';

  @override
  String get tryAgain => '再试一次';

  @override
  String get uploadChooseFile => '选择字幕文件';

  @override
  String get uploadChooseFileShort => '选择文件';

  @override
  String get uploadContinueSetup => '继续进行翻译设置';

  @override
  String get uploadEnglishSource => '英文来源';

  @override
  String get uploadFailedFallback => '请尝试其他字幕文件。';

  @override
  String get uploadFailedMessage => '我们无法读取这个字幕文件。请尝试其他文件，或使用更小的导出文件。';

  @override
  String get uploadFailedTitle => '文件导入失败';

  @override
  String get uploadIntroSubtitle =>
      '导入英文 `.srt` 或 `.vtt` 文件，交给后端校验并解析，然后继续进入翻译设置。';

  @override
  String get uploadIntroTitle => '使用你自己的字幕文件';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount 行';
  }

  @override
  String get uploadMetadataTitle => '字幕详情';

  @override
  String get uploadOpeningPicker => '正在打开选择器...';

  @override
  String get uploadPickSubtitle => '选择字幕文件';

  @override
  String get uploadPickedFile => '已选择字幕文件';

  @override
  String get uploadReadyTitle => '可以开始翻译';

  @override
  String get uploadSubtitleTitle => '上传字幕';

  @override
  String get uploadSupportedFormatsSubtitle => '英文 `.srt` 和 `.vtt` 字幕文件';

  @override
  String get uploadSupportedFormatsTitle => '支持的格式';

  @override
  String get uploadUseDemoFile => '使用演示文件';
}
