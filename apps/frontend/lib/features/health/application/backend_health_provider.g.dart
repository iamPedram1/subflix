// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backendHealth)
const backendHealthProvider = BackendHealthProvider._();

final class BackendHealthProvider
    extends
        $FunctionalProvider<
          AsyncValue<BackendHealth>,
          BackendHealth,
          FutureOr<BackendHealth>
        >
    with $FutureModifier<BackendHealth>, $FutureProvider<BackendHealth> {
  const BackendHealthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backendHealthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backendHealthHash();

  @$internal
  @override
  $FutureProviderElement<BackendHealth> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BackendHealth> create(Ref ref) {
    return backendHealth(ref);
  }
}

String _$backendHealthHash() => r'd5719a49f1a0ee59dcdfea0689659c33a356a8f1';
