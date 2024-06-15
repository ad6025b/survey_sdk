import 'package:activity_builder/src/presentation/localization/flutter_gen/activity_localizations.dart';
import 'package:flutter/material.dart';


extension ActivityLocalizationsExt on BuildContext {
  ActivityLocalizations get localization => ActivityLocalizations.of(this);
}
