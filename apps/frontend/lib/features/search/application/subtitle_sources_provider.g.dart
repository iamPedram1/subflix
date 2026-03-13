// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_sources_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(subtitleSources)
const subtitleSourcesProvider = SubtitleSourcesFamily._();

final class SubtitleSourcesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SubtitleSource>>,
          List<SubtitleSource>,
          FutureOr<List<SubtitleSource>>
        >
    with
        $FutureModifier<List<SubtitleSource>>,
        $FutureProvider<List<SubtitleSource>> {
  const SubtitleSourcesProvider._({
    required SubtitleSourcesFamily super.from,
    required MovieSearchItem super.argument,
  }) : super(
         retry: null,
         name: r'subtitleSourcesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$subtitleSourcesHash();

  @override
  String toString() {
    return r'subtitleSourcesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SubtitleSource>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SubtitleSource>> create(Ref ref) {
    final argument = this.argument as MovieSearchItem;
    return subtitleSources(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SubtitleSourcesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$subtitleSourcesHash() => r'27e5d7022689b044357f2de8d29acfd78937e37c';

final class SubtitleSourcesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SubtitleSource>>,
          MovieSearchItem
        > {
  const SubtitleSourcesFamily._()
    : super(
        retry: null,
        name: r'subtitleSourcesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SubtitleSourcesProvider call(MovieSearchItem item) =>
      SubtitleSourcesProvider._(argument: item, from: this);

  @override
  String toString() => r'subtitleSourcesProvider';
}
