import 'package:survey_sdk/src/presentation/localization/flutter_gen/activity_localizations.dart';

/// The translations for English (`en`).
class ActivityLocalizationsEn extends ActivityLocalizations {
  @override
  String get damagedJson => 'Damaged JSON';

  @override
  String get hideErrorDetails => 'Close details';

  @override
  String get next => 'NEXT';

  @override
  String get showErrorDetails => 'Show details';

  @override
  String get skip => 'SKIP';

  @override
  String get activityLoadError => 'Data is corrupted, activity has not been loaded';

  @override
  String get textField => 'Text field';

  ActivityLocalizationsEn([super.locale = 'en']);
}
