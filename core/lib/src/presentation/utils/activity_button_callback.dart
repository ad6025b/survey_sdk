import 'package:flutter/material.dart';
import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';
import 'package:activity_builder/src/domain/entities/actions/finish_activity_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_back_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_next_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_to_action.dart';
import 'package:activity_builder/src/domain/entities/actions/skip_question_action.dart';
import 'package:activity_builder/src/domain/entities/question_answer.dart';
import 'package:activity_builder/src/domain/entities/question_types/question_data.dart';
import 'package:activity_builder/src/presentation/activity/activity_controller.dart';
import 'package:activity_builder/src/presentation/utils/callback_type.dart';
import 'package:activity_builder/src/presentation/utils/on_finish_callback.dart';

class ActivityButtonCallback {
  final ActivityAction? callback;
  final VoidCallback? saveAnswer;
  final ActivityController activityController;
  final List<QuestionData> questions;
  final OnFinishCallback? onFinish;
  final CallbackType callbackType;
  final Map<int, QuestionAnswer>? answers;

  ActivityButtonCallback({
    required this.callback,
    required this.saveAnswer,
    required this.activityController,
    required this.questions,
    required this.callbackType,
    this.answers,
    this.onFinish,
  }) : assert(
          onFinish != null && answers != null || onFinish == null,
          'If onFinish != null answers should not be null either',
        );

  void callbackFromType() => switch (callback.runtimeType) {
        GoToAction => goToCallback(),
        FinishActivityAction => finishActivityCallback(),
        SkipQuestionAction => skipActivityCallback(),
        GoNextAction => goNextCallback(),
        GoBackAction => goBackCallback(),
        _ => defaultActivityCallback(),
      };

  @visibleForTesting
  void goToCallback() {
    saveAnswer?.call();
    activityController.animateTo((callback! as GoToAction).questionIndex - 1);
  }

  @visibleForTesting
  void finishActivityCallback() {
    saveAnswer?.call();
    onFinish?.call(answers!);
    activityController.animateTo(questions.length);
  }

  @visibleForTesting
  void skipActivityCallback() {
    activityController.onNext();
  }

  @visibleForTesting
  void goNextCallback() {
    saveAnswer?.call();
    activityController.onNext();
  }

  void goBackCallback() {
    activityController.onBack();
  }

  @visibleForTesting
  void defaultActivityCallback() => switch (callbackType) {
        CallbackType.primaryCallback => goNextCallback(),
        CallbackType.secondaryCallback => skipActivityCallback(),
      };
}
