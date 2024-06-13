import 'package:flutter/material.dart';
import 'package:survey_sdk/src/domain/entities/actions/go_next_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/skip_question_action.dart';
import 'package:survey_sdk/src/domain/entities/actions/activity_action.dart';
import 'package:survey_sdk/src/domain/entities/constants/question_types.dart';
import 'package:survey_sdk/src/domain/entities/question_types/question_data.dart';
import 'package:survey_sdk/src/domain/entities/themes/slider_question_theme.dart';

const _maxValue = 10;
const _divisions = 8;
const _initialValue = 5;

/// Data class representing data for a question that uses a slider to select a
/// value within minimum and maximum range.
///
/// The [SliderQuestionData] class extends the [QuestionData] class and provides
/// additional properties specific to slider questions.
class SliderQuestionData extends QuestionData<SliderThemeData> {
  /// The minimum value of the slider.
  /// Default value is [0].
  final int minValue;

  /// The maximum value of the slider.
  /// Default value is [10].
  final int maxValue;

  /// The initial value of the slider.
  /// Default value is [5].
  final int initialValue;

  /// The number of divisions for the slider.
  /// Default value is [8].
  final int divisions;

  /// The theme applied to the slider question.
  /// Default value is [SliderQuestionTheme.common()].
  final SliderQuestionTheme? theme;

  @override
  String get type => QuestionTypes.slider;

  @override
  List<Object?> get props => [
        minValue,
        maxValue,
        initialValue,
        divisions,
        index,
        title,
        subtitle,
        isSkip,
        content,
        theme,
        secondaryButtonText,
        primaryButtonText,
        mainButtonAction,
        secondaryButtonAction,
      ];

  const SliderQuestionData({
    required this.minValue,
    required this.maxValue,
    required this.divisions,
    required this.initialValue,
    required this.theme,
    required super.index,
    required super.title,
    required super.subtitle,
    required super.isSkip,
    required super.secondaryButtonText,
    required super.primaryButtonText,
    super.mainButtonAction,
    super.secondaryButtonAction,
    super.content,
  });

  /// Creates a common instance of [SliderQuestionData].
  ///
  /// The [SliderQuestionData.common] constructor is a convenience constructor
  /// that creates a common instance of [SliderQuestionData] with predefined
  /// values.
  const SliderQuestionData.common({int index = 0})
      : this(
          // TODO(dev): to localization somehow
          minValue: 0,
          maxValue: _maxValue,
          divisions: _divisions,
          initialValue: _initialValue,
          title: 'Slider',
          index: index,
          subtitle: '',
          isSkip: false,
          theme: const SliderQuestionTheme.common(),
          content:
              'You may simply need a single, brief answer without discussion. '
              'Other times, you may want to talk through a scenario, evaluate '
              'how well a group is learning new material or solicit feedback. '
              'The types of questions you ask directly impact the type of '
              'answer you receive.',
          primaryButtonText: 'NEXT',
          secondaryButtonText: 'SKIP',
          mainButtonAction: const GoNextAction(),
          secondaryButtonAction: const SkipQuestionAction(),
        );

  @override
  SliderQuestionData copyWith({
    int? minValue,
    int? maxValue,
    int? initialValue,
    int? divisions,
    int? index,
    String? title,
    String? subtitle,
    String? content,
    bool? isSkip,
    SliderQuestionTheme? theme,
    String? secondaryButtonText,
    String? primaryButtonText,
    ActivityAction? mainButtonAction,
    ActivityAction? secondaryButtonAction,
    bool clearMainAction = false,
    bool clearSecondaryAction = false,
  }) {
    return SliderQuestionData(
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      initialValue: initialValue ?? this.initialValue,
      index: index ?? this.index,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      divisions: divisions ?? this.divisions,
      isSkip: isSkip ?? this.isSkip,
      theme: theme ?? this.theme,
      secondaryButtonText: secondaryButtonText ?? this.secondaryButtonText,
      primaryButtonText: primaryButtonText ?? this.primaryButtonText,
      mainButtonAction: clearMainAction
          ? mainButtonAction
          : mainButtonAction ?? this.mainButtonAction,
      secondaryButtonAction: clearSecondaryAction
          ? secondaryButtonAction
          : secondaryButtonAction ?? this.secondaryButtonAction,
    );
  }
}
