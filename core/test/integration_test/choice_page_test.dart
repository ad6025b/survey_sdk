import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/presentation/activity/activity_state.dart';
import 'package:activity_builder/src/presentation/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../presentation/widget/app_tester.dart';
import '../utils/mocked_entities.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'Choice question page test',
    () {
      Widget app(List<QuestionData> questions) {
        return AppTester(
          child: Activity(
            activityData: MockedEntities.data2.copyWith(questions: questions),
          ),
        );
      }

      testWidgets(
        'multiple choice with no answer without skip',
        (tester) async {
          await tester.pumpWidget(app([MockedEntities.choice4]));
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with one answer without skip',
        (tester) async {
          await tester.pumpWidget(app([MockedEntities.choice4]));
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1'],
          );
        },
      );

      testWidgets('multiple choice with two answers', (tester) async {
        await tester.pumpWidget(app([MockedEntities.choice4]));
        final cubit = Injector().activityCubit;
        await tester.tap(find.text('option 1'));
        await tester.pump();
        await tester.tap(find.text('option 2'));
        await tester.pump();
        await tester.tap(find.text('NEXT'));
        expect((cubit.state as ActivityLoadedState).answers.length, 1);
        expect(
          (cubit.state as ActivityLoadedState).answers[0]?.answer,
          ['option 1', 'option 2'],
        );
      });

      testWidgets(
        'multiple choice with equals 2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.equal, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          final nextButton = find.text('NEXT');

          //click next without options
          await tester.tap(nextButton);
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);

          //click next with one option
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);

          //click next with 2 options
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1', 'option 2'],
          );
        },
      );

      testWidgets(
        'multiple choice without options and with rule <2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.less, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with 1 option and with rule <2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.less, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1'],
          );
        },
      );

      testWidgets(
        'multiple choice with 2 options and with rule <2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.less, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice without options and with rule <=2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.lessOrEqual, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with 1 option and with rule <=2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.lessOrEqual, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;

          const option = 'option 1';
          await tester.tap(find.text(option));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            [option],
          );
        },
      );

      testWidgets(
        'multiple choice with 2 options and with rule <=2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.lessOrEqual, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1', 'option 2'],
          );
        },
      );

      testWidgets(
        'multiple choice with 3 options and with rule <=2',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.lessOrEqual, ruleValue: 2),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('option 3'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice without options and with rule >1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.more, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with 1 option and with rule >1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.more, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with 2 options and with rule >1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.more, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1', 'option 2'],
          );
        },
      );

      testWidgets(
        'multiple choice without options and with rule >=1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.moreOrEqual, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.isEmpty, true);
        },
      );

      testWidgets(
        'multiple choice with 1 option and with rule >=1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.moreOrEqual, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1'],
          );
        },
      );

      testWidgets(
        'multiple choice with 2 options and with rule >=1',
        (tester) async {
          await tester.pumpWidget(
            app(
              [
                MockedEntities.choice4
                    .copyWith(ruleType: RuleType.moreOrEqual, ruleValue: 1),
              ],
            ),
          );
          final cubit = Injector().activityCubit;
          await tester.tap(find.text('option 1'));
          await tester.pump();
          await tester.tap(find.text('option 2'));
          await tester.pump();
          await tester.tap(find.text('NEXT'));
          expect((cubit.state as ActivityLoadedState).answers.length, 1);
          expect(
            (cubit.state as ActivityLoadedState).answers[0]?.answer,
            ['option 1', 'option 2'],
          );
        },
      );
    },
  );
}
