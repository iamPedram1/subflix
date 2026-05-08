// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_preview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(translationPreview)
const translationPreviewProvider = TranslationPreviewFamily._();

final class TranslationPreviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<TranslationPreviewPage>,
          TranslationPreviewPage,
          FutureOr<TranslationPreviewPage>
        >
    with
        $FutureModifier<TranslationPreviewPage>,
        $FutureProvider<TranslationPreviewPage> {
  const TranslationPreviewProvider._({
    required TranslationPreviewFamily super.from,
    required TranslationPreviewQuery super.argument,
  }) : super(
         retry: null,
         name: r'translationPreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$translationPreviewHash();

  @override
  String toString() {
    return r'translationPreviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TranslationPreviewPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TranslationPreviewPage> create(Ref ref) {
    final argument = this.argument as TranslationPreviewQuery;
    return translationPreview(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TranslationPreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$translationPreviewHash() =>
    r'bef8f2b5591b5b602d0eb768c89fd56078799295';

final class TranslationPreviewFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<TranslationPreviewPage>,
          TranslationPreviewQuery
        > {
  const TranslationPreviewFamily._()
    : super(
        retry: null,
        name: r'translationPreviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TranslationPreviewProvider call(TranslationPreviewQuery request) =>
      TranslationPreviewProvider._(argument: request, from: this);

  @override
  String toString() => r'translationPreviewProvider';
}
