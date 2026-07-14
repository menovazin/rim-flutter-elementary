import '../l10n/generated/app_localizations.dart';
import '../services/app_error.dart';

AppError resolveAppError(Object? error) {
  if (error is AppException) {
    return error.error;
  }

  return const AppError.unknown();
}

extension AppErrorL10n on AppError {
  String localizedMessage(AppLocalizations l10n) {
    return map(
      network: (_) => l10n.errorNetwork,
      server: (_) => l10n.errorServer,
      unknown: (_) => l10n.errorUnknown,
    );
  }
}