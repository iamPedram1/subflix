// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'83fa3a6a0f7df530e8e5ccdd5b34f474ef9c9242';

@ProviderFor(apiBaseUrl)
const apiBaseUrlProvider = ApiBaseUrlProvider._();

final class ApiBaseUrlProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const ApiBaseUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiBaseUrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiBaseUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return apiBaseUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$apiBaseUrlHash() => r'77dc5bba93004c423575357f387ca93805600f69';

@ProviderFor(deviceId)
const deviceIdProvider = DeviceIdProvider._();

final class DeviceIdProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const DeviceIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return deviceId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$deviceIdHash() => r'37f380c00b58448ff9e137737191a5b664f82425';

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'84495a2fd65edc4c3eaee99c4665f697f5a999c4';

@ProviderFor(subtitleParser)
const subtitleParserProvider = SubtitleParserProvider._();

final class SubtitleParserProvider
    extends $FunctionalProvider<SubtitleParser, SubtitleParser, SubtitleParser>
    with $Provider<SubtitleParser> {
  const SubtitleParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtitleParserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtitleParserHash();

  @$internal
  @override
  $ProviderElement<SubtitleParser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubtitleParser create(Ref ref) {
    return subtitleParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitleParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitleParser>(value),
    );
  }
}

String _$subtitleParserHash() => r'f616bb7aa20651fae7dcdabc6a296031693ec228';

@ProviderFor(subtitleFormatter)
const subtitleFormatterProvider = SubtitleFormatterProvider._();

final class SubtitleFormatterProvider
    extends
        $FunctionalProvider<
          SubtitleFormatter,
          SubtitleFormatter,
          SubtitleFormatter
        >
    with $Provider<SubtitleFormatter> {
  const SubtitleFormatterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtitleFormatterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtitleFormatterHash();

  @$internal
  @override
  $ProviderElement<SubtitleFormatter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubtitleFormatter create(Ref ref) {
    return subtitleFormatter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitleFormatter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitleFormatter>(value),
    );
  }
}

String _$subtitleFormatterHash() => r'03659ea67c76de4f15d0ca8ca1c081f09abf2692';

@ProviderFor(mockTranslationComposer)
const mockTranslationComposerProvider = MockTranslationComposerProvider._();

final class MockTranslationComposerProvider
    extends
        $FunctionalProvider<
          MockTranslationComposer,
          MockTranslationComposer,
          MockTranslationComposer
        >
    with $Provider<MockTranslationComposer> {
  const MockTranslationComposerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockTranslationComposerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockTranslationComposerHash();

  @$internal
  @override
  $ProviderElement<MockTranslationComposer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MockTranslationComposer create(Ref ref) {
    return mockTranslationComposer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockTranslationComposer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockTranslationComposer>(value),
    );
  }
}

String _$mockTranslationComposerHash() =>
    r'a73e441b35fad233d1377f3d3d9adec982d1c786';

@ProviderFor(mockSearchApi)
const mockSearchApiProvider = MockSearchApiProvider._();

final class MockSearchApiProvider
    extends $FunctionalProvider<MockSearchApi, MockSearchApi, MockSearchApi>
    with $Provider<MockSearchApi> {
  const MockSearchApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockSearchApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockSearchApiHash();

  @$internal
  @override
  $ProviderElement<MockSearchApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockSearchApi create(Ref ref) {
    return mockSearchApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockSearchApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockSearchApi>(value),
    );
  }
}

String _$mockSearchApiHash() => r'09dac09a6d81cea120bb6fcd7b26814206776152';

@ProviderFor(mockTranslationApi)
const mockTranslationApiProvider = MockTranslationApiProvider._();

final class MockTranslationApiProvider
    extends
        $FunctionalProvider<
          MockTranslationApi,
          MockTranslationApi,
          MockTranslationApi
        >
    with $Provider<MockTranslationApi> {
  const MockTranslationApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockTranslationApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockTranslationApiHash();

  @$internal
  @override
  $ProviderElement<MockTranslationApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MockTranslationApi create(Ref ref) {
    return mockTranslationApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockTranslationApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockTranslationApi>(value),
    );
  }
}

String _$mockTranslationApiHash() =>
    r'bd103c28d288310f92051f2e10a19d5b3fff42c1';

@ProviderFor(settingsLocalDataSource)
const settingsLocalDataSourceProvider = SettingsLocalDataSourceProvider._();

final class SettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          SettingsLocalDataSource,
          SettingsLocalDataSource,
          SettingsLocalDataSource
        >
    with $Provider<SettingsLocalDataSource> {
  const SettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<SettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsLocalDataSource create(Ref ref) {
    return settingsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsLocalDataSource>(value),
    );
  }
}

String _$settingsLocalDataSourceHash() =>
    r'1f12d9020fc66019fa70d90b573c70abc5cb1a76';

@ProviderFor(historyLocalDataSource)
const historyLocalDataSourceProvider = HistoryLocalDataSourceProvider._();

final class HistoryLocalDataSourceProvider
    extends
        $FunctionalProvider<
          HistoryLocalDataSource,
          HistoryLocalDataSource,
          HistoryLocalDataSource
        >
    with $Provider<HistoryLocalDataSource> {
  const HistoryLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<HistoryLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HistoryLocalDataSource create(Ref ref) {
    return historyLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryLocalDataSource>(value),
    );
  }
}

String _$historyLocalDataSourceHash() =>
    r'8092aee2f79e0459d87b530054e0ec58c6562820';

@ProviderFor(catalogApi)
const catalogApiProvider = CatalogApiProvider._();

