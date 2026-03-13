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

String _$dioHash() => r'e75df91af5b3c89cff346bb303fa3a99b547ec0d';

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
    r'f275790be09262028d91de1ef7e0338a6f1f598a';

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

String _$historyRepositoryHash() => r'17130f74630db470a6f3f9c08a89cb65e8db51c1';

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

String _$searchRepositoryHash() => r'2fbddbc7a2f19b9a2cc2a87ba49b5bf567ac1c95';

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
    r'10727698805f63727544a3158b382fc27ce6cc41';
