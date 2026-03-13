// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recentJobs)
const recentJobsProvider = RecentJobsProvider._();

final class RecentJobsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TranslationJob>>,
          AsyncValue<List<TranslationJob>>,
          AsyncValue<List<TranslationJob>>
        >
    with $Provider<AsyncValue<List<TranslationJob>>> {
  const RecentJobsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentJobsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentJobsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<TranslationJob>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<TranslationJob>> create(Ref ref) {
    return recentJobs(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<TranslationJob>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<TranslationJob>>>(
        value,
      ),
    );
  }
}

String _$recentJobsHash() => r'2d4bc0edd6dbeba50ef8a5ae12a76b10fe2cc4a5';
