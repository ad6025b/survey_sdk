import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/data/mappers/question_types/json_version/question_data_mapper_json_1.dart';
import 'package:activity_builder/src/data/mappers/themes/choice_question_theme/choice_question_theme_mapper_ver_1.dart';
import 'package:flutter/material.dart';

abstract class _Fields {
  static const String index = 'index';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isSkip = 'isSkip';
  static const String content = 'content';
  static const String isMultipleChoice = 'isMultipleChoice';
  static const String options = 'options';
  static const String selectedByDefault = 'selectedByDefault';
  static const String ruleType = 'ruleType';
  static const String ruleValue = 'ruleValue';
  static const String primaryButtonText = 'primaryButtonText';
  static const String secondaryButtonText = 'secondaryButtonText';
  static const String payload = 'payload';
  static const String theme = 'theme';
  static const String type = 'type';
  static const String primaryButtonAction = 'primaryButtonAction';
  static const String secondaryButtonAction = 'secondaryButtonAction';
  static const String dependencies = 'dependencies';
}

class ChoiceQuestionDataMapperVer1
    extends QuestionDataMapperJson1<ChoiceQuestionData> {
  @override
  ChoiceQuestionData fromJson(Map<String, dynamic> json) {
    final payload = json[_Fields.payload] as Map<String, dynamic>;
    final theme = json[_Fields.theme];

    final dependencies = (json[_Fields.dependencies] as List<dynamic>?)
            ?.map((e) => QuestionDependency.fromJson(e))
            .toList() ??
        [];

    return ChoiceQuestionData(
      index: json[_Fields.index],
      title: json[_Fields.title],
      subtitle: json[_Fields.subtitle],
      isSkip: json[_Fields.isSkip],
      content: json[_Fields.content],
      isMultipleChoice: payload[_Fields.isMultipleChoice],
      options: (payload[_Fields.options] as List<dynamic>).cast<String>(),
      selectedByDefault: payload[_Fields.selectedByDefault] != null
          ? (payload[_Fields.selectedByDefault] as List<dynamic>).cast<String>()
          : null,
      ruleType: RuleType.values[payload[_Fields.ruleType]],
      ruleValue: payload[_Fields.ruleValue],
      theme: theme != null
          ? ChoiceQuestionThemeMapperVer1().fromJson(theme)
          : const ChoiceQuestionTheme.common(),
      primaryButtonText: json[_Fields.primaryButtonText],
      secondaryButtonText: json[_Fields.secondaryButtonText],
      mainButtonAction: ActivityAction.fromJson(
        json[_Fields.primaryButtonAction],
      ),
      secondaryButtonAction: ActivityAction.fromJson(
        json[_Fields.secondaryButtonAction],
      ),
      dependencies: dependencies,
      //dependencies: json[_Fields.dependencies],
    );
  }

  @override
  Map<String, dynamic> toJson(
    ChoiceQuestionData data, {
    ThemeExtension<dynamic>? commonTheme,
  }) {
    late final ChoiceQuestionTheme? theme;
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
          ? ChoiceQuestionThemeMapperVer1().toJson(theme)
          : ChoiceQuestionThemeMapperVer1()
              .toJson(const ChoiceQuestionTheme.common()),
      _Fields.payload: {
        _Fields.isMultipleChoice: data.isMultipleChoice,
        _Fields.options: data.options,
        _Fields.selectedByDefault: data.selectedByDefault,
        _Fields.ruleType: data.ruleType.index,
        _Fields.ruleValue: data.ruleValue,
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
