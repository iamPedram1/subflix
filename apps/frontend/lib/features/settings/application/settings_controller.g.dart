// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsController)
const settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider
    extends $AsyncNotifierProvider<SettingsController, UserPreference> {
  const SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();
}

String _$settingsControllerHash() =>
    r'08fb3cc22acbed46a819164b55260aa97e8cbed6';

abstract class _$SettingsController extends $AsyncNotifier<UserPreference> {
  FutureOr<UserPreference> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserPreference>, UserPreference>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserPreference>, UserPreference>,
              AsyncValue<UserPreference>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
