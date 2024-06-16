import 'package:activity_builder/src/domain/entities/question_answer.dart';
import 'package:activity_builder/src/domain/entities/question_types/choice_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/info_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/input_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/slider_question_data.dart';
import 'package:activity_builder/src/presentation/choice_question/choice_question_page.dart';
import 'package:activity_builder/src/presentation/info_question/info_question_page.dart';
import 'package:activity_builder/src/presentation/input_question/input_question_page.dart';
import 'package:activity_builder/src/presentation/slider_question/slider_question_page.dart';
import 'package:flutter/material.dart';

typedef ActivityCallback = void Function({
  required int index,
  required QuestionAnswer? answer,
});

abstract class DataToWidgetUtil {
  static Widget createWidget({
    required QuestionData data,
    required VoidCallback onGoNext,
    required ActivityCallback primaryButtonCallback,
    ActivityCallback? secondaryButtonCallback,
    QuestionAnswer? answer,
    required int totalQuestions,
  }) {
    switch (data.runtimeType) {
      case SliderQuestionData:
        return SliderQuestionPage(
          data: data as SliderQuestionData,
          answer: answer as QuestionAnswer<double>?,
          totalQuestions: totalQuestions,
          onPrimaryButtonTap: primaryButtonCallback,
          onSecondaryButtonTap: secondaryButtonCallback,
        );
      case ChoiceQuestionData:
        return ChoiceQuestionPage(
          data: data as ChoiceQuestionData,
          answer: answer as QuestionAnswer<List<String>>?,
          totalQuestions: totalQuestions,
          onPrimaryButtonTap: primaryButtonCallback,
          onSecondaryButtonTap: secondaryButtonCallback,
        );
      case InputQuestionData:
        return InputQuestionPage(
          data: data as InputQuestionData,
          answer: answer,
          totalQuestions: totalQuestions,
          onPrimaryButtonTap: primaryButtonCallback,
          onSecondaryButtonTap: secondaryButtonCallback,
        );
      case InfoQuestionData:
        return InfoQuestionPage(
          data: data as InfoQuestionData,
          totalQuestions: totalQuestions,
          onPrimaryButtonTap: primaryButtonCallback,
          onSecondaryButtonTap: secondaryButtonCallback,
        );
      default:
        throw Exception('Unimplemented error');
    }
  }
}
