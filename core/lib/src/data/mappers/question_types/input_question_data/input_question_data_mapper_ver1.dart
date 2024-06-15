import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/data/mappers/question_types/json_version/question_data_mapper_json_1.dart';
import 'package:activity_builder/src/data/mappers/themes/input_question_theme/input_question_theme_mapper_ver_1.dart';
import 'package:flutter/material.dart';

abstract class _Fields {
  static const String index = 'index';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isSkip = 'isSkip';
  static const String content = 'content';
  static const String hintText = 'isMultipleChoice';
  static const String primaryButtonText = 'primaryButtonText';
  static const String secondaryButtonText = 'secondaryButtonText';
  static const String payload = 'payload';
  static const String theme = 'theme';
  static const String type = 'type';
  static const String primaryButtonAction = 'primaryButtonAction';
  static const String secondaryButtonAction = 'secondaryButtonAction';
}

class InputQuestionDataMapperVer1
    extends QuestionDataMapperJson1<InputQuestionData> {
  @override
  InputQuestionData fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> payload = json[_Fields.payload];
    final theme = json[_Fields.theme];

    return InputQuestionData(
      index: json[_Fields.index],
      title: json[_Fields.title],
      subtitle: json[_Fields.subtitle],
      isSkip: json[_Fields.isSkip],
      content: json[_Fields.content],
      validator: InputValidator.fromJson(payload),
      hintText: payload[_Fields.hintText],
      secondaryButtonText: json[_Fields.secondaryButtonText],
      primaryButtonText: json[_Fields.primaryButtonText],
      theme: theme != null
          ? InputQuestionThemeMapperVer1().fromJson(theme)
          : const InputQuestionTheme.common(),
      mainButtonAction: ActivityAction.fromJson(
        json[_Fields.primaryButtonAction],
      ),
      secondaryButtonAction: ActivityAction.fromJson(
        json[_Fields.secondaryButtonAction],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(
    InputQuestionData data, {
    ThemeExtension<dynamic>? commonTheme,
  }) {
    late final InputQuestionTheme? theme;
    //ignore: prefer-conditional-expressions
    if (commonTheme != null) {
      theme = commonTheme == data.theme ? null : data.theme;
    } else {
      theme = data.theme;
    }
    return {
      _Fields.index: data.index,
      _Fields.title: data.title,
      _Fields.subtitle: data.subtitle,
      _Fields.type: data.type,
      _Fields.isSkip: data.isSkip,
      _Fields.content: data.content,
      _Fields.theme: theme != null
          ? InputQuestionThemeMapperVer1().toJson(theme)
          : InputQuestionThemeMapperVer1()
              .toJson(const InputQuestionTheme.common()),
      _Fields.payload: {
        ...data.validator.toJson(),
        _Fields.hintText: data.hintText,
      },
      _Fields.secondaryButtonText: data.secondaryButtonText,
      _Fields.primaryButtonText: data.primaryButtonText,
      _Fields.primaryButtonAction: data.mainButtonAction == null
          ? null
          : ActivityAction.toJson(data.mainButtonAction!),
      _Fields.secondaryButtonAction: data.secondaryButtonAction == null
          ? null
          : ActivityAction.toJson(data.secondaryButtonAction!),
    };
  }
}
