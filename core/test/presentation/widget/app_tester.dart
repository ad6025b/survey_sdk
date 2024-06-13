import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:survey_sdk/src/presentation/localization/flutter_gen/activity_localizations.dart';

class AppTester extends StatelessWidget {
  final Widget child;

  const AppTester({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        ActivityLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: Scaffold(
        body: child,
      ),
    );
  }
}
