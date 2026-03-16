// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchController)
const searchControllerProvider = SearchControllerProvider._();

final class SearchControllerProvider
    extends $NotifierProvider<SearchController, SearchState> {
  const SearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchControllerHash();

  @$internal
  @override
  SearchController create() => SearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchState>(value),
    );
  }
}

String _$searchControllerHash() => r'f7068de9b4fcf67aa3e5754295f8f53f8058b636';

abstract class _$SearchController extends $Notifier<SearchState> {
  SearchState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SearchState, SearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchState, SearchState>,
              SearchState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
