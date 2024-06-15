import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:activity_builder/src/data/mappers/question_types/choice_question_data/choice_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/info_question_data/info_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/input_question_data/input_question_data_mapper_factory.dart';
import 'package:activity_builder/src/data/mappers/question_types/slider_question_data/slider_question_data_mapper_factory.dart';
import 'package:activity_builder/src/domain/entities/api_object.dart';
import 'package:activity_builder/src/domain/entities/constants/scheme_info.dart';
import 'package:activity_builder/src/domain/entities/question_types/choice_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/info_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/input_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/slider_question_data.dart';

abstract class _Fields {
  static const String slider = 'slider';
  static const String info = 'info';
  static const String input = 'input';
  static const String choice = 'choice';
}

/// A theme class that extends the [ThemeExtension] and includes common
/// properties for various question types. It represents the visual styling and
/// configuration for displaying questions in a consistent manner.
class CommonTheme extends ThemeExtension<CommonTheme>
    with ApiObject, EquatableMixin {
  /// The theme configuration for slider questions.
  final SliderQuestionData slider;

  /// The theme configuration for info questions.
  final InfoQuestionData info;

  /// The theme configuration for input questions.
  final InputQuestionData input;

  /// The theme configuration for choice questions.
  final ChoiceQuestionData choice;

  @override
  List<Object?> get props => [
        slider,
        info,
        input,
        choice,
      ];

  CommonTheme({
    required this.choice,
    required this.slider,
    required this.info,
    required this.input,
  });

  @override
  factory CommonTheme.fromJson(Map<String, dynamic> json, int schemeVersion) {
    return CommonTheme(
      slider: SliderQuestionDataMapperFactory.getMapper(
        schemeVersion,
      ).fromJson(json[_Fields.slider]),
      info: InfoQuestionDataMapperFactory.getMapper(
        schemeVersion,
      ).fromJson(json[_Fields.info]),
      input: InputQuestionDataMapperFactory.getMapper(
        schemeVersion,
      ).fromJson(json[_Fields.input]),
      choice: ChoiceQuestionDataMapperFactory.getMapper(
        schemeVersion,
      ).fromJson(json[_Fields.choice]),
    );
  }

  @override
  Map<String, dynamic> toJson({int? schemeVersion}) => {
        _Fields.slider: SliderQuestionDataMapperFactory.getMapper(
          schemeVersion ?? SchemeInfo.version,
        ).toJson(slider),
        _Fields.info: InfoQuestionDataMapperFactory.getMapper(
          schemeVersion ?? SchemeInfo.version,
        ).toJson(info),
        _Fields.input: InputQuestionDataMapperFactory.getMapper(
          schemeVersion ?? SchemeInfo.version,
        ).toJson(input),
        _Fields.choice: ChoiceQuestionDataMapperFactory.getMapper(
          schemeVersion ?? SchemeInfo.version,
        ).toJson(choice),
      };

  @override
  CommonTheme copyWith({
    SliderQuestionData? slider,
    InfoQuestionData? info,
    InputQuestionData? input,
    ChoiceQuestionData? choice,
  }) {
    return CommonTheme(
      slider: slider ?? this.slider,
      info: info ?? this.info,
      input: input ?? this.input,
      choice: choice ?? this.choice,
    );
  }

  /// Linearly interpolates between two instances of [CommonTheme].
  ///
  /// The [lerp] method calculates the intermediate state between two instances
  /// of [CommonTheme] based on a given interpolation factor [t].
  @override
  CommonTheme lerp(covariant CommonTheme? other, double t) {
    return CommonTheme(
      // TODO(dev): should we lerp it?
      slider: slider,
      info: info,
      input: input,
      choice: choice,
    );
  }
}
