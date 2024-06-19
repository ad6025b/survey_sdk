// Copyright (c) 2023 flutter.wtf. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/domain/entities/question_answer.dart';
import 'package:activity_builder/src/presentation/activity/activity_state.dart';
import 'package:activity_builder/src/presentation/activity_error/activity_error.dart';
import 'package:activity_builder/src/presentation/di/injector.dart';
import 'package:activity_builder/src/presentation/utils/on_finish_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_cubit.dart';

// TODO(dev): Maybe create two classes, where one is for filePath and the other
// TODO(dev): is for activityData? The build method will be the same for both.

/// A widget that renders a activity form.
///
/// The activity form is defined by either a [filePath] parameter
/// or a [activityData] parameter. The [filePath] is the path to a JSON file
/// containing the activity data, while the [activityData] parameter is the activity
/// data itself.
///
/// The widget manages the state of the activity and renders the appropriate
/// widgets based on the activity state.
///
/// See also:
///
///  * [ActivityData] for activity data.
///  * [ActivityController], where the logic behind a activity navigation is hosted.
class Activity extends StatefulWidget {
  /// The path to a JSON file containing the activity data.
  final String? filePath;

  /// The activity data.
  final ActivityData? activityData;

  /// The controller for navigating the activity and saving answers.
  final ActivityController? controller;

  /// Whether the activity should save user selected answers.
  final bool saveAnswer;

  /// Called after the activity is finished.
  final OnFinishCallback? onFinish;

  /// Either [filePath] or [activityData] must pe provided. The [controller]
  /// parameter is optional and can be used to provide a custom activity
  /// controller.
  const Activity({
    this.filePath,
    this.activityData,
    this.controller,
    this.onFinish,
    this.saveAnswer = true,
    super.key,
  }) : assert(
          (filePath != null || activityData != null) &&
              (filePath == null || activityData == null),
          'Only one of the parameters must be not-null',
        );

  @override
  State<Activity> createState() => _ActivityState();
}

/// The private state class for the [Activity] widget.
class _ActivityState extends State<Activity> {
  /// Instance of the [ActivityCubit] used for managing the activity state.
  late final ActivityCubit _cubit;

  /// Instance of the [ActivityController] used for controlling the activity flow.
  late final ActivityController _activityController;

  /// Initializes an instance of [_ActivityState] and its dependencies.
  ///
  /// The method initializes an instance of [ActivityCubit] and [ActivityController]
  /// using a dependency injection pattern. It then calls the initData method
  /// of [ActivityCubit] with the activity data provided.
  @override
  void initState() {
    super.initState();
    Injector().init();
    _cubit = Injector().activityCubit;
    _activityController = widget.controller ?? ActivityController();
    _reloadActivityData();
  }

  /// Builds the activity form using a PageView widget.
  ///
  /// The questions are mapped to widgets using the
  /// [DataToWidgetUtil.createWidget] method, which is passed to the
  /// BlocBuilder widget as a callback function. The BlocBuilder is responsible
  /// for managing the state of the activity and rendering the appropriate widgets
  /// based on the activity state.
  ///
  /// If the activity is not yet loaded, a circular progress indicator is
  /// displayed. If the user attempts to navigate back from the first page,
  /// the onBack of the [ActivityController] is called.

  void _activityCallback({
    required int index,
    required QuestionAnswer? answer,
    required CallbackType callbackType,
  }) {
    _cubit.processCallback(
      _activityController,
      index,
      answer,
      callbackType,
      onFinish: widget.onFinish,
      saveAnswer: widget.saveAnswer,
    );
  }

  void _reloadActivityData() {
    widget.activityData == null
        ? _cubit.initData(widget.filePath)
        : _cubit.setActivityData(widget.activityData, []);
  }

  @override
  void didUpdateWidget(covariant Activity oldWidget) {
    super.didUpdateWidget(oldWidget);

    _reloadActivityData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      bloc: _cubit,
      builder: (_, state) {
        if (state is ActivityLoadedState) {
          final data = widget.activityData ?? state.activityData;
          final commonTheme = data.commonTheme;
          return Theme(
            data: ThemeData(
              extensions: [
                commonTheme.choice.theme!,
                commonTheme.slider.theme!,
                commonTheme.input.theme!,
                commonTheme.info.theme!,
              ],
            ),
            child: WillPopScope(
              onWillPop: () async {
                _activityController.onBack();
                return false;
              },
              child: PageView(
                controller: _activityController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...data.questions.where((question) {
                    // Check if dependencies are met for this question
                    return _areDependenciesMet(question, state.answers);
                  }).map<Widget>(
                    (question) => DataToWidgetUtil.createWidget(
                      data: question,
                      totalQuestions: data.questions.length,
                      answer: state.answers[question.index],
                      primaryButtonCallback: ({
                        required index,
                        required answer,
                      }) {
                        _activityCallback(
                          index: index,
                          answer: answer,
                          callbackType: CallbackType.primaryCallback,
                        );
                      },
                      secondaryButtonCallback: ({
                        required index,
                        required answer,
                      }) {
                        _activityCallback(
                          index: index,
                          answer: answer,
                          callbackType: CallbackType.secondaryCallback,
                        );
                      },
                      onGoNext: _activityController.onNext,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ActivityErrorLoadState) {
          return ActivityError(
            providedErrors: state.providedErrors,
            onDetailsTap: _cubit.detailedError,
            errorState: state.errorState,
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ActivityColors.black,
          ),
        );
      },
    );
  }

  // Helper function to check if dependencies are met
  bool _areDependenciesMet(
    QuestionData question,
    Map<int, QuestionAnswer> answers,
  ) {
    //if mode is buildMode (not Previewmode), the return true for all dependencies (short-circuit)
    if (widget.saveAnswer == false) return true;

    for (final dependency in question.dependencies) {
      final parentAnswer = answers[dependency.parentQuestionIndex];
      if (parentAnswer == null ||
          parentAnswer.answer != dependency.requiredValue) {
        return false;
      }
    }
    return true;
  }
}
