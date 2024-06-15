import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/widgets/customization_items/actions_customization_item.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/dropdown_customization_button.dart';
import 'package:survey_admin/presentation/widgets/vector_image.dart';

import '../app_tester.dart';

ActivityAction _activityAction = const GoNextAction();

void main() {
  const questionsLength = 5;

  late String goToQuestion;
  late String finishActivity;
  late String skipQuestion;
  late String goNextQuestion;
  late String goBackQuestion;

  group(
    'ActionsCustomizationItem render group',
    () {
      late Widget testWidget;

      setUp(
        () {
          testWidget = AppTester(
            child: Builder(
              builder: (context) {
                goToQuestion = context.localization.goToQuestion;
                finishActivity = context.localization.finishActivity;
                skipQuestion = context.localization.skipQuestion;
                goNextQuestion = context.localization.goNextQuestion;
                goBackQuestion = context.localization.goPreviousQuestion;

                return ActionsCustomizationItem(
                  onChanged: (action) => _mockedOnChanged(action!),
                  activityAction: _activityAction,
                  callbackType: CallbackType.primaryCallback,
                  questionsLength: questionsLength,
                );
              },
            ),
          );
        },
      );

      testWidgets(
        'should render correctly',
        (tester) async {
          await tester.pumpWidget(testWidget);

          expect(find.byType(ActionsCustomizationItem), findsOneWidget);
        },
      );

      testWidgets(
        'should switch to GoTo',
        (tester) async {
          await tester.pumpWidget(testWidget);

          expect(find.byType(VectorImage), findsNothing);
          expect(find.text(goNextQuestion), findsOneWidget);

          await tester.tap(
            find.byType(DropdownCustomizationButton<ActivityAction?>),
          );
          await tester.pumpAndSettle();
          expect(find.text(goToQuestion), findsOneWidget);
          expect(find.text(skipQuestion), findsOneWidget);
          expect(find.text(finishActivity), findsOneWidget);
          expect(find.text(goBackQuestion), findsOneWidget);

          await tester.tap(find.text(goToQuestion));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, GoToAction);
        },
      );

      testWidgets(
        'should switch to SkipQuestion',
        (tester) async {
          _activityAction = const GoToAction(questionIndex: 0);

          await tester.pumpWidget(testWidget);

          expect(find.byType(CustomizationTextField), findsOneWidget);
          expect(find.text(goToQuestion), findsOneWidget);

          await tester.enterText(find.byType(CustomizationTextField), '2');
          expect(find.text('2'), findsOneWidget);

          await tester.tap(
            find.byType(DropdownCustomizationButton<ActivityAction?>),
          );
          await tester.pumpAndSettle();
          expect(find.text(skipQuestion), findsOneWidget);
          expect(find.text(finishActivity), findsOneWidget);

          await tester.tap(find.text(skipQuestion));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, SkipQuestionAction);
        },
      );

      testWidgets(
        'should switch to FinishActivity',
        (tester) async {
          _activityAction = const SkipQuestionAction();

          await tester.pumpWidget(testWidget);

          expect(find.text(skipQuestion), findsOneWidget);

          await tester.tap(
            find.byType(DropdownCustomizationButton<ActivityAction?>),
          );
          await tester.pumpAndSettle();
          expect(find.text(goToQuestion), findsOneWidget);
          expect(find.text(finishActivity), findsOneWidget);

          await tester.tap(find.text(finishActivity));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, FinishActivityAction);
        },
      );

      testWidgets(
        'should switch to GoNextAction',
            (tester) async {
          _activityAction = const SkipQuestionAction();

          await tester.pumpWidget(testWidget);

          expect(find.text(skipQuestion), findsOneWidget);

          await tester.tap(
            find.byType(DropdownCustomizationButton<ActivityAction?>),
          );
          await tester.pumpAndSettle();
          expect(find.text(goToQuestion), findsOneWidget);
          expect(find.text(finishActivity), findsOneWidget);
          expect(find.text(goNextQuestion), findsOneWidget);
          expect(find.text(goBackQuestion), findsOneWidget);

          await tester.tap(find.text(goNextQuestion));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, GoNextAction);
        },
      );

      testWidgets(
        'should switch to GoBackAction',
            (tester) async {
          _activityAction = const GoNextAction();

          await tester.pumpWidget(testWidget);

          expect(find.text(goNextQuestion), findsOneWidget);

          await tester.tap(
            find.byType(DropdownCustomizationButton<ActivityAction?>),
          );
          await tester.pumpAndSettle();
          expect(find.text(goToQuestion), findsOneWidget);
          expect(find.text(finishActivity), findsOneWidget);
          expect(find.text(skipQuestion), findsOneWidget);
          expect(find.text(goBackQuestion), findsOneWidget);

          await tester.tap(find.text(goBackQuestion));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, GoBackAction);
        },
      );

      testWidgets(
        'should clear activity action',
            (tester) async {
          _activityAction = const FinishActivityAction();

          await tester.pumpWidget(testWidget);

          expect(find.text(finishActivity), findsOneWidget);
          expect(find.byType(VectorImage), findsOneWidget);

          await tester.tap(find.byType(VectorImage));
          await tester.pumpAndSettle();

          expect(_activityAction.runtimeType, GoNextAction);
        },
      );
    },
  );
}

void _mockedOnChanged(ActivityAction activityAction) =>
    _activityAction = activityAction;
