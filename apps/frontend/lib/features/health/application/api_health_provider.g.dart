// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiHealth)
const apiHealthProvider = ApiHealthProvider._();

final class ApiHealthProvider
    extends
        $FunctionalProvider<
          AsyncValue<ApiHealth>,
          ApiHealth,
          FutureOr<ApiHealth>
        >
    with $FutureModifier<ApiHealth>, $FutureProvider<ApiHealth> {
  const ApiHealthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiHealthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiHealthHash();

  @$internal
  @override
  $FutureProviderElement<ApiHealth> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ApiHealth> create(Ref ref) {
    return apiHealth(ref);
  }
}

String _$apiHealthHash() => r'ce737de3b3c7cb4f3ab7ca39c99c8c069f661c65';
