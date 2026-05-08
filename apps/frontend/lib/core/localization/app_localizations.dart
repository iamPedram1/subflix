import 'package:flutter/widgets.dart';
import 'package:subflix/l10n/generated/app_localizations.dart' as generated;

export 'package:subflix/l10n/generated/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  generated.AppLocalizations get t => generated.AppLocalizations.of(this)!;
}
