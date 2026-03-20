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
  String get brandSubtitleCompact => '字幕インテリジェンス';

  @override
  String get brandSubtitleFull => 'AI字幕翻訳スタジオ';

  @override
  String get comingSoonMessage => 'この画面はまだ準備中です。';

  @override
  String get comingSoonTitle => '近日公開';

  @override
  String exportFailedSnack(Object error) {
    return '書き出しに失敗しました: $error';
  }

  @override
  String get exportSubtitleLabel => '翻訳済み字幕を書き出す';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName を $path に書き出しました';
  }

  @override
  String get exportingLabel => '書き出し中...';

  @override
  String get heroBadge => 'プレミアム字幕ワークフロー';

  @override
  String get heroBody =>
      '検索可能なタイトルカタログか直接ファイルアップロードを選び、数分で洗練された字幕をプレビュー・書き出しできます。';

  @override
  String get heroHeadline => 'スタジオ品質のフローで映画・シリーズ字幕を翻訳。';

  @override
  String get heroSearchCta => '映画 / シリーズを検索';

  @override
  String get heroStatLanguagesTitle => '10言語';

  @override
  String get heroStatLanguagesValue => 'プレビュー可能';

  @override
  String get heroStatMockTitle => 'モックAPI';

  @override
  String get heroStatMockValue => 'バックエンド接続準備済み';

  @override
  String get heroStatPathsTitle => '2つの経路';

  @override
  String get heroStatPathsValue => '検索またはアップロード';

  @override
  String get heroSubtitle => '映画・シリーズのカタログを検索し、ソースを選び、数分で洗練された翻訳を出力できます。';

  @override
  String get heroTitle => '字幕をもっと速く翻訳';

  @override
  String get heroUploadCta => '字幕をアップロード';

  @override
  String historyCountLabel(Object count) {
    return '$count 件の翻訳';
  }

  @override
  String get historyEmptyMessage => '検索またはアップロードの流れを完了すると、翻訳済み字幕ジョブがここに表示されます。';

  @override
  String get historyEmptyTitle => '履歴は空です';

  @override
  String get historyFailedItemMessage => '翻訳に失敗しました。タップしてやり直してください。';

  @override
  String get historyFailedTitle => '履歴を読み込めませんでした';

  @override
  String get historyFilterAiTranslated => 'AI翻訳';

  @override
  String get historyFilterAll => 'すべて';

  @override
  String get historyFilterCompleted => '完了';

  @override
  String get historyFilterFailed => '失敗';

  @override
  String get historyFilterMovies => '映画';

  @override
  String get historyFilterReused => '再利用';

  @override
  String get historyFilterSeries => 'シリーズ';

  @override
  String get historySubtitle => '以前の字幕ジョブを開き直し、再度プレビューしたり、あとで書き出したりできます。';

  @override
  String get historyTitle => '翻訳履歴';

  @override
  String get homeFailedRecentTitle => '最近のジョブを読み込めませんでした';

  @override
  String get homeFutureSubtitle =>
      '差し替え可能なモックリポジトリにより、UIコードはバックエンド変更の影響を受けにくくなります。';

  @override
  String get homeFutureTitle => '将来対応のリポジトリ';

  @override
  String get homeNoRecentMessage =>
      '映画検索を始めるか字幕ファイルをアップロードすると、最近の翻訳がここに表示されます。';

  @override
  String get homeNoRecentTitle => '最近のジョブはまだありません';

  @override
  String get homePreviewSubtitle => '書き出し前に、原文・翻訳・バイリンガル表示で結果を確認できます。';

  @override
  String get homePreviewTitle => 'プレビュー重視の翻訳フロー';

  @override
  String get homeQuickHistory => '履歴';

  @override
  String get homeQuickSearch => '検索';

  @override
  String get homeQuickUpload => 'アップロード';

  @override
  String get homeRecentJobsSubtitle => '最初からやり直さずに、最新の字幕セッションを開き直せます。';

  @override
  String get homeRecentJobsTitle => '最近のジョブ';

  @override
  String get homeSearchPlaceholder => '映画やシリーズを検索...';

  @override
  String get homeStatesSubtitle =>
      '読み込み、空状態、再試行、検証、モックのオフライン状態まで初日からUXに含まれています。';

  @override
  String get homeStatesTitle => '丁寧な状態設計込み';

  @override
  String get homeTrendingNow => '今のトレンド';

  @override
  String get homeTrustSubtitle => '今はモックでも、実運用できる製品のように設計されています。';

  @override
  String get homeTrustTitle => 'チームに信頼される理由';

  @override
  String get homeViewAll => 'すべて見る';

  @override
  String get homeWelcomeSubtitle => '字幕を見つけて翻訳';

  @override
  String get homeWelcomeTitle => 'おかえりなさい';

  @override
  String jobConfidence(Object level) {
    return '信頼度: $level';
  }

  @override
  String get jobOpenPreview => 'プレビューを開く';

  @override
  String get jobReuseSubtitle => '字幕を再利用';

  @override
  String get jobReuseTranslation => '翻訳を再利用';

  @override
  String get legalBodyAbout =>
      'SubFlix は AI 字幕翻訳向けのプレミアム志向 Flutter クライアントです。このビルドでは、実際のバックエンド接続前に UI とアーキテクチャを育てるため、モックリポジトリ、人工的な遅延、ローカル保存を使っています。';

  @override
  String get legalBodyPrivacy =>
      'SubFlix は現在、モックの設定と翻訳履歴のみをローカル保存しています。将来的なバックエンド連携により、認証付き保存、監査ログ、サーバー管理の保持ポリシーへ置き換えられます。';

  @override
  String get legalBodySupport =>
      'サポートは現在プレースホルダーです。本番では、アプリ構造を変えずにメール、問題報告、プレミアム会員向け支援へ接続できます。';

  @override
  String get legalBodyTerms =>
      'このモックビルドは、製品フロー、UI状態、アーキテクチャ境界を検証するためのものです。将来 NestJS と Postgres の本番バックエンドが接続されれば、実際の利用規約やデータ処理文言を追加できます。';

  @override
  String get legalPlaceholderBody =>
      'このページはデモアプリ内のプレースホルダーです。本番用の法的コンテンツに差し替えてください。';

  @override
  String get legalTitleAbout => 'SubFlix について';

  @override
  String get legalTitlePrivacy => 'プライバシーポリシー';

  @override
  String get legalTitleSupport => 'サポート';

  @override
  String get legalTitleTerms => '利用規約';

  @override
  String get mediaTypeMovie => '映画';

  @override
  String get mediaTypeSeries => 'シリーズ';

  @override
  String get metadataEstimatedDuration => '推定時間';

  @override
  String get metadataFormat => '形式';

  @override
  String get metadataLanguages => '言語';

  @override
  String get metadataLines => '行数';

  @override
  String get navHistory => '履歴';

  @override
  String get navHome => 'ホーム';

  @override
  String get navSettings => '設定';

  @override
  String get noTitlesMatchedMessage =>
      'このタイトルはモックカタログで見つかりませんでした。より広い条件で検索するか、候補のタイトルを試してください。';

  @override
  String get noTitlesMatchedTitle => '一致する結果がありません';

  @override
  String get onboardingContinue => '続ける';

  @override
  String get onboardingEnterApp => 'SubFlix に入る';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingPage1Description =>
      'タイトルを検索し、利用可能な英語字幕ソースを確認して、すぐに使える翻訳フローを開始できます。';

  @override
  String get onboardingPage1Eyebrow => '検索して取得';

  @override
  String get onboardingPage1Highlight1 => '開発しやすい決定論的モックカタログ';

  @override
  String get onboardingPage1Highlight2 => '字幕ソースの品質ラベルと形式バッジ';

  @override
  String get onboardingPage1Highlight3 => '後から実バックエンドへ差し替え可能';

  @override
  String get onboardingPage1Title => '映画やシリーズを探して、すぐ翻訳できる字幕を取得。';

  @override
  String get onboardingPage2Description =>
      '字幕ファイルを取り込み、形式を検証し、同じ洗練された翻訳パイプラインをアプリ内で実行できます。';

  @override
  String get onboardingPage2Eyebrow => '自分のファイルを使う';

  @override
  String get onboardingPage2Highlight1 => 'ローカル検証と丁寧な再試行状態';

  @override
  String get onboardingPage2Highlight2 => '検索とアップロードで一貫した設定';

  @override
  String get onboardingPage2Highlight3 => '不透明さをなくすため、書き出し前に確認';

  @override
  String get onboardingPage2Title => 'すでに台本があるなら `.srt` / `.vtt` をアップロード。';

  @override
  String get onboardingPage3Description =>
      '原文・翻訳・バイリンガル表示を切り替え、履歴を見返し、仕上がりに納得したらきれいな字幕ファイルを書き出せます。';

  @override
  String get onboardingPage3Eyebrow => '翻訳して書き出す';

  @override
  String get onboardingPage3Highlight1 => 'メタデータと検索付きの高速プレビュー操作';

  @override
  String get onboardingPage3Highlight2 => '履歴から以前のジョブにすぐ戻れる';

  @override
  String get onboardingPage3Highlight3 => 'デモではなく、プレミアムなメディアツールのような設計';

  @override
  String get onboardingPage3Title => '対象言語を選び、字幕を確認して、すぐ書き出し。';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingStart => '翻訳を始める';

  @override
  String get previewFailedTitle => 'プレビューの読み込みに失敗しました';

  @override
  String get previewModeBilingual => 'バイリンガル';

  @override
  String get previewModeOriginal => '原文';

  @override
  String get previewModeTranslated => '翻訳文';

  @override
  String get previewNoMatchesMessage => '別の検索語を試すか、フィルターを解除して全文を確認してください。';

  @override
  String get previewNoMatchesTitle => '一致する字幕行がありません';

  @override
  String get previewNotReadyMessage =>
      '翻訳は完了しましたが、バックエンドからプレビュー cue がまだ返ってきていません。少し待って再読み込みしてください。';

  @override
  String get previewNotReadyTitle => 'プレビュー用 cue はまだ利用できません';

  @override
  String get retry => '再試行';

  @override
  String get retryTranslation => '翻訳を再試行';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'どのシーズンを読み込むべきか判断できませんでした。検索からやり直してください。';

  @override
  String get routeMissingSeasonEpisodesTitle => 'シーズンのエピソード';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'どのシリーズを読み込むべきか判断できませんでした。検索からやり直してください。';

  @override
  String get routeMissingSeriesSeasonsTitle => 'シリーズのシーズン';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'どのタイトルの字幕ソースを読み込むべきか判断できませんでした。検索からやり直してください。';

  @override
  String get routeMissingSubtitleSourcesTitle => '字幕ソース';

  @override
  String get routeMissingTranslationProgressMessage =>
      '翻訳リクエストがありません。検索またはアップロードから新しい翻訳を始めてください。';

  @override
  String get routeMissingTranslationProgressTitle => '翻訳の進行状況';

  @override
  String get routeMissingTranslationSetupMessage => '翻訳設定画面を開く前に字幕ソースが必要です。';

  @override
  String get routeMissingTranslationSetupTitle => '翻訳設定';

  @override
  String get searchFailedTitle => '検索に失敗しました';

  @override
  String searchFoundResults(Object count, Object query) {
    return '\"$query\" の結果が $count 件見つかりました';
  }

  @override
  String get searchHintText => 'Dune、Breaking Bad、Severance などを検索...';

  @override
  String get searchLoadingLabel => '検索中...';

  @override
  String get searchMockMessage =>
      'Inception、Dune、Breaking Bad、Severance、The Last of Us などを試して、字幕ソースの流れを確認してください。';

  @override
  String get searchMockTitle => 'モックカタログ内を検索';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'タイトルを見つけて字幕ソースを確認し、数回のタップで翻訳ジョブを開始できます。';

  @override
  String get searchMovieOrSeriesTitle => '映画・シリーズを検索';

  @override
  String searchNoResultsFor(Object query) {
    return '\"$query\" の結果は見つかりませんでした';
  }

  @override
  String searchResultPopularity(Object score) {
    return '人気度 $score';
  }

  @override
  String get searchTitles => 'タイトルを検索';

  @override
  String get searchTrendingTitle => '人気の検索';

  @override
  String get searchTryDifferentKeywords => '別のキーワードで検索してみてください。';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'エピソード $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return '約 $runtime 分';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount 話$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'シーズン $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'シーズン $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount 話$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return '$title のシーズンを選んで、利用可能なエピソードを確認してください。';
  }

  @override
  String get seriesSeasonsTitle => 'シーズンを選択';

  @override
  String get settingsAboutTitle => 'SubFlix について';

  @override
  String get settingsCacheCleared => 'キャッシュを消去しました';

  @override
  String get settingsClearCache => 'キャッシュを消去';

  @override
  String get settingsContactTitle => 'お問い合わせ';

  @override
  String get settingsFailedTitle => '設定を読み込めませんでした';

  @override
  String get settingsHelpCenterTitle => 'ヘルプセンター';

  @override
  String get settingsHistoryClearedSnack => 'この端末の翻訳履歴を消去しました';

  @override
  String get settingsLanguageLabel => '優先する翻訳先言語';

  @override
  String get settingsMaintenanceSubtitle =>
      'この端末のバックエンド管理翻訳ジョブを消去し、履歴を空の状態から始めます。';

  @override
  String get settingsMaintenanceTitle => 'メンテナンス';

  @override
  String get settingsNotificationsSubtitle => '通知設定を管理';

  @override
  String get settingsNotificationsTitle => '通知';

  @override
  String get settingsPremiumSubtitle => '今後、購読・請求・クラウドプロジェクト同期をここに接続できます。';

  @override
  String get settingsPremiumTitle => 'プレミアム用プレースホルダー';

  @override
  String get settingsPrivacySubtitle => 'モックのプライバシー内容';

  @override
  String get settingsPrivacyTitle => 'プライバシーポリシー';

  @override
  String get settingsProfileName => 'SubFlix ユーザー';

  @override
  String get settingsProfileTier => 'プレミアム会員';

  @override
  String get settingsSubtitle => '好みを管理';

  @override
  String get settingsSupportSubtitle => 'モックのヘルプ・問い合わせページ';

  @override
  String get settingsSupportTitle => 'サポート用プレースホルダー';

  @override
  String get settingsTermsSubtitle => 'モックの規約内容';

  @override
  String get settingsTermsTitle => '利用規約';

  @override
  String get settingsThemeLabel => '外観';

  @override
  String get settingsTitle => '設定';

  @override
  String settingsVersion(Object version) {
    return 'バージョン $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'あなたの字幕スタジオを準備中';

  @override
  String get splashSubtitle => 'AIによる字幕翻訳';

  @override
  String get startTranslation => '翻訳を開始';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads ダウンロード';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return '$format 字幕ソース';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount 行';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return '評価 $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      '字幕ソースを選択すると、字幕タイミングに最適化された翻訳設定へ進みます。';

  @override
  String get subtitleSourcesBannerTitle => 'AI翻訳が利用できます';

  @override
  String get subtitleSourcesFailedTitle => '字幕ソースを読み込めませんでした';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return '$title$target の字幕ソースを選び、次のステップで対象言語を選択してください。';
  }

  @override
  String get subtitleSourcesTitle => '英語字幕ソース';

  @override
  String get targetLanguage => '対象言語';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeSystem => 'システム';

  @override
  String get translateSetupAutoDetect => '形式を自動検出';

  @override
  String get translateSetupAutoDetectBody => '字幕の出力構造を自動で最適化します。';

  @override
  String get translateSetupLanguageTitle => '翻訳先';

  @override
  String get translateSetupOptionsTitle => 'オプション';

  @override
  String get translateSetupPreserveTiming => 'タイミングを保持';

  @override
  String get translateSetupPreserveTimingBody => '元ファイルに合わせて字幕のタイミングを維持します。';

  @override
  String translateSetupReadyBody(Object language) {
    return 'この字幕は、タイミングと cue 構造を保ったまま $language に変換されます。';
  }

  @override
  String get translateSetupReadyTitle => 'AI翻訳の準備完了';

  @override
  String get translateSetupSelectLanguage => '言語を選択';

  @override
  String get translateSetupSourceTitle => '元の字幕';

  @override
  String get translateSetupSubtitle =>
      '対象言語を選び、字幕ソースを確認してから、バックエンド翻訳ジョブを開始します。';

  @override
  String get translateSetupTitle => '翻訳設定';

  @override
  String get translationFailedMessage => '問題が発生しました。';

  @override
  String get translationFailedTitle => '翻訳を完了できませんでした';

  @override
  String get translationPreviewHeader => '翻訳された字幕を確認';

  @override
  String get translationPreviewSearchHint => '字幕行を検索';

  @override
  String get translationPreviewSubtitle =>
      'cue 内を検索し、表示モードを切り替え、納得できたら書き出してください。';

  @override
  String get translationPreviewTitle => '翻訳プレビュー';

  @override
  String get translationProgressHeadline => 'AI字幕翻訳を実行中です';

  @override
  String get translationProgressTitle => '翻訳の進行状況';

  @override
  String get translationResultCompleteSubtitle =>
      '字幕はプレビューまたはダウンロードの準備ができています。';

  @override
  String get translationResultCompleteTitle => '翻訳が完了しました';

  @override
  String get translationResultConfidenceLabel => '翻訳の信頼度';

  @override
  String get translationResultDetailsTitle => '翻訳の詳細';

  @override
  String get translationResultDownloadCta => '字幕をダウンロード';

  @override
  String get translationResultHomeCta => 'ホームに戻る';

  @override
  String get translationResultMediaLabel => '作品タイトル';

  @override
  String get translationResultMethodAi => 'AIで翻訳済み';

  @override
  String get translationResultMetricsTitle => '品質指標';

  @override
  String get translationResultPreviewCta => '字幕をプレビュー';

  @override
  String translationResultProcessedIn(Object duration) {
    return '$duration で処理完了';
  }

  @override
  String get translationResultSourceLabel => '元の言語';

  @override
  String get translationResultTargetLabel => '翻訳先の言語';

  @override
  String get translationResultTimingLabel => 'タイミング精度';

  @override
  String get translationResultTimingPreserved => 'タイミング保持';

  @override
  String get translationResultWarning => '一部の専門用語は、文脈確認のために人の軽い見直しがあるとより安心です。';

  @override
  String get translationStageAligning => 'タイムスタンプとシーン文脈を調整中';

  @override
  String get translationStageGenerating => '字幕翻訳を生成中';

  @override
  String get translationStageIdle => '翻訳リクエストを待機中';

  @override
  String get translationStagePreparing => '字幕パッケージを準備中';

  @override
  String get translationStageQueued => '翻訳待ちキューに入りました';

  @override
  String get translationStageReadability => '読みやすさ調整を適用中';

  @override
  String get translationStageReady => '翻訳の準備完了';

  @override
  String get tryAgain => 'もう一度試す';

  @override
  String get uploadChooseFile => '字幕ファイルを選択';

  @override
  String get uploadChooseFileShort => 'ファイルを選択';

  @override
  String get uploadContinueSetup => '翻訳設定へ進む';

  @override
  String get uploadEnglishSource => '英語ソース';

  @override
  String get uploadFailedFallback => '別の字幕ファイルをお試しください。';

  @override
  String get uploadFailedMessage =>
      'この字幕ファイルは読み込めませんでした。別のファイルか、より小さい書き出しを試してください。';

  @override
  String get uploadFailedTitle => 'ファイルの取り込みに失敗しました';

  @override
  String get uploadIntroSubtitle =>
      '英語の `.srt` または `.vtt` ファイルを取り込み、バックエンドで検証・解析したあと、翻訳設定へ進みます。';

  @override
  String get uploadIntroTitle => '自分の字幕ファイルを使う';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount 行';
  }

  @override
  String get uploadMetadataTitle => '字幕の詳細';

  @override
  String get uploadOpeningPicker => 'ピッカーを開いています...';

  @override
  String get uploadPickSubtitle => '字幕ファイルを選ぶ';

  @override
  String get uploadPickedFile => '字幕ファイルを選択しました';

  @override
  String get uploadReadyTitle => '翻訳の準備ができました';

  @override
  String get uploadSubtitleTitle => '字幕をアップロード';

  @override
  String get uploadSupportedFormatsSubtitle => '英語の `.srt` / `.vtt` 字幕ファイル';

  @override
  String get uploadSupportedFormatsTitle => '対応形式';

  @override
  String get uploadUseDemoFile => 'デモファイルを使う';
}
