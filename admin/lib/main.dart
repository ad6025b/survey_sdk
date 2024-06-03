import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_admin/presentation/app/app.dart';
import 'package:survey_admin/presentation/app/di/injector.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  if (kIsWeb) {
    html.window.document.onContextMenu.listen((evt) => evt.preventDefault());
  }
  WidgetsFlutterBinding.ensureInitialized();
  initInjector();
  //runApp(const App());
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
