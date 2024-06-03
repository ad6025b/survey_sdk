// Copyright (c) 2023 flutter.wtf. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_sdk/src/domain/entities/question_answer.dart';
import 'package:survey_sdk/src/domain/repository_interfaces/survey_data_repository.dart';
import 'package:survey_sdk/src/presentation/di/injector.dart';
import 'package:survey_sdk/src/presentation/survey/survey_state.dart';
import 'package:survey_sdk/src/presentation/survey_error/survey_error.dart';
import 'package:survey_sdk/src/presentation/utils/on_finish_callback.dart';
import 'package:survey_sdk/src/presentation/utils/survey_button_callback.dart';
import 'package:survey_sdk/src/presentation/utils/utils.dart';
import 'package:survey_sdk/survey_sdk.dart';

// TODO(dev): Maybe create two classes, where one is for filePath and the other
// TODO(dev): is for surveyData? The build method will be the same for both.

/// A widget that renders a survey form.
///
/// The survey form is defined by either a [filePath] parameter
/// or a [surveyData] parameter. The [filePath] is the path to a JSON file
/// containing the survey data, while the [surveyData] parameter is the survey
/// data itself.
///
/// The widget manages the state of the survey and renders the appropriate
/// widgets based on the survey state.
///
/// See also:
///
///  * [SurveyData] for survey data.
///  * [SurveyController], where the logic behind a survey navigation is hosted.
class Survey extends StatefulWidget {
  /// The path to a JSON file containing the survey data.
  final String? filePath;

  /// The survey data.
  final SurveyData? surveyData;

  /// The controller for navigating the survey and saving answers.
  final SurveyController? controller;

  /// Whether the survey should save user selected answers.
  final bool saveAnswer;

  /// Called after the survey is finished.
  final OnFinishCallback? onFinish;

  /// Either [filePath] or [surveyData] must pe provided. The [controller]
  /// parameter is optional and can be used to provide a custom survey
  /// controller.
  const Survey({
    this.filePath,
    this.surveyData,
    this.controller,
    this.onFinish,
    this.saveAnswer = true,
    super.key,
  }) : assert(
          (filePath != null || surveyData != null) &&
              (filePath == null || surveyData == null),
          'Only one of the parameters must be not-null',
        );

  @override
  State<Survey> createState() => _SurveyState();
}

/// The private state class for the [Survey] widget.
class _SurveyState extends State<Survey> {
  /// Instance of the [SurveyCubit] used for managing the survey state.
  late final SurveyCubit _cubit;

  /// Instance of the [SurveyController] used for controlling the survey flow.
  late final SurveyController _surveyController;

  /// Initializes an instance of [_SurveyState] and its dependencies.
  ///
  /// The method initializes an instance of [SurveyCubit] and [SurveyController]
  /// using a dependency injection pattern. It then calls the initData method
  /// of [SurveyCubit] with the survey data provided.
  @override
  void initState() {
    super.initState();
    Injector().init();
    _cubit = Injector().surveyCubit;
    _surveyController = widget.controller ?? SurveyController();
    _reloadSurveyData();
  }

  /// Builds the survey form using a PageView widget.
  ///
  /// The questions are mapped to widgets using the
  /// [DataToWidgetUtil.createWidget] method, which is passed to the
  /// BlocBuilder widget as a callback function. The BlocBuilder is responsible
  /// for managing the state of the survey and rendering the appropriate widgets
  /// based on the survey state.
  ///
  /// If the survey is not yet loaded, a circular progress indicator is
  /// displayed. If the user attempts to navigate back from the first page,
  /// the onBack of the [SurveyController] is called.

  void _surveyCallback({
    required int index,
    required QuestionAnswer? answer,
    required CallbackType callbackType,
  }) {
    _cubit.processCallback(
      _surveyController,
      index,
      answer,
      callbackType,
      onFinish: widget.onFinish,
      saveAnswer: widget.saveAnswer,
    );
  }

