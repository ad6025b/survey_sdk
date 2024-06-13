import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:survey_sdk/src/presentation/di/injector.dart';
import 'package:survey_sdk/src/presentation/activity/activity_state.dart';
import 'package:survey_sdk/activity_sdk.dart';

import '../presentation/widget/app_tester.dart';
import '../utils/mocked_entities.dart';

void main() {
  group('Input question page test', () {
    const commonInputQuestionTheme = InputQuestionTheme.common();
    Widget app(List<QuestionData> questions) {
      return AppTester(
        child: Activity(
          activityData: MockedEntities.data2.copyWith(questions: questions),
        ),
      );
    }

    testWidgets('input page with valid data', (tester) async {
      await tester.pumpWidget(app([MockedEntities.input3]));
      final cubit = Injector().activityCubit;

      // click NEXT with valid data
      await tester.enterText(find.byType(TextFormField), '1234');
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 1);
    });

    testWidgets('input page with invalid data', (tester) async {
      await tester.pumpWidget(app([MockedEntities.input3]));
      final cubit = Injector().activityCubit;

      // click NEXT with invalid data
      await tester.enterText(find.byType(TextFormField), 'invalid');
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 1);
    });
    testWidgets(
      'Test input page with email validator',
      (tester) async {
        await tester.pumpWidget(
          app(
            [
              MockedEntities.input1.copyWith(
                validator: InputValidator.email(),
                theme: commonInputQuestionTheme
                    .copyWith(inputType: InputType.email)
                    .lerp(
                      commonInputQuestionTheme,
                      0,
                    ),
              ),
            ],
          ),
        );
        final cubit = Injector().activityCubit;
        final inputField = find.byType(TextFormField);
        final nextButton = find.text('NEXT');
        //final skipButton = find.text('SKIP');

        // click NEXT without data
        await tester.tap(nextButton);
        expect((cubit.state as ActivityLoadedState).answers.length, 0);

        // click NEXT with invalid data
        await tester.enterText(inputField, 'user@gmail');
        await tester.tap(nextButton);
        await tester.pumpAndSettle();
        expect((cubit.state as ActivityLoadedState).answers.length, 0);

        // click NEXT with valid data
        await tester.enterText(inputField, 'user@gmail.com');
        await tester.pumpAndSettle();
        await tester.tap(nextButton);
        expect((cubit.state as ActivityLoadedState).answers.length, 1);
      },
    );

    testWidgets('input page with phone validator', (tester) async {
      await tester.pumpWidget(
        app(
          [
            MockedEntities.input1.copyWith(
              validator: InputValidator.phone(),
              theme: commonInputQuestionTheme.copyWith(
                inputType: InputType.phone,
              ),
            ),
          ],
        ),
      );
      final cubit = Injector().activityCubit;
      final inputField = find.byType(TextFormField);
      final nextButton = find.text('NEXT');

      //press NEXT without data
      await tester.tap(nextButton);
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      //press NEXT with invalid data
      await tester.enterText(inputField, '+375111');
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // press NEXT with valid data
      await tester.enterText(inputField, '+3751111111');
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      expect((cubit.state as ActivityLoadedState).answers.length, 1);
    });

    group('input page with date validator', () {
      testWidgets(
        'input page with date validator (variant: valid date)',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.input1.copyWith(
                  validator: InputValidator.date(),
                  theme: commonInputQuestionTheme.copyWith(
                    inputType: InputType.date,
                  ),
                ),
              ],
            ),
          );
          final inputField = find.byType(DateTimeField);
          final nextButton = find.text('NEXT');
          final cubit = Injector().activityCubit;

          await tester.tap(inputField);
          await tester.pumpAndSettle();
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();
          await tester.tap(nextButton);
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            DateFormat('dd.MM.yyyy').format(
              (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ),
            DateFormat('dd.MM.yyyy').format(DateTime.now()),
          );
        },
      );

      testWidgets(
        'input page with date validator (variant: invalid date)',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.input1.copyWith(
                  validator: InputValidator.date(),
                  theme: commonInputQuestionTheme.copyWith(
                    inputType: InputType.date,
                  ),
                ),
              ],
            ),
          );
          final inputField = find.byType(DateTimeField);
          final editIcon = find.byIcon(Icons.edit);
          final cubit = Injector().activityCubit;

          await tester.tap(inputField);
          await tester.pumpAndSettle();
          await tester.tap(editIcon);
          await tester.pumpAndSettle();

          final textField = find.byType(TextFormField);

          await tester.enterText(textField, 'invalid data');
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();
          expect(find.text('Invalid format.'), findsOneWidget);
          expect((cubit.state as ActivityLoadedState).answers.length, 0);
        },
      );
    });

    testWidgets('input with password validator', (tester) async {
      await tester.pumpWidget(
        app(
          [
            MockedEntities.input1.copyWith(
              validator: InputValidator.password(),
              theme: commonInputQuestionTheme.copyWith(
                inputType: InputType.password,
              ),
            ),
          ],
        ),
      );
      final cubit = Injector().activityCubit;
      final inputField = find.byType(TextFormField);
      final nextButton = find.text('NEXT');
      // click NEXT without data
      await tester.tap(nextButton);
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT with input length < 8
      await tester.enterText(inputField, 'Pass1&');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT without uppercase
      await tester.enterText(inputField, 'password1&');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT without lowercase
      await tester.enterText(inputField, 'PASSWORD1&');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT without digits
      await tester.enterText(inputField, 'Password&');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT without other symbols
      await tester.enterText(inputField, 'Password1');
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect((cubit.state as ActivityLoadedState).answers.length, 0);

      // click NEXT with valid data
      await tester.enterText(inputField, 'Password1&');
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      expect((cubit.state as ActivityLoadedState).answers.length, 1);
    });
  });
}
