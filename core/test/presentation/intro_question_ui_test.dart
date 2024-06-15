import 'dart:async';

import 'package:activity_builder/src/domain/entities/question_answer.dart';
import 'package:activity_builder/src/domain/entities/question_types/info_question_data.dart';
import 'package:activity_builder/src/presentation/info_question/info_question_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget/app_tester.dart';

void main() {
  group(
    'Info question widget test',
    () {
      final completerOnMainButtonTap = Completer<void>();
      final completerOnSecondButton = Completer<void>();
      const title = 'Info';
      const mainButtonTitle = 'NEXT';
      const subtitleInCommonData = '';

      final infoQuestionPage = AppTester(
        child: InfoQuestionPage(
          data: const InfoQuestionData.common(),
          onPrimaryButtonTap: ({
            required int index,
            required QuestionAnswer? answer,
          }) =>
              completerOnMainButtonTap.complete(),
          onSecondaryButtonTap: ({
            required int index,
            required QuestionAnswer? answer,
          }) =>
              completerOnSecondButton.complete(),
        ),
      );

      testWidgets(
        'All content widget test',
        (widgetTester) async {
          await widgetTester.pumpWidget(infoQuestionPage);
          expect(find.text(mainButtonTitle), findsOneWidget);
          // TODO(dev): The content of data should located here, but in widget
          // TODO(dev): we passed the subtitle to this place.
          // TODO(dev): Check InfoQuestionPage widget.
          expect(find.text(subtitleInCommonData), findsNothing);
          expect(find.text(title), findsOneWidget);
        },
      );
      testWidgets(
        'Buttons test',
        (widgetTester) async {
          await widgetTester.pumpWidget(infoQuestionPage);
          await widgetTester.tap(find.text(mainButtonTitle));
          await widgetTester.pumpAndSettle();
          expect(completerOnMainButtonTap.isCompleted, isTrue);
        },
      );
    },
  );
}
