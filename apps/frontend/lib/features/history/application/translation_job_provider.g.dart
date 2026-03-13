// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_job_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(translationJob)
const translationJobProvider = TranslationJobFamily._();

final class TranslationJobProvider
    extends
        $FunctionalProvider<
          AsyncValue<TranslationJob?>,
          TranslationJob?,
          FutureOr<TranslationJob?>
        >
    with $FutureModifier<TranslationJob?>, $FutureProvider<TranslationJob?> {
  const TranslationJobProvider._({
    required TranslationJobFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'translationJobProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$translationJobHash();

  @override
  String toString() {
    return r'translationJobProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TranslationJob?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TranslationJob?> create(Ref ref) {
    final argument = this.argument as String;
    return translationJob(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TranslationJobProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$translationJobHash() => r'ef894661295343a69d60a60467cd47d144d5aff2';

final class TranslationJobFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TranslationJob?>, String> {
  const TranslationJobFamily._()
    : super(
        retry: null,
        name: r'translationJobProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TranslationJobProvider call(String jobId) =>
      TranslationJobProvider._(argument: jobId, from: this);

  @override
  String toString() => r'translationJobProvider';
}
