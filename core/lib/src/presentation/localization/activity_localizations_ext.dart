import 'package:flutter/material.dart';
import 'package:survey_sdk/src/presentation/localization/flutter_gen/activity_localizations.dart';


extension ActivityLocalizationsExt on BuildContext {
  ActivityLocalizations get localization => ActivityLocalizations.of(this);
}
