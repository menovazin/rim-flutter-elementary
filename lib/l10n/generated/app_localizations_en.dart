// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rick and Morty';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Enter any name to explore the multiverse';

  @override
  String get loginNameLabel => 'Username';

  @override
  String get loginSignInButton => 'Sign In';

  @override
  String get tabCharacters => 'Characters';

  @override
  String get tabEpisodes => 'Episodes';

  @override
  String get tabLocations => 'Locations';

  @override
  String get menuSignOut => 'Sign Out';

  @override
  String get detailSpecies => 'Species';

  @override
  String get detailType => 'Type';

  @override
  String get detailGender => 'Gender';

  @override
  String get detailOrigin => 'Origin';

  @override
  String get detailLocation => 'Location';

  @override
  String sectionEpisodesCount(int count) {
    return 'Episodes ($count)';
  }

  @override
  String get retryButton => 'Retry';

  @override
  String get errorLoadingCharacters => 'Error loading characters';
}