  void _reloadSurveyData() {
    widget.surveyData == null
        ? _cubit.initData(widget.filePath)
        : _cubit.setSurveyData(widget.surveyData, []);
  }

  @override
  void didUpdateWidget(covariant Survey oldWidget) {
    super.didUpdateWidget(oldWidget);

    _reloadSurveyData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyCubit, SurveyState>(
      bloc: _cubit,
      builder: (_, state) {
        if (state is SurveyLoadedState) {
          final data = widget.surveyData ?? state.surveyData;
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
                _surveyController.onBack();
                return false;
              },
              child: PageView(
                controller: _surveyController.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...data.questions.map<Widget>(
                    (question) => DataToWidgetUtil.createWidget(
                      data: question,
                      answer: state.answers[question.index],
                      primaryButtonCallback: ({
                        required index,
                        required answer,
                      }) {
                        _surveyCallback(
                          index: index,
                          answer: answer,
                          callbackType: CallbackType.primaryCallback,
                        );
                      },
                      secondaryButtonCallback: ({
                        required index,
                        required answer,
                      }) {
                        _surveyCallback(
                          index: index,
                          answer: answer,
                          callbackType: CallbackType.secondaryCallback,
                        );
                      },
                      onGoNext: _surveyController.onNext,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is SurveyErrorLoadState) {
          return SurveyError(
            providedErrors: state.providedErrors,
            onDetailsTap: _cubit.detailedError,
            errorState: state.errorState,
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: SurveyColors.black,
          ),
        );
      },
    );
  }
}

//================================================================================
//================================================================================
//================================================================================

class SurveyCubit extends Cubit<SurveyState> {
  /// A repository responsible for retrieving survey data from a data source.
  final SurveyDataRepository _surveyDataRepository;

  SurveyCubit(this._surveyDataRepository) : super(const SurveyEmptyState());

  /// Initializes the survey data by loading it from the specified [filePath].
  /// If the [filePath] is not null, it retrieves the survey data using the
  /// [SurveyDataRepository].
  Future<void> initData(String? filePath) async {
    if (filePath != null) {
      final data = await _surveyDataRepository.getSurveyData(filePath);
      setSurveyData(data.$1, data.$2);
    }
  }

  void processCallback(
    SurveyController surveyController,
    int questionIndex,
    QuestionAnswer? answer,
    CallbackType callbackType, {
    required bool saveAnswer,
    OnFinishCallback? onFinish,
  }) {
    if (state is SurveyLoadedState) {
      final loadedState = state as SurveyLoadedState;
      final question = loadedState.surveyData.questions.firstWhere(
        (question) => question.index == questionIndex,
      );
      final callback = _callbackByType(callbackType, question);

      SurveyButtonCallback(
        callback: callback,
        callbackType: callbackType,
        surveyController: surveyController,
        onFinish: onFinish,
        answers: loadedState.answers,
        questions: loadedState.surveyData.questions,
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

  /// Sets the survey data of the cubit to the provided [surveyData].
  void setSurveyData(SurveyData? surveyData, List<String> providedErrors) {
    emit(
      surveyData != null
          ? SurveyLoadedState(surveyData: surveyData)
          : SurveyErrorLoadState(
              providedErrors: providedErrors,
              errorState: SurveyErrorState.collapsed,
            ),
    );
  }

  void detailedError(SurveyErrorState errorState) {
    if (state is! SurveyErrorLoadState) return;

    emit(
      (state as SurveyErrorLoadState).copyWith(
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
    if (currentState is SurveyLoadedState) {
      final newAnswers = Map<int, QuestionAnswer>.of(currentState.answers);
      newAnswers[index] = answer;
      if (index == currentState.surveyData.questions.length) {
        onFinish?.call(newAnswers);
      }
      emit(currentState.copyWith(answers: newAnswers));
    }
  }

  SurveyAction? _callbackByType(
    CallbackType callbackType,
    QuestionData question,
  ) =>
      switch (callbackType) {
        CallbackType.primaryCallback => question.mainButtonAction,
        CallbackType.secondaryCallback => question.secondaryButtonAction,
      };
}
