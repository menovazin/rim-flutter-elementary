import 'package:flutter/widgets.dart';

import 'generated/app_localizations.dart';
import 'generated/app_localizations_en.dart';

export 'generated/app_localizations.dart';

final _defaultLocalize = AppLocalizationsEn();

AppLocalizations _getLocalizations(BuildContext context) {
  return AppLocalizations.of(context) ?? _defaultLocalize;
}

extension ContextExt on BuildContext {
  AppLocalizations get strings => _getLocalizations(this);
}
