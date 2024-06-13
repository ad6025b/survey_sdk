import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:survey_sdk/src/domain/entities/actions/finish_activity_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/go_back_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/go_next_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/go_to_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/skip_question_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/activity_action.dart';
import 'package:survey_sdk/src/domain/entities/question_types/question_data.dart';
import 'package:survey_sdk/src/presentation/activity/activity_controller.dart';
import 'package:survey_sdk/src/presentation/utils/callback_type.dart';
import 'package:survey_sdk/src/presentation/utils/activity_button_callback.dart';

import '../../utils/mocked_entities.dart';

// ignore: prefer-match-file-name
class MockActivityController extends Mock implements ActivityController {}

void main() {
  final mockedQuestions = <QuestionData>[
    MockedEntities.info1,
    MockedEntities.input1,
    MockedEntities.choice1,
    MockedEntities.slider1,
  ];

  group(
    'Activity callback util tests',
    () {
      test(
        'Should call when GoNextAction is action for button',
        () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            const GoNextAction(),
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.goNextCallback).called(1);
        },
      );

      test(
        'Should call when GoBackAction is action for button',
            () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            const GoBackAction(),
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.goBackCallback).called(1);

        },
      );

      test(
        'Should call when GoToAction is action for button',
            () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            const GoToAction(questionIndex: 0),
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.goToCallback).called(1);

        },
      );

      test(
        'Should call when FinishActivityAction is action for button',
            () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            const FinishActivityAction(),
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.finishActivityCallback).called(1);

        },
      );

      test(
        'Should call when SkipQuestionAction is action for button',
            () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            const SkipQuestionAction(),
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.skipActivityCallback).called(1);

        },
      );

      test(
        "Should call when passed null for button's action",
            () {
          final activityButtonCallback = _activityButtonCallbackByAction(
            null,
            mockedQuestions,
          )..callbackFromType();

          verify(activityButtonCallback.defaultActivityCallback).called(1);

        },
      );
    },
  );
}

ActivityButtonCallback _activityButtonCallbackByAction(
  ActivityAction? callback,
  List<QuestionData> questions,
) {
  final mockedActivityController = MockActivityController();

  return ActivityButtonCallback(
    callback: callback,
    saveAnswer: null,
    activityController: mockedActivityController,
    questions: questions,
    callbackType: CallbackType.primaryCallback,
  );
}
