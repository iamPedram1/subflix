// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'SubFlix';

  @override
  String get authAccountSectionTitle => 'Conta';

  @override
  String get authAlreadySignedInTitle => 'Você já está conectado';

  @override
  String authAlreadySignedInMessage(Object email) {
    return 'Este dispositivo já está conectado como $email.';
  }

  @override
  String get authBackToAccount => 'Voltar para a conta';

  @override
  String get authBackToSignIn => 'Voltar para entrar';

  @override
  String get authCheckInboxTitle => 'Verifique sua caixa de entrada';

  @override
  String get authConfirmEmailAction => 'Confirmar e-mail';

  @override
  String authConfirmEmailHint(Object email) {
    return 'Use o token de verificação enviado para $email.';
  }

  @override
  String get authConfirmEmailSubtitle =>
      'Cole o token de verificação do seu e-mail para concluir a ativação desta conta.';

  @override
  String get authConfirmEmailSuccess =>
      'E-mail confirmado. Agora você pode entrar.';

  @override
  String get authConfirmEmailTitle => 'Verifique seu e-mail';

  @override
  String get authConfirmPasswordLabel => 'Confirmar senha';

  @override
  String get authContinueToReset => 'Continuar para redefinir';

  @override
  String get authContinueWithGoogle => 'Continuar com Google';

  @override
  String get authCreateAccountAction => 'Criar conta';

  @override
  String authDebugTokenLabel(Object token) {
    return 'Token de depuração: $token';
  }

  @override
  String get authDisplayNameLabel => 'Nome de exibição';

  @override
  String get authEmailLabel => 'Endereço de e-mail';

  @override
  String get authEyebrow => 'Espaço seguro';

  @override
  String get authFieldRequired => 'Este campo é obrigatório.';

  @override
  String get authForgotPasswordAction => 'Enviar link de redefinição';

  @override
  String get authForgotPasswordDebugMessage =>
      'Um token de redefinição foi retornado para este ambiente de depuração. Você pode continuar diretamente para o formulário de redefinição.';

  @override
  String get authForgotPasswordLink => 'Esqueceu a senha?';

  @override
  String get authForgotPasswordSubtitle =>
      'Digite seu e-mail e solicitaremos ao backend uma redefinição de senha para esta conta.';

  @override
  String get authForgotPasswordSuccess =>
      'Se a conta existir, uma mensagem de redefinição de senha foi enviada.';

  @override
  String get authForgotPasswordTitle => 'Redefina sua senha';

  @override
  String get authGoogleHelper =>
      'O login com Google usa o Firebase OAuth e funcionará quando este app estiver conectado a um projeto Firebase.';

  @override
  String get authGoogleShortAction => 'Google';

  @override
  String get authHaveAccountLink => 'Já tem uma conta? Entre';

  @override
  String get authInvalidEmail => 'Digite um endereço de e-mail válido.';

  @override
  String get authNewPasswordLabel => 'Nova senha';

  @override
  String get authNoAccountLink => 'Precisa de uma conta? Crie uma';

  @override
  String get authOrDivider => 'ou';

  @override
  String get authPasswordLabel => 'Senha';

  @override
  String get authPasswordMismatch => 'As senhas não correspondem.';

  @override
  String get authPasswordTooShort => 'Use pelo menos 8 caracteres.';

  @override
  String get authProfileRefreshed => 'Dados da conta atualizados.';

  @override
  String get authRefreshProfileAction => 'Atualizar perfil';

  @override
  String get authRefreshProfileSubtitle =>
      'Carregar os dados de perfil mais recentes do backend.';

  @override
  String get authResetPasswordAction => 'Salvar nova senha';

  @override
  String authResetPasswordHint(Object email) {
    return 'Redefina a senha de $email usando o token enviado por e-mail.';
  }

  @override
  String get authResetPasswordSubtitle =>
      'Digite o token de redefinição e escolha uma nova senha para esta conta.';

  @override
  String get authResetPasswordSuccess =>
      'Senha atualizada. Faça login novamente.';

  @override
  String get authResetPasswordTitle => 'Escolha uma nova senha';

  @override
  String get authSignInAction => 'Entrar';

  @override
  String get authSignInSubtitle =>
      'Conecte este app à sua conta SubFlix para sincronizar dados de perfil e desbloquear fluxos autenticados do backend.';

  @override
  String get authSignInSuccess => 'Login realizado com sucesso.';

  @override
  String get authSignInTitle => 'Bem-vindo de volta';

  @override
  String authSignedInCardSubtitle(Object email) {
    return 'Conectado como $email';
  }

  @override
  String get authSignedOutCardSubtitle =>
      'Entre para gerenciar sua conta, usar Firebase OAuth e deixar os recursos autenticados prontos para sincronizações futuras.';

  @override
  String get authSignedOutCardTitle => 'Entre no SubFlix';

  @override
  String get authSignOutAction => 'Sair';

  @override
  String get authSignOutSubtitle =>
      'Revogue a sessão atual deste dispositivo e limpe os tokens locais.';

  @override
  String get authSignOutSuccess => 'Sessão encerrada neste dispositivo.';

  @override
  String get authSignUpAction => 'Criar minha conta';

  @override
  String get authSignUpSubtitle =>
      'Crie uma conta para que este app possa usar o perfil autenticado e os fluxos de sessão do backend.';

  @override
  String get authSignUpSuccess =>
      'Conta criada. Continue com a verificação do e-mail.';

  @override
  String get authSignUpTitle => 'Crie sua conta';

  @override
  String get authVerificationStatusTitle => 'Verificação de e-mail';

  @override
  String get authVerificationTokenLabel => 'Token de verificação';

  @override
  String get authVerifiedStatus => 'Verificado';

  @override
  String get authUnverifiedStatus => 'Verificação pendente';

  @override
  String get brandSubtitleCompact => 'InteligГЄncia de legendas';

  @override
  String get brandSubtitleFull => 'EstГєdio de traduГ§ГЈo de legendas por IA';

  @override
  String get comingSoonMessage => 'Ainda estamos preparando esta tela.';

  @override
  String get comingSoonTitle => 'Em breve';

  @override
  String exportFailedSnack(Object error) {
    return 'Falha na exportaГ§ГЈo: $error';
  }

  @override
  String get exportSubtitleLabel => 'Exportar legenda traduzida';

  @override
  String exportedSnack(Object fileName, Object path) {
    return '$fileName exportado para $path';
  }

  @override
  String get exportingLabel => 'Exportando...';

  @override
  String get heroBadge => 'Fluxo premium de legendas';

  @override
  String get heroBody =>
      'Escolha entre um catГЎlogo pesquisГЎvel ou o envio direto de arquivo, depois visualize e exporte legendas refinadas em poucos minutos.';

  @override
  String get heroHeadline =>
      'Traduza legendas de filmes e sГ©ries com um fluxo de nГ­vel profissional.';

  @override
  String get heroSearchCta => 'Buscar filme / sГ©rie';

  @override
  String get heroStatLanguagesTitle => '10 idiomas';

  @override
  String get heroStatLanguagesValue => 'Prontos para prГ©via';

  @override
  String get heroStatMockTitle => 'APIs mock';

  @override
  String get heroStatMockValue => 'Camada pronta para backend';

  @override
  String get heroStatPathsTitle => '2 caminhos';

  @override
  String get heroStatPathsValue => 'Buscar ou enviar';

  @override
  String get heroSubtitle =>
      'Pesquise catГЎlogos de filmes e sГ©ries, escolha fontes e exporte traduГ§Гµes refinadas em minutos.';

  @override
  String get heroTitle => 'Traduza legendas mais rГЎpido';

  @override
  String get heroUploadCta => 'Enviar legenda';

  @override
  String historyCountLabel(Object count) {
    return '$count traduГ§Гµes';
  }

  @override
  String get historyEmptyMessage =>
      'Seus trabalhos de legenda traduzida aparecerГЈo aqui depois que vocГЄ concluir um fluxo de busca ou envio.';

  @override
  String get historyEmptyTitle => 'O histГіrico estГЎ vazio';

  @override
  String get historyFailedItemMessage =>
      'A traduГ§ГЈo falhou. Toque para comeГ§ar de novo.';

  @override
  String get historyFailedTitle => 'NГЈo foi possГ­vel carregar o histГіrico';

  @override
  String get historyFilterAiTranslated => 'Traduzido por IA';

  @override
  String get historyFilterAll => 'Todos';

  @override
  String get historyFilterCompleted => 'ConcluГ­dos';

  @override
  String get historyFilterFailed => 'Falhou';

  @override
  String get historyFilterMovies => 'Filmes';

  @override
  String get historyFilterReused => 'Reutilizado';

  @override
  String get historyFilterSeries => 'SГ©ries';

  @override
  String get historySubtitle =>
      'Reabra trabalhos anteriores, revise a prГ©via novamente ou exporte depois.';

  @override
  String get historyTitle => 'HistГіrico de traduГ§Гµes';

  @override
  String get homeFailedRecentTitle =>
      'NГЈo foi possГ­vel carregar os trabalhos recentes';

  @override
  String get homeFutureSubtitle =>
      'RepositГіrios mock intercambiГЎveis mantГЄm o cГіdigo de UI protegido contra mudanГ§as no backend.';

  @override
  String get homeFutureTitle => 'RepositГіrios prontos para o futuro';

  @override
  String get homeNoRecentMessage =>
      'Comece com uma busca por filme ou envie um arquivo de legenda e suas traduГ§Гµes recentes aparecerГЈo aqui.';

  @override
  String get homeNoRecentTitle => 'Ainda nГЈo hГЎ trabalhos recentes';

  @override
  String get homePreviewSubtitle =>
      'Analise os resultados antes de exportar nas visualizaГ§Гµes original, traduzida ou bilГ­ngue.';

  @override
  String get homePreviewTitle => 'Fluxo de traduГ§ГЈo guiado por prГ©via';

  @override
  String get homeQuickHistory => 'HistГіrico';

  @override
  String get homeQuickSearch => 'Buscar';

  @override
  String get homeQuickUpload => 'Enviar';

  @override
  String get homeRecentJobsSubtitle =>
      'Reabra suas sessГµes mais recentes sem comeГ§ar do zero.';

  @override
  String get homeRecentJobsTitle => 'Trabalhos recentes';

  @override
  String get homeSearchPlaceholder => 'Buscar filmes ou sГ©ries...';

  @override
  String get homeStatesSubtitle =>
      'Carregamento, vazio, retry, validaГ§ГЈo e cenГЎrios mock offline fazem parte da UX desde o primeiro dia.';

  @override
  String get homeStatesTitle => 'Estados bem resolvidos inclusos';

  @override
  String get homeTrendingNow => 'Em alta agora';

  @override
  String get homeTrustSubtitle =>
      'Hoje ainda Г© mockado, mas jГЎ foi estruturado como um produto real.';

  @override
  String get homeTrustTitle => 'Por que as equipes confiam nisso';

  @override
  String get homeViewAll => 'Ver tudo';

  @override
  String get homeWelcomeSubtitle => 'Encontre e traduza legendas';

  @override
  String get homeWelcomeTitle => 'Bem-vindo de volta';

  @override
  String jobConfidence(Object level) {
    return 'Confiabilidade: $level';
  }

  @override
  String get jobOpenPreview => 'Abrir prГ©via';

  @override
  String get jobReuseSubtitle => 'Reutilizar legenda';

  @override
  String get jobReuseTranslation => 'Reutilizar traduГ§ГЈo';

  @override
  String get legalBodyAbout =>
      'O SubFlix Г© um cliente Flutter com proposta premium para traduГ§ГЈo de legendas por IA. Este build usa repositГіrios mock, latГЄncia artificial e persistГЄncia local para que a UI e a arquitetura evoluam antes da conexГЈo com um backend real.';

  @override
  String get legalBodyPrivacy =>
      'Atualmente, o SubFlix armazena apenas preferГЄncias mock e histГіrico de traduГ§ГЈo no dispositivo por meio de persistГЄncia local. No futuro, uma integraГ§ГЈo com backend pode substituir isso por armazenamento autenticado, trilhas de auditoria e polГ­ticas de retenГ§ГЈo gerenciadas pelo servidor.';

  @override
  String get legalBodySupport =>
      'Por enquanto, o suporte Г© apenas um placeholder. Em uma versГЈo de produГ§ГЈo, esta seГ§ГЈo poderГЎ se conectar a e-mail, relato de problemas e ajuda para contas premium sem alterar a estrutura do app.';

  @override
  String get legalBodyTerms =>
      'Este build mock foi criado para exercitar fluxos de produto, estados de UI e limites de arquitetura. Quando um backend de produГ§ГЈo com NestJS e Postgres for conectado mais tarde, a camada jurГ­dica poderГЎ ser expandida com termos reais de serviГ§o e linguagem de processamento de dados.';

  @override
  String get legalPlaceholderBody =>
      'Esta pГЎgina Г© apenas um placeholder no app de demonstraГ§ГЈo. Conecte-a ao seu conteГєdo jurГ­dico de produГ§ГЈo.';

  @override
  String get legalTitleAbout => 'Sobre o SubFlix';

  @override
  String get legalTitlePrivacy => 'PolГ­tica de privacidade';

  @override
  String get legalTitleSupport => 'Suporte';

  @override
  String get legalTitleTerms => 'Termos de serviГ§o';

  @override
  String get mediaTypeMovie => 'Filme';

  @override
  String get mediaTypeSeries => 'SГ©rie';

  @override
  String get metadataEstimatedDuration => 'DuraГ§ГЈo estimada';

  @override
  String get metadataFormat => 'Formato';

  @override
  String get metadataLanguages => 'Idiomas';

  @override
  String get metadataLines => 'Linhas';

  @override
  String get navHistory => 'HistГіrico';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'ConfiguraГ§Гµes';

  @override
  String get noTitlesMatchedMessage =>
      'NГЈo encontramos esse tГ­tulo no catГЎlogo de teste. Tente uma busca mais ampla ou um dos tГ­tulos sugeridos.';

  @override
  String get noTitlesMatchedTitle => 'Nenhum resultado encontrado';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingEnterApp => 'Entrar no SubFlix';

  @override
  String get onboardingNext => 'PrГіximo';

  @override
  String get onboardingPage1Description =>
      'Pesquise um tГ­tulo, confira as fontes de legenda em inglГЄs disponГ­veis e inicie um fluxo de traduГ§ГЈo que parece imediato.';

  @override
  String get onboardingPage1Eyebrow => 'Buscar e obter';

  @override
  String get onboardingPage1Highlight1 =>
      'CatГЎlogo mock determinГ­stico para desenvolvimento confiГЎvel';

  @override
  String get onboardingPage1Highlight2 =>
      'RГіtulos de qualidade e badges de formato';

  @override
  String get onboardingPage1Highlight3 =>
      'Feito para trocar por um backend real depois';

  @override
  String get onboardingPage1Title =>
      'Encontre filmes ou sГ©ries e puxe legendas prontas para traduzir.';

  @override
  String get onboardingPage2Description =>
      'Importe seu arquivo de legenda, valide o formato e rode o mesmo pipeline refinado sem sair do app.';

  @override
  String get onboardingPage2Eyebrow => 'Use o seu prГіprio arquivo';

  @override
  String get onboardingPage2Highlight1 =>
      'ValidaГ§ГЈo local de arquivo e estados de retry bem resolvidos';

  @override
  String get onboardingPage2Highlight2 =>
      'ConfiguraГ§ГЈo consistente para envio e busca';

  @override
  String get onboardingPage2Highlight3 =>
      'PrГ©via antes de exportar para que nada fique opaco';

  @override
  String get onboardingPage2Title =>
      'Envie arquivos `.srt` ou `.vtt` quando vocГЄ jГЎ tiver o script.';

  @override
  String get onboardingPage3Description =>
      'Alterne entre as visГµes original, traduzida e bilГ­ngue, revisite o histГіrico e exporte arquivos limpos quando o resultado estiver do jeito certo.';

  @override
  String get onboardingPage3Eyebrow => 'Traduzir e exportar';

  @override
  String get onboardingPage3Highlight1 =>
      'Controles rГЎpidos de prГ©via com metadados e busca';

  @override
  String get onboardingPage3Highlight2 =>
      'O histГіrico mantГ©m trabalhos anteriores a um toque de distГўncia';

  @override
  String get onboardingPage3Highlight3 =>
      'Desenhado como uma ferramenta premium de mГ­dia, nГЈo como demo';

  @override
  String get onboardingPage3Title =>
      'Escolha os idiomas de destino, visualize as legendas e exporte na hora.';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingStart => 'Iniciar traduГ§ГЈo';

  @override
  String get previewFailedTitle => 'Falha ao carregar a prГ©via';

  @override
  String get previewModeBilingual => 'BilГ­ngue';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Traduzido';

  @override
  String get previewNoMatchesMessage =>
      'Tente outro termo de busca ou limpe o filtro para analisar a traduГ§ГЈo completa.';

  @override
  String get previewNoMatchesTitle => 'Nenhuma linha da legenda correspondeu';

  @override
  String get previewNotReadyMessage =>
      'A traduГ§ГЈo foi concluГ­da, mas o backend ainda nГЈo retornou os cues de prГ©via. Tente recarregar esta tela em instantes.';

  @override
  String get previewNotReadyTitle =>
      'Os cues de prГ©via ainda nГЈo estГЈo disponГ­veis';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get retryTranslation => 'Refazer traduГ§ГЈo';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'NГЈo conseguimos determinar qual temporada deve ser carregada. Recomece pela busca.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'EpisГіdios da temporada';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'NГЈo conseguimos determinar qual sГ©rie deve ser carregada. Recomece pela busca.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Temporadas da sГ©rie';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'NГЈo conseguimos determinar para qual tГ­tulo as fontes de legenda devem ser carregadas. Recomece pela busca.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Fontes de legenda';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Nenhum pedido de traduГ§ГЈo foi fornecido. Inicie uma nova traduГ§ГЈo pela busca ou pelo envio.';

  @override
  String get routeMissingTranslationProgressTitle => 'Progresso da traduГ§ГЈo';

  @override
  String get routeMissingTranslationSetupMessage =>
      'Г‰ necessГЎrio ter uma fonte de legenda antes de abrir a tela de configuraГ§ГЈo da traduГ§ГЈo.';

  @override
  String get routeMissingTranslationSetupTitle =>
      'ConfiguraГ§ГЈo da traduГ§ГЈo';

  @override
  String get searchFailedTitle => 'A busca falhou';

  @override
  String searchFoundResults(Object count, Object query) {
    return '$count resultados encontrados para \'\'$query\'\'';
  }

  @override
  String get searchHintText => 'Busque por Dune, Breaking Bad, Severance...';

  @override
  String get searchLoadingLabel => 'Buscando...';

  @override
  String get searchMockMessage =>
      'Experimente tГ­tulos como Inception, Dune, Breaking Bad, Severance ou The Last of Us para explorar o fluxo de fontes de legenda.';

  @override
  String get searchMockTitle => 'Pesquise qualquer coisa no catГЎlogo de teste';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Encontre um tГ­tulo, confira as fontes de legenda e inicie uma traduГ§ГЈo com poucos toques.';

  @override
  String get searchMovieOrSeriesTitle => 'Buscar filme ou sГ©rie';

  @override
  String searchNoResultsFor(Object query) {
    return 'Nenhum resultado encontrado para \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularidade $score';
  }

  @override
  String get searchTitles => 'Buscar tГ­tulos';

  @override
  String get searchTrendingTitle => 'Buscas em alta';

  @override
  String get searchTryDifferentKeywords =>
      'Tente buscar com outras palavras-chave.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'EpisГіdio $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Aprox. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount episГіdios$year';
  }

  @override
  String seriesEpisodesTitle(Object seasonNumber) {
    return 'Temporada $seasonNumber';
  }

  @override
  String seriesSeasonLabel(Object seasonNumber) {
    return 'Temporada $seasonNumber';
  }

  @override
  String seriesSeasonMeta(Object episodeCount, Object year) {
    return '$episodeCount episГіdios$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Escolha uma temporada de $title para ver os episГіdios disponГ­veis.';
  }

  @override
  String get seriesSeasonsTitle => 'Escolha uma temporada';

  @override
  String get settingsAboutTitle => 'Sobre o SubFlix';

  @override
  String get settingsCacheCleared => 'Cache limpo';

  @override
  String get settingsClearCache => 'Limpar cache';

  @override
  String get settingsContactTitle => 'Fale conosco';

  @override
  String get settingsFailedTitle => 'Falha ao carregar as configuraГ§Гµes';

  @override
  String get settingsHelpCenterTitle => 'Central de ajuda';

  @override
  String get settingsHistoryClearedSnack =>
      'HistГіrico de traduГ§Гµes apagado neste dispositivo';

  @override
  String get settingsLanguageLabel => 'Idioma de destino preferido';

  @override
  String get settingsMaintenanceSubtitle =>
      'Limpe os trabalhos de traduГ§ГЈo controlados pelo backend neste dispositivo e recomece com o histГіrico vazio.';

  @override
  String get settingsMaintenanceTitle => 'ManutenГ§ГЈo';

  @override
  String get settingsNotificationsSubtitle =>
      'Gerencie as preferГЄncias de notificaГ§ГЈo';

  @override
  String get settingsNotificationsTitle => 'NotificaГ§Гµes';

  @override
  String get settingsPremiumSubtitle =>
      'Depois poderemos conectar aqui assinaturas, cobranГ§a e sincronizaГ§ГЈo de projetos na nuvem.';

  @override
  String get settingsPremiumTitle => 'EspaГ§o premium';

  @override
  String get settingsPrivacySubtitle => 'ConteГєdo mock de privacidade';

  @override
  String get settingsPrivacyTitle => 'PolГ­tica de privacidade';

  @override
  String get settingsProfileName => 'UsuГЎrio SubFlix';

  @override
  String get settingsProfileTier => 'Membro premium';

  @override
  String get settingsSubtitle => 'Gerencie suas preferГЄncias';

  @override
  String get settingsSupportSubtitle => 'PГЎgina mock de ajuda e contato';

  @override
  String get settingsSupportTitle => 'EspaГ§o de suporte';

  @override
  String get settingsTermsSubtitle => 'ConteГєdo mock de termos';

  @override
  String get settingsTermsTitle => 'Termos de serviГ§o';

  @override
  String get settingsThemeLabel => 'AparГЄncia';

  @override
  String get settingsTitle => 'ConfiguraГ§Гµes';

  @override
  String settingsVersion(Object version) {
    return 'VersГЈo $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Preparando seu estГєdio de legendas';

  @override
  String get splashSubtitle => 'TraduГ§ГЈo de legendas com IA';

  @override
  String get startTranslation => 'Iniciar traduГ§ГЈo';

  @override
  String subtitleSourceDownloads(Object downloads) {
    return '$downloads downloads';
  }

  @override
  String subtitleSourceFormatLabel(Object format) {
    return 'Fonte de legenda $format';
  }

  @override
  String get subtitleSourceHiLabel => 'HI / SDH';

  @override
  String subtitleSourceLines(Object lineCount) {
    return '$lineCount linhas';
  }

  @override
  String subtitleSourceRating(Object rating) {
    return 'AvaliaГ§ГЈo $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Selecione uma fonte de legenda e siga para uma configuraГ§ГЈo refinada, ajustada ao timing da legenda.';

  @override
  String get subtitleSourcesBannerTitle => 'TraduГ§ГЈo por IA disponГ­vel';

  @override
  String get subtitleSourcesFailedTitle =>
      'NГЈo foi possГ­vel carregar as fontes de legenda';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Escolha uma fonte de legenda para $title$target e depois selecione o idioma de destino na prГіxima etapa.';
  }

  @override
  String get subtitleSourcesTitle => 'Fontes de legenda em inglГЄs';

  @override
  String get targetLanguage => 'Idioma de destino';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get translateSetupAutoDetect => 'Detectar formato automaticamente';

  @override
  String get translateSetupAutoDetectBody =>
      'Escolhe automaticamente a estrutura certa de saГ­da da legenda.';

  @override
  String get translateSetupLanguageTitle => 'Traduzir para';

  @override
  String get translateSetupOptionsTitle => 'OpГ§Гµes';

  @override
  String get translateSetupPreserveTiming => 'Preservar tempo';

  @override
  String get translateSetupPreserveTimingBody =>
      'MantГ©m os tempos originais da legenda alinhados com o arquivo de origem.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Nosso fluxo vai adaptar esta legenda para $language, preservando o tempo e uma estrutura de cues limpa.';
  }

  @override
  String get translateSetupReadyTitle => 'TraduГ§ГЈo por IA pronta';

  @override
  String get translateSetupSelectLanguage => 'Selecionar idioma';

  @override
  String get translateSetupSourceTitle => 'Legenda de origem';

  @override
  String get translateSetupSubtitle =>
      'Escolha o idioma de destino, revise a fonte da legenda e inicie a traduГ§ГЈo no backend.';

  @override
  String get translateSetupTitle => 'ConfiguraГ§ГЈo da traduГ§ГЈo';

  @override
  String get translationFailedMessage => 'Algo deu errado.';

  @override
  String get translationFailedTitle =>
      'NГЈo foi possГ­vel concluir a traduГ§ГЈo';

  @override
  String get translationPreviewHeader => 'Revise as legendas traduzidas';

  @override
  String get translationPreviewSearchHint => 'Buscar linhas da legenda';

  @override
  String get translationPreviewSubtitle =>
      'Pesquise dentro dos cues, alterne o modo de visualizaГ§ГЈo e exporte quando o resultado estiver certo.';

  @override
  String get translationPreviewTitle => 'PrГ©via da traduГ§ГЈo';

  @override
  String get translationProgressHeadline =>
      'TraduГ§ГЈo de legendas por IA em andamento';

  @override
  String get translationProgressTitle => 'Progresso da traduГ§ГЈo';

  @override
  String get translationResultCompleteSubtitle =>
      'Sua legenda estГЎ pronta para visualizar ou baixar.';

  @override
  String get translationResultCompleteTitle => 'TraduГ§ГЈo concluГ­da';

  @override
  String get translationResultConfidenceLabel => 'Confiabilidade da traduГ§ГЈo';

  @override
  String get translationResultDetailsTitle => 'Detalhes da traduГ§ГЈo';

  @override
  String get translationResultDownloadCta => 'Baixar legenda';

  @override
  String get translationResultHomeCta => 'Voltar para a home';

  @override
  String get translationResultMediaLabel => 'TГ­tulo da mГ­dia';

  @override
  String get translationResultMethodAi => 'Traduzido por IA';

  @override
  String get translationResultMetricsTitle => 'MГ©tricas de qualidade';

  @override
  String get translationResultPreviewCta => 'Visualizar legenda';

  @override
  String translationResultProcessedIn(Object duration) {
    return 'Processado em $duration';
  }

  @override
  String get translationResultSourceLabel => 'Idioma de origem';

  @override
  String get translationResultTargetLabel => 'Idioma de destino';

  @override
  String get translationResultTimingLabel => 'PrecisГЈo do tempo';

  @override
  String get translationResultTimingPreserved => 'Tempo preservado';

  @override
  String get translationResultWarning =>
      'Alguns termos tГ©cnicos ainda podem se beneficiar de uma revisГЈo humana rГЎpida para garantir o contexto.';

  @override
  String get translationStageAligning =>
      'Alinhando timestamps e contexto da cena';

  @override
  String get translationStageGenerating => 'Gerando a traduГ§ГЈo da legenda';

  @override
  String get translationStageIdle => 'Aguardando um pedido de traduГ§ГЈo';

  @override
  String get translationStagePreparing => 'Preparando pacote de legendas';

  @override
  String get translationStageQueued => 'Na fila para traduГ§ГЈo';

  @override
  String get translationStageReadability =>
      'Aplicando revisГЈo de legibilidade';

  @override
  String get translationStageReady => 'TraduГ§ГЈo pronta';

  @override
  String get tryAgain => 'Tente novamente';

  @override
  String get uploadChooseFile => 'Escolher arquivo de legenda';

  @override
  String get uploadChooseFileShort => 'Escolher arquivo';

  @override
  String get uploadContinueSetup =>
      'Continuar para a configuraГ§ГЈo da traduГ§ГЈo';

  @override
  String get uploadEnglishSource => 'Fonte em inglГЄs';

  @override
  String get uploadFailedFallback => 'Tente outro arquivo de legenda.';

  @override
  String get uploadFailedMessage =>
      'NГЈo foi possГ­vel ler este arquivo de legenda. Tente outro arquivo ou uma exportaГ§ГЈo menor.';

  @override
  String get uploadFailedTitle => 'Falha ao importar o arquivo';

  @override
  String get uploadIntroSubtitle =>
      'Importe um arquivo em inglГЄs `.srt` ou `.vtt`, deixe o backend validar e interpretar o conteГєdo e depois siga para a configuraГ§ГЈo da traduГ§ГЈo.';

  @override
  String get uploadIntroTitle => 'Use o seu prГіprio arquivo de legenda';

  @override
  String uploadLineCount(Object lineCount) {
    return '$lineCount linhas';
  }

  @override
  String get uploadMetadataTitle => 'Detalhes da legenda';

  @override
  String get uploadOpeningPicker => 'Abrindo seletor...';

  @override
  String get uploadPickSubtitle => 'Selecionar arquivo de legenda';

  @override
  String get uploadPickedFile => 'Arquivo de legenda selecionado';

  @override
  String get uploadReadyTitle => 'Pronto para traduzir';

  @override
  String get uploadSubtitleTitle => 'Enviar legenda';

  @override
  String get uploadSupportedFormatsSubtitle =>
      'Arquivos de legenda em inglГЄs `.srt` e `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formatos compatГ­veis';

  @override
  String get uploadUseDemoFile => 'Usar arquivo de demonstraГ§ГЈo';
}
