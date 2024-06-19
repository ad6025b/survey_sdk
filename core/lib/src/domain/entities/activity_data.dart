import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/data/mappers/question_types/choice_question_data/choice_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/info_question_data/info_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/input_question_data/input_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/slider_question_data/slider_question_data_mapper_factory.dart';
import 'package:activity_builder/src/domain/entities/api_object.dart';
import 'package:activity_builder/src/domain/entities/constants/scheme_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class _Fields {
  static const String questions = 'questions';
  static const String commonTheme = 'commonTheme';
  static const String schemeVersion = 'schemeVersion';
  static const String dependencies = 'dependencies';
}

/// Holds the core activity data used in the whole app, including the list of
/// questions and the common theme.
class ActivityData with EquatableMixin, ApiObject {
  /// List of questions used to build question pages of different types
  /// of questions.
  final List<QuestionData> questions;

  /// Defines the visual properties used throughout the app.
  final CommonTheme commonTheme;

  @override
  List<Object?> get props => [
        ...questions,
        commonTheme,
      ];

  ActivityData({
    required this.questions,
    required this.commonTheme,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    final questions = <QuestionData>[];
    final schemeVersion = json[_Fields.schemeVersion];
    for (final questionJson in json[_Fields.questions]) {
      questions.add(
        QuestionData.fromType(
          questionJson,
          schemeVersion,
        ),
      );
    }

    return ActivityData(
      questions: questions,
      commonTheme: CommonTheme.fromJson(
        json[_Fields.commonTheme],
        schemeVersion,
      ),
    );
  }

  ActivityData copyWith({
    List<QuestionData>? questions,
    CommonTheme? commonTheme,
  }) {
    return ActivityData(
      questions: questions ?? this.questions,
      commonTheme: commonTheme ?? this.commonTheme,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    const schemeVersion = SchemeInfo.version;
    return {
      _Fields.schemeVersion: schemeVersion,
      _Fields.commonTheme: commonTheme.toJson(
        schemeVersion: schemeVersion,
      ),
      _Fields.questions: questions
          .map(
            (question) => _toJson(
              _themeFromQuestionType(question.type),
              question,
              schemeVersion,
            ),
          )
          .toList(),
    };
  }

  ThemeExtension? _themeFromQuestionType(String type) {
    switch (type) {
      case QuestionTypes.choice:
        return commonTheme.choice.theme;
      case QuestionTypes.slider:
        return commonTheme.slider.theme;
      case QuestionTypes.input:
        return commonTheme.input.theme;
      case QuestionTypes.info:
        return commonTheme.info.theme;
    }
    return null;
  }

  Map<String, dynamic>? _toJson(
    ThemeExtension? themeFromQuestionType,
    QuestionData question,
    int schemeVersion,
  ) {
    switch (question.type) {
      case QuestionTypes.choice:
        return ChoiceQuestionDataMapperFactory.getMapper(
          schemeVersion,
        ).toJson(
          question as ChoiceQuestionData,
          commonTheme: themeFromQuestionType,
        )..addAll({
            _Fields.dependencies:
                question.dependencies.map((e) => e.toJson()).toList(),
          });
      case QuestionTypes.slider:
        return SliderQuestionDataMapperFactory.getMapper(
          schemeVersion,
        ).toJson(
          question as SliderQuestionData,
          commonTheme: themeFromQuestionType,
        )..addAll({
            _Fields.dependencies:
                question.dependencies.map((e) => e.toJson()).toList(),
          });
      case QuestionTypes.input:
        return InputQuestionDataMapperFactory.getMapper(
          schemeVersion,
        ).toJson(
          question as InputQuestionData,
          commonTheme: themeFromQuestionType,
        )..addAll({
            _Fields.dependencies:
                question.dependencies.map((e) => e.toJson()).toList(),
          });
      case QuestionTypes.info:
        return InfoQuestionDataMapperFactory.getMapper(
          schemeVersion,
        ).toJson(
          question as InfoQuestionData,
          commonTheme: themeFromQuestionType,
        )..addAll({
            _Fields.dependencies:
                question.dependencies.map((e) => e.toJson()).toList(),
          });
    }
    return null;
  }
}
