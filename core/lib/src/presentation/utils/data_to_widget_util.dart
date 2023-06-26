import 'package:flutter/material.dart';
import 'package:survey_sdk/src/domain/entities/question_answer.dart';
import 'package:survey_sdk/src/domain/entities/question_types/choice_question_data.dart';
import 'package:survey_sdk/src/domain/entities/question_types/info_question_data.dart';
import 'package:survey_sdk/src/domain/entities/question_types/input_question_data.dart';
import 'package:survey_sdk/src/domain/entities/question_types/question_data.dart';
import 'package:survey_sdk/src/domain/entities/question_types/slider_question_data.dart';
import 'package:survey_sdk/src/presentation/choice_question/choice_question_page.dart';
import 'package:survey_sdk/src/presentation/end_page/end_page.dart';
import 'package:survey_sdk/src/presentation/info_question/info_question_page.dart';
import 'package:survey_sdk/src/presentation/input_question/input_question_page.dart';
import 'package:survey_sdk/src/presentation/slider_question/slider_question_page.dart';

typedef OnSendCallback = void Function({
  required int index,
  required QuestionAnswer answer,
});

abstract class DataToWidgetUtil {
  static Widget createWidget({
    required QuestionData data,
    required VoidCallback onGoNext,
    required OnSendCallback mainButtonCallback,
    QuestionAnswer? answer,
  }) {
    switch (data.runtimeType) {
      case SliderQuestionData:
        return SliderQuestionPage(
          data: data as SliderQuestionData,
          answer: answer as QuestionAnswer<double>?,
          onMainButtonTap: mainButtonCallback,
        );
      case ChoiceQuestionData:
        return ChoiceQuestionPage(
          data: data as ChoiceQuestionData,
          answer: answer as QuestionAnswer<List<String>>?,
          onMainButtonTap: mainButtonCallback,
        );
      case InputQuestionData:
        return InputQuestionPage(
          data: data as InputQuestionData,
          answer: answer,
          onMainButtonTap: mainButtonCallback,
        );
      case InfoQuestionData:
        return InfoQuestionPage(
          data: data as InfoQuestionData,
          onMainButtonTap: onGoNext,
        );
      default:
        throw Exception('Unimplemented error');
    }
  }

  static Widget createEndPage({required InfoQuestionData data}) =>
      EndPage(data: data);
}
