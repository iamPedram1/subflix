// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UploadController)
const uploadControllerProvider = UploadControllerProvider._();

final class UploadControllerProvider
    extends $NotifierProvider<UploadController, UploadState> {
  const UploadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadControllerHash();

  @$internal
  @override
  UploadController create() => UploadController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadState>(value),
    );
  }
}

String _$uploadControllerHash() => r'3b0bb8d15cf336eecf92dacd3783aecc546d9e54';

abstract class _$UploadController extends $Notifier<UploadState> {
  UploadState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UploadState, UploadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadState, UploadState>,
              UploadState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
