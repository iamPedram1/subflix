// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TranslationFlowController)
const translationFlowControllerProvider = TranslationFlowControllerProvider._();

final class TranslationFlowControllerProvider
    extends $NotifierProvider<TranslationFlowController, TranslationFlowState> {
  const TranslationFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'translationFlowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$translationFlowControllerHash();

  @$internal
  @override
  TranslationFlowController create() => TranslationFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TranslationFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TranslationFlowState>(value),
    );
  }
}

String _$translationFlowControllerHash() =>
    r'd07416987bc8b0d778071580b2e3ce938a510caa';

abstract class _$TranslationFlowController
    extends $Notifier<TranslationFlowState> {
  TranslationFlowState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TranslationFlowState, TranslationFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TranslationFlowState, TranslationFlowState>,
              TranslationFlowState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
