// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryController)
const historyControllerProvider = HistoryControllerProvider._();

final class HistoryControllerProvider
    extends $AsyncNotifierProvider<HistoryController, List<TranslationJob>> {
  const HistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @$internal
  @override
  HistoryController create() => HistoryController();
}

String _$historyControllerHash() => r'd8a8df2921495b70d566931cbf6c0e9d75158b26';

abstract class _$HistoryController
    extends $AsyncNotifier<List<TranslationJob>> {
  FutureOr<List<TranslationJob>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TranslationJob>>, List<TranslationJob>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TranslationJob>>,
                List<TranslationJob>
              >,
              AsyncValue<List<TranslationJob>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
