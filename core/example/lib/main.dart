import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      localizationsDelegates: const [
        ActivityLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity example'),
      ),
      // Add Activity to your widget tree with filePath parameter that accepts
      // a json file with parsed activity data
      body: const Activity(
        filePath: 'assets/questions.json',
        onFinish: print,
      ),
    );
  }
}
