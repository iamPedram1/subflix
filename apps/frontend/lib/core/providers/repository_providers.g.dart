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
    r'156646015e028493dead3b3ff48333c606aa831d';

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

String _$historyRepositoryHash() => r'78cc404e5c81b3cc00eb6793d87afb432ed3af10';

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

String _$searchRepositoryHash() => r'f9bd980f01fc2c056468861b02c3f4fdc5dd3811';

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
    r'ed6b2fd5fc42a1cec3589f881053dec0489182a9';

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
    r'756eb4c79e4efb157788ee618d78877fed8a3e1f';

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
    r'8ae64749558055b9bf321ad46e96b7dfea535534';