final class CatalogApiProvider
    extends $FunctionalProvider<CatalogApi, CatalogApi, CatalogApi>
    with $Provider<CatalogApi> {
  const CatalogApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'catalogApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$catalogApiHash();

  @$internal
  @override
  $ProviderElement<CatalogApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CatalogApi create(Ref ref) {
    return catalogApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CatalogApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CatalogApi>(value),
    );
  }
}

String _$catalogApiHash() => r'7b68cbb33e48cf33d23634df8b66168cf8f08e04';

@ProviderFor(preferencesApi)
const preferencesApiProvider = PreferencesApiProvider._();

final class PreferencesApiProvider
    extends $FunctionalProvider<PreferencesApi, PreferencesApi, PreferencesApi>
    with $Provider<PreferencesApi> {
  const PreferencesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'preferencesApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$preferencesApiHash();

  @$internal
  @override
  $ProviderElement<PreferencesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PreferencesApi create(Ref ref) {
    return preferencesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreferencesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreferencesApi>(value),
    );
  }
}

String _$preferencesApiHash() => r'1412293b283aed4a6329366d6410ac3b40f9f9f9';

@ProviderFor(translationJobsApi)
const translationJobsApiProvider = TranslationJobsApiProvider._();

final class TranslationJobsApiProvider
    extends
        $FunctionalProvider<
          TranslationJobsApi,
          TranslationJobsApi,
          TranslationJobsApi
        >
    with $Provider<TranslationJobsApi> {
  const TranslationJobsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationJobsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationJobsApiHash();

  @$internal
  @override
  $ProviderElement<TranslationJobsApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TranslationJobsApi create(Ref ref) {
    return translationJobsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TranslationJobsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TranslationJobsApi>(value),
    );
  }
}

String _$translationJobsApiHash() =>
    r'bc9e50f680804c4af19d40e635b89bbb6274fb02';

@ProviderFor(subtitlesApi)
const subtitlesApiProvider = SubtitlesApiProvider._();

final class SubtitlesApiProvider
    extends $FunctionalProvider<SubtitlesApi, SubtitlesApi, SubtitlesApi>
    with $Provider<SubtitlesApi> {
  const SubtitlesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtitlesApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtitlesApiHash();

  @$internal
  @override
  $ProviderElement<SubtitlesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubtitlesApi create(Ref ref) {
    return subtitlesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitlesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitlesApi>(value),
    );
  }
}

String _$subtitlesApiHash() => r'2a3d29b137048e276cc8a83fc992e53fe12a32e5';

@ProviderFor(settingsRepository)
const settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  const SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'9f20952f79fcfdde6742cc4169af4686a80283e0';

@ProviderFor(historyRepository)
const historyRepositoryProvider = HistoryRepositoryProvider._();

final class HistoryRepositoryProvider
    extends
        $FunctionalProvider<
          HistoryRepository,
          HistoryRepository,
          HistoryRepository
        >
    with $Provider<HistoryRepository> {
  const HistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyRepositoryHash();

  @$internal
  @override
  $ProviderElement<HistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HistoryRepository create(Ref ref) {
    return historyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HistoryRepository>(value),
    );
  }
}

String _$historyRepositoryHash() => r'1710ede66898e472d1dc21b4d0cffbd97a6d780e';

@ProviderFor(searchRepository)
const searchRepositoryProvider = SearchRepositoryProvider._();

final class SearchRepositoryProvider
    extends
        $FunctionalProvider<
          SearchRepository,
          SearchRepository,
          SearchRepository
        >
    with $Provider<SearchRepository> {
  const SearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchRepository create(Ref ref) {
    return searchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRepository>(value),
    );
  }
}

String _$searchRepositoryHash() => r'4a606f5973b80427dc5c30ac98c45eb87bd406e9';

@ProviderFor(subtitleImportRepository)
const subtitleImportRepositoryProvider = SubtitleImportRepositoryProvider._();

final class SubtitleImportRepositoryProvider
    extends
        $FunctionalProvider<
          SubtitleImportRepository,
          SubtitleImportRepository,
          SubtitleImportRepository
        >
    with $Provider<SubtitleImportRepository> {
  const SubtitleImportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtitleImportRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtitleImportRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubtitleImportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubtitleImportRepository create(Ref ref) {
    return subtitleImportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitleImportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitleImportRepository>(value),
    );
  }
}

String _$subtitleImportRepositoryHash() =>
    r'148a4028cb1bc2efc18e33f9ac22f4cb12f628f1';

@ProviderFor(subtitleExportRepository)
const subtitleExportRepositoryProvider = SubtitleExportRepositoryProvider._();

final class SubtitleExportRepositoryProvider
    extends
        $FunctionalProvider<
          SubtitleExportRepository,
          SubtitleExportRepository,
          SubtitleExportRepository
        >
    with $Provider<SubtitleExportRepository> {
  const SubtitleExportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtitleExportRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtitleExportRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubtitleExportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubtitleExportRepository create(Ref ref) {
    return subtitleExportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtitleExportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtitleExportRepository>(value),
    );
  }
}

String _$subtitleExportRepositoryHash() =>
    r'5844ecbaad9a4976979ade695e658c68cd06e992';

@ProviderFor(translationRepository)
const translationRepositoryProvider = TranslationRepositoryProvider._();

final class TranslationRepositoryProvider
    extends
        $FunctionalProvider<
          TranslationRepository,
          TranslationRepository,
          TranslationRepository
        >
    with $Provider<TranslationRepository> {
  const TranslationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationRepositoryHash();

  @$internal
  @override
  $ProviderElement<TranslationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TranslationRepository create(Ref ref) {
    return translationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TranslationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TranslationRepository>(value),
    );
  }
}

String _$translationRepositoryHash() =>
    r'e9e659bba93e1e79ecbefefba6968157db736f6e';
