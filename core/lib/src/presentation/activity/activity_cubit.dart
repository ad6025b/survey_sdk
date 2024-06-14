// Copyright (c) 2023 flutter.wtf. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_sdk/activity_sdk.dart';
import 'package:survey_sdk/src/domain/entities/question_answer.dart';
import 'package:survey_sdk/src/domain/repository_interfaces/activity_data_repository.dart';
import 'package:survey_sdk/src/presentation/activity/activity_state.dart';
import 'package:survey_sdk/src/presentation/utils/activity_button_callback.dart';
import 'package:survey_sdk/src/presentation/utils/on_finish_callback.dart';

class ActivityCubit extends Cubit<ActivityState> {
  /// A repository responsible for retrieving activity data from a data source.
  final ActivityDataRepository _activityDataRepository;

  ActivityCubit(this._activityDataRepository)
      : super(const ActivityEmptyState());

  /// Initializes the activity data by loading it from the specified [filePath].
  /// If the [filePath] is not null, it retrieves the activity data using the
  /// [ActivityDataRepository].
  Future<void> initData(String? filePath) async {
    if (filePath != null) {
      final data = await _activityDataRepository.getActivityData(filePath);
      setActivityData(data.$1, data.$2);
    }
  }

  void processCallback(
    ActivityController activityController,
    int questionIndex,
    QuestionAnswer? answer,
    CallbackType callbackType, {
    required bool saveAnswer,
    OnFinishCallback? onFinish,
  }) {
    if (state is ActivityLoadedState) {
      final loadedState = state as ActivityLoadedState;
      final question = loadedState.activityData.questions.firstWhere(
        (question) => question.index == questionIndex,
      );
      final callback = _callbackByType(callbackType, question);

      ActivityButtonCallback(
        callback: callback,
        callbackType: callbackType,
        activityController: activityController,
        onFinish: onFinish,
        answers: loadedState.answers,
        questions: loadedState.activityData.questions,
        saveAnswer: () => answer == null || !saveAnswer
            ? null
            : _saveAnswer(
                index: questionIndex,
                answer: answer,
                onFinish: onFinish,
              ),
      ).callbackFromType();
    }
  }

  /// Sets the activity data of the cubit to the provided [activityData].
  void setActivityData(
      ActivityData? activityData, List<String> providedErrors) {
    emit(
      activityData != null
          ? ActivityLoadedState(activityData: activityData)
          : ActivityErrorLoadState(
              providedErrors: providedErrors,
              errorState: ActivityErrorState.collapsed,
            ),
    );
  }

  void detailedError(ActivityErrorState errorState) {
    if (state is! ActivityErrorLoadState) return;

    emit(
      (state as ActivityErrorLoadState).copyWith(
        errorState: errorState,
      ),
    );
  }

  /// Saves the provided [answer] for the question at the specified [index].
  void _saveAnswer({
    required int index,
    required QuestionAnswer answer,
    OnFinishCallback? onFinish,
  }) {
    final currentState = state;
    if (currentState is ActivityLoadedState) {
      final newAnswers = Map<int, QuestionAnswer>.of(currentState.answers);
      newAnswers[index] = answer;
      if (index == currentState.activityData.questions.length) {
        onFinish?.call(newAnswers);
      }
      emit(currentState.copyWith(answers: newAnswers));
    }
  }

  ActivityAction? _callbackByType(
    CallbackType callbackType,
    QuestionData question,
  ) =>
      switch (callbackType) {
        CallbackType.primaryCallback => question.mainButtonAction,
        CallbackType.secondaryCallback => question.secondaryButtonAction,
      };
}
