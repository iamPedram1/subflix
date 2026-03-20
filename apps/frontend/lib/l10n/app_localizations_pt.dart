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
  String get brandSubtitleCompact => 'Inteligência de legendas';

  @override
  String get brandSubtitleFull => 'Estúdio de tradução de legendas por IA';

  @override
  String get comingSoonMessage => 'Ainda estamos preparando esta tela.';

  @override
  String get comingSoonTitle => 'Em breve';

  @override
  String exportFailedSnack(Object error) {
    return 'Falha na exportação: $error';
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
      'Escolha entre um catálogo pesquisável ou o envio direto de arquivo, depois visualize e exporte legendas refinadas em poucos minutos.';

  @override
  String get heroHeadline =>
      'Traduza legendas de filmes e séries com um fluxo de nível profissional.';

  @override
  String get heroSearchCta => 'Buscar filme / série';

  @override
  String get heroStatLanguagesTitle => '10 idiomas';

  @override
  String get heroStatLanguagesValue => 'Prontos para prévia';

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
      'Pesquise catálogos de filmes e séries, escolha fontes e exporte traduções refinadas em minutos.';

  @override
  String get heroTitle => 'Traduza legendas mais rápido';

  @override
  String get heroUploadCta => 'Enviar legenda';

  @override
  String historyCountLabel(Object count) {
    return '$count traduções';
  }

  @override
  String get historyEmptyMessage =>
      'Seus trabalhos de legenda traduzida aparecerão aqui depois que você concluir um fluxo de busca ou envio.';

  @override
  String get historyEmptyTitle => 'O histórico está vazio';

  @override
  String get historyFailedItemMessage =>
      'A tradução falhou. Toque para começar de novo.';

  @override
  String get historyFailedTitle => 'Não foi possível carregar o histórico';

  @override
  String get historyFilterAiTranslated => 'Traduzido por IA';

  @override
  String get historyFilterAll => 'Todos';

  @override
  String get historyFilterCompleted => 'Concluídos';

  @override
  String get historyFilterFailed => 'Falhou';

  @override
  String get historyFilterMovies => 'Filmes';

  @override
  String get historyFilterReused => 'Reutilizado';

  @override
  String get historyFilterSeries => 'Séries';

  @override
  String get historySubtitle =>
      'Reabra trabalhos anteriores, revise a prévia novamente ou exporte depois.';

  @override
  String get historyTitle => 'Histórico de traduções';

  @override
  String get homeFailedRecentTitle =>
      'Não foi possível carregar os trabalhos recentes';

  @override
  String get homeFutureSubtitle =>
      'Repositórios mock intercambiáveis mantêm o código de UI protegido contra mudanças no backend.';

  @override
  String get homeFutureTitle => 'Repositórios prontos para o futuro';

  @override
  String get homeNoRecentMessage =>
      'Comece com uma busca por filme ou envie um arquivo de legenda e suas traduções recentes aparecerão aqui.';

  @override
  String get homeNoRecentTitle => 'Ainda não há trabalhos recentes';

  @override
  String get homePreviewSubtitle =>
      'Analise os resultados antes de exportar nas visualizações original, traduzida ou bilíngue.';

  @override
  String get homePreviewTitle => 'Fluxo de tradução guiado por prévia';

  @override
  String get homeQuickHistory => 'Histórico';

  @override
  String get homeQuickSearch => 'Buscar';

  @override
  String get homeQuickUpload => 'Enviar';

  @override
  String get homeRecentJobsSubtitle =>
      'Reabra suas sessões mais recentes sem começar do zero.';

  @override
  String get homeRecentJobsTitle => 'Trabalhos recentes';

  @override
  String get homeSearchPlaceholder => 'Buscar filmes ou séries...';

  @override
  String get homeStatesSubtitle =>
      'Carregamento, vazio, retry, validação e cenários mock offline fazem parte da UX desde o primeiro dia.';

  @override
  String get homeStatesTitle => 'Estados bem resolvidos inclusos';

  @override
  String get homeTrendingNow => 'Em alta agora';

  @override
  String get homeTrustSubtitle =>
      'Hoje ainda é mockado, mas já foi estruturado como um produto real.';

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
  String get jobOpenPreview => 'Abrir prévia';

  @override
  String get jobReuseSubtitle => 'Reutilizar legenda';

  @override
  String get jobReuseTranslation => 'Reutilizar tradução';

  @override
  String get legalBodyAbout =>
      'O SubFlix é um cliente Flutter com proposta premium para tradução de legendas por IA. Este build usa repositórios mock, latência artificial e persistência local para que a UI e a arquitetura evoluam antes da conexão com um backend real.';

  @override
  String get legalBodyPrivacy =>
      'Atualmente, o SubFlix armazena apenas preferências mock e histórico de tradução no dispositivo por meio de persistência local. No futuro, uma integração com backend pode substituir isso por armazenamento autenticado, trilhas de auditoria e políticas de retenção gerenciadas pelo servidor.';

  @override
  String get legalBodySupport =>
      'Por enquanto, o suporte é apenas um placeholder. Em uma versão de produção, esta seção poderá se conectar a e-mail, relato de problemas e ajuda para contas premium sem alterar a estrutura do app.';

  @override
  String get legalBodyTerms =>
      'Este build mock foi criado para exercitar fluxos de produto, estados de UI e limites de arquitetura. Quando um backend de produção com NestJS e Postgres for conectado mais tarde, a camada jurídica poderá ser expandida com termos reais de serviço e linguagem de processamento de dados.';

  @override
  String get legalPlaceholderBody =>
      'Esta página é apenas um placeholder no app de demonstração. Conecte-a ao seu conteúdo jurídico de produção.';

  @override
  String get legalTitleAbout => 'Sobre o SubFlix';

  @override
  String get legalTitlePrivacy => 'Política de privacidade';

  @override
  String get legalTitleSupport => 'Suporte';

  @override
  String get legalTitleTerms => 'Termos de serviço';

  @override
  String get mediaTypeMovie => 'Filme';

  @override
  String get mediaTypeSeries => 'Série';

  @override
  String get metadataEstimatedDuration => 'Duração estimada';

  @override
  String get metadataFormat => 'Formato';

  @override
  String get metadataLanguages => 'Idiomas';

  @override
  String get metadataLines => 'Linhas';

  @override
  String get navHistory => 'Histórico';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Configurações';

  @override
  String get noTitlesMatchedMessage =>
      'Não encontramos esse título no catálogo de teste. Tente uma busca mais ampla ou um dos títulos sugeridos.';

  @override
  String get noTitlesMatchedTitle => 'Nenhum resultado encontrado';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingEnterApp => 'Entrar no SubFlix';

  @override
  String get onboardingNext => 'Próximo';

  @override
  String get onboardingPage1Description =>
      'Pesquise um título, confira as fontes de legenda em inglês disponíveis e inicie um fluxo de tradução que parece imediato.';

  @override
  String get onboardingPage1Eyebrow => 'Buscar e obter';

  @override
  String get onboardingPage1Highlight1 =>
      'Catálogo mock determinístico para desenvolvimento confiável';

  @override
  String get onboardingPage1Highlight2 =>
      'Rótulos de qualidade e badges de formato';

  @override
  String get onboardingPage1Highlight3 =>
      'Feito para trocar por um backend real depois';

  @override
  String get onboardingPage1Title =>
      'Encontre filmes ou séries e puxe legendas prontas para traduzir.';

  @override
  String get onboardingPage2Description =>
      'Importe seu arquivo de legenda, valide o formato e rode o mesmo pipeline refinado sem sair do app.';

  @override
  String get onboardingPage2Eyebrow => 'Use o seu próprio arquivo';

  @override
  String get onboardingPage2Highlight1 =>
      'Validação local de arquivo e estados de retry bem resolvidos';

  @override
  String get onboardingPage2Highlight2 =>
      'Configuração consistente para envio e busca';

  @override
  String get onboardingPage2Highlight3 =>
      'Prévia antes de exportar para que nada fique opaco';

  @override
  String get onboardingPage2Title =>
      'Envie arquivos `.srt` ou `.vtt` quando você já tiver o script.';

  @override
  String get onboardingPage3Description =>
      'Alterne entre as visões original, traduzida e bilíngue, revisite o histórico e exporte arquivos limpos quando o resultado estiver do jeito certo.';

  @override
  String get onboardingPage3Eyebrow => 'Traduzir e exportar';

  @override
  String get onboardingPage3Highlight1 =>
      'Controles rápidos de prévia com metadados e busca';

  @override
  String get onboardingPage3Highlight2 =>
      'O histórico mantém trabalhos anteriores a um toque de distância';

  @override
  String get onboardingPage3Highlight3 =>
      'Desenhado como uma ferramenta premium de mídia, não como demo';

  @override
  String get onboardingPage3Title =>
      'Escolha os idiomas de destino, visualize as legendas e exporte na hora.';

  @override
  String get onboardingSkip => 'Pular';

  @override
  String get onboardingStart => 'Iniciar tradução';

  @override
  String get previewFailedTitle => 'Falha ao carregar a prévia';

  @override
  String get previewModeBilingual => 'Bilíngue';

  @override
  String get previewModeOriginal => 'Original';

  @override
  String get previewModeTranslated => 'Traduzido';

  @override
  String get previewNoMatchesMessage =>
      'Tente outro termo de busca ou limpe o filtro para analisar a tradução completa.';

  @override
  String get previewNoMatchesTitle => 'Nenhuma linha da legenda correspondeu';

  @override
  String get previewNotReadyMessage =>
      'A tradução foi concluída, mas o backend ainda não retornou os cues de prévia. Tente recarregar esta tela em instantes.';

  @override
  String get previewNotReadyTitle =>
      'Os cues de prévia ainda não estão disponíveis';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get retryTranslation => 'Refazer tradução';

  @override
  String get routeMissingSeasonEpisodesMessage =>
      'Não conseguimos determinar qual temporada deve ser carregada. Recomece pela busca.';

  @override
  String get routeMissingSeasonEpisodesTitle => 'Episódios da temporada';

  @override
  String get routeMissingSeriesSeasonsMessage =>
      'Não conseguimos determinar qual série deve ser carregada. Recomece pela busca.';

  @override
  String get routeMissingSeriesSeasonsTitle => 'Temporadas da série';

  @override
  String get routeMissingSubtitleSourcesMessage =>
      'Não conseguimos determinar para qual título as fontes de legenda devem ser carregadas. Recomece pela busca.';

  @override
  String get routeMissingSubtitleSourcesTitle => 'Fontes de legenda';

  @override
  String get routeMissingTranslationProgressMessage =>
      'Nenhum pedido de tradução foi fornecido. Inicie uma nova tradução pela busca ou pelo envio.';

  @override
  String get routeMissingTranslationProgressTitle => 'Progresso da tradução';

  @override
  String get routeMissingTranslationSetupMessage =>
      'É necessário ter uma fonte de legenda antes de abrir a tela de configuração da tradução.';

  @override
  String get routeMissingTranslationSetupTitle => 'Configuração da tradução';

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
      'Experimente títulos como Inception, Dune, Breaking Bad, Severance ou The Last of Us para explorar o fluxo de fontes de legenda.';

  @override
  String get searchMockTitle => 'Pesquise qualquer coisa no catálogo de teste';

  @override
  String get searchMovieOrSeriesSubtitle =>
      'Encontre um título, confira as fontes de legenda e inicie uma tradução com poucos toques.';

  @override
  String get searchMovieOrSeriesTitle => 'Buscar filme ou série';

  @override
  String searchNoResultsFor(Object query) {
    return 'Nenhum resultado encontrado para \'\'$query\'\'';
  }

  @override
  String searchResultPopularity(Object score) {
    return 'Popularidade $score';
  }

  @override
  String get searchTitles => 'Buscar títulos';

  @override
  String get searchTrendingTitle => 'Buscas em alta';

  @override
  String get searchTryDifferentKeywords =>
      'Tente buscar com outras palavras-chave.';

  @override
  String seriesEpisodeLabel(Object episodeNumber) {
    return 'Episódio $episodeNumber';
  }

  @override
  String seriesEpisodeMeta(Object runtime) {
    return 'Aprox. $runtime min';
  }

  @override
  String seriesEpisodesSubtitle(Object episodeCount, Object year) {
    return '$episodeCount episódios$year';
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
    return '$episodeCount episódios$year';
  }

  @override
  String seriesSeasonsSubtitle(Object title) {
    return 'Escolha uma temporada de $title para ver os episódios disponíveis.';
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
  String get settingsFailedTitle => 'Falha ao carregar as configurações';

  @override
  String get settingsHelpCenterTitle => 'Central de ajuda';

  @override
  String get settingsHistoryClearedSnack =>
      'Histórico de traduções apagado neste dispositivo';

  @override
  String get settingsLanguageLabel => 'Idioma de destino preferido';

  @override
  String get settingsMaintenanceSubtitle =>
      'Limpe os trabalhos de tradução controlados pelo backend neste dispositivo e recomece com o histórico vazio.';

  @override
  String get settingsMaintenanceTitle => 'Manutenção';

  @override
  String get settingsNotificationsSubtitle =>
      'Gerencie as preferências de notificação';

  @override
  String get settingsNotificationsTitle => 'Notificações';

  @override
  String get settingsPremiumSubtitle =>
      'Depois poderemos conectar aqui assinaturas, cobrança e sincronização de projetos na nuvem.';

  @override
  String get settingsPremiumTitle => 'Espaço premium';

  @override
  String get settingsPrivacySubtitle => 'Conteúdo mock de privacidade';

  @override
  String get settingsPrivacyTitle => 'Política de privacidade';

  @override
  String get settingsProfileName => 'Usuário SubFlix';

  @override
  String get settingsProfileTier => 'Membro premium';

  @override
  String get settingsSubtitle => 'Gerencie suas preferências';

  @override
  String get settingsSupportSubtitle => 'Página mock de ajuda e contato';

  @override
  String get settingsSupportTitle => 'Espaço de suporte';

  @override
  String get settingsTermsSubtitle => 'Conteúdo mock de termos';

  @override
  String get settingsTermsTitle => 'Termos de serviço';

  @override
  String get settingsThemeLabel => 'Aparência';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String settingsVersion(Object version) {
    return 'Versão $version';
  }

  @override
  String get splashHeadline => 'SubFlix';

  @override
  String get splashPreparing => 'Preparando seu estúdio de legendas';

  @override
  String get splashSubtitle => 'Tradução de legendas com IA';

  @override
  String get startTranslation => 'Iniciar tradução';

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
    return 'Avaliação $rating';
  }

  @override
  String get subtitleSourcesBannerMessage =>
      'Selecione uma fonte de legenda e siga para uma configuração refinada, ajustada ao timing da legenda.';

  @override
  String get subtitleSourcesBannerTitle => 'Tradução por IA disponível';

  @override
  String get subtitleSourcesFailedTitle =>
      'Não foi possível carregar as fontes de legenda';

  @override
  String subtitleSourcesSubtitle(Object title, Object target) {
    return 'Escolha uma fonte de legenda para $title$target e depois selecione o idioma de destino na próxima etapa.';
  }

  @override
  String get subtitleSourcesTitle => 'Fontes de legenda em inglês';

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
      'Escolhe automaticamente a estrutura certa de saída da legenda.';

  @override
  String get translateSetupLanguageTitle => 'Traduzir para';

  @override
  String get translateSetupOptionsTitle => 'Opções';

  @override
  String get translateSetupPreserveTiming => 'Preservar tempo';

  @override
  String get translateSetupPreserveTimingBody =>
      'Mantém os tempos originais da legenda alinhados com o arquivo de origem.';

  @override
  String translateSetupReadyBody(Object language) {
    return 'Nosso fluxo vai adaptar esta legenda para $language, preservando o tempo e uma estrutura de cues limpa.';
  }

  @override
  String get translateSetupReadyTitle => 'Tradução por IA pronta';

  @override
  String get translateSetupSelectLanguage => 'Selecionar idioma';

  @override
  String get translateSetupSourceTitle => 'Legenda de origem';

  @override
  String get translateSetupSubtitle =>
      'Escolha o idioma de destino, revise a fonte da legenda e inicie a tradução no backend.';

  @override
  String get translateSetupTitle => 'Configuração da tradução';

  @override
  String get translationFailedMessage => 'Algo deu errado.';

  @override
  String get translationFailedTitle => 'Não foi possível concluir a tradução';

  @override
  String get translationPreviewHeader => 'Revise as legendas traduzidas';

  @override
  String get translationPreviewSearchHint => 'Buscar linhas da legenda';

  @override
  String get translationPreviewSubtitle =>
      'Pesquise dentro dos cues, alterne o modo de visualização e exporte quando o resultado estiver certo.';

  @override
  String get translationPreviewTitle => 'Prévia da tradução';

  @override
  String get translationProgressHeadline =>
      'Tradução de legendas por IA em andamento';

  @override
  String get translationProgressTitle => 'Progresso da tradução';

  @override
  String get translationResultCompleteSubtitle =>
      'Sua legenda está pronta para visualizar ou baixar.';

  @override
  String get translationResultCompleteTitle => 'Tradução concluída';

  @override
  String get translationResultConfidenceLabel => 'Confiabilidade da tradução';

  @override
  String get translationResultDetailsTitle => 'Detalhes da tradução';

  @override
  String get translationResultDownloadCta => 'Baixar legenda';

  @override
  String get translationResultHomeCta => 'Voltar para a home';

  @override
  String get translationResultMediaLabel => 'Título da mídia';

  @override
  String get translationResultMethodAi => 'Traduzido por IA';

  @override
  String get translationResultMetricsTitle => 'Métricas de qualidade';

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
  String get translationResultTimingLabel => 'Precisão do tempo';

  @override
  String get translationResultTimingPreserved => 'Tempo preservado';

  @override
  String get translationResultWarning =>
      'Alguns termos técnicos ainda podem se beneficiar de uma revisão humana rápida para garantir o contexto.';

  @override
  String get translationStageAligning =>
      'Alinhando timestamps e contexto da cena';

  @override
  String get translationStageGenerating => 'Gerando a tradução da legenda';

  @override
  String get translationStageIdle => 'Aguardando um pedido de tradução';

  @override
  String get translationStagePreparing => 'Preparando pacote de legendas';

  @override
  String get translationStageQueued => 'Na fila para tradução';

  @override
  String get translationStageReadability => 'Aplicando revisão de legibilidade';

  @override
  String get translationStageReady => 'Tradução pronta';

  @override
  String get tryAgain => 'Tente novamente';

  @override
  String get uploadChooseFile => 'Escolher arquivo de legenda';

  @override
  String get uploadChooseFileShort => 'Escolher arquivo';

  @override
  String get uploadContinueSetup => 'Continuar para a configuração da tradução';

  @override
  String get uploadEnglishSource => 'Fonte em inglês';

  @override
  String get uploadFailedFallback => 'Tente outro arquivo de legenda.';

  @override
  String get uploadFailedMessage =>
      'Não foi possível ler este arquivo de legenda. Tente outro arquivo ou uma exportação menor.';

  @override
  String get uploadFailedTitle => 'Falha ao importar o arquivo';

  @override
  String get uploadIntroSubtitle =>
      'Importe um arquivo em inglês `.srt` ou `.vtt`, deixe o backend validar e interpretar o conteúdo e depois siga para a configuração da tradução.';

  @override
  String get uploadIntroTitle => 'Use o seu próprio arquivo de legenda';

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
      'Arquivos de legenda em inglês `.srt` e `.vtt`';

  @override
  String get uploadSupportedFormatsTitle => 'Formatos compatíveis';

  @override
  String get uploadUseDemoFile => 'Usar arquivo de demonstração';
}
