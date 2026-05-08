// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_media_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(catalogMediaDetails)
const catalogMediaDetailsProvider = CatalogMediaDetailsFamily._();

final class CatalogMediaDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<CatalogMediaDetails?>,
          CatalogMediaDetails?,
          FutureOr<CatalogMediaDetails?>
        >
    with
        $FutureModifier<CatalogMediaDetails?>,
        $FutureProvider<CatalogMediaDetails?> {
  const CatalogMediaDetailsProvider._({
    required CatalogMediaDetailsFamily super.from,
    required MovieSearchItem super.argument,
  }) : super(
         retry: null,
         name: r'catalogMediaDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$catalogMediaDetailsHash();

  @override
  String toString() {
    return r'catalogMediaDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CatalogMediaDetails?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CatalogMediaDetails?> create(Ref ref) {
    final argument = this.argument as MovieSearchItem;
    return catalogMediaDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CatalogMediaDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$catalogMediaDetailsHash() =>
    r'624cefeed2a9c1c2ea32b249dde218262a422f22';

final class CatalogMediaDetailsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<CatalogMediaDetails?>,
          MovieSearchItem
        > {
  const CatalogMediaDetailsFamily._()
    : super(
        retry: null,
        name: r'catalogMediaDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CatalogMediaDetailsProvider call(MovieSearchItem item) =>
      CatalogMediaDetailsProvider._(argument: item, from: this);

  @override
  String toString() => r'catalogMediaDetailsProvider';
}
