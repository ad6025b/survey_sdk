import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/data/mappers/question_types/json_version/question_data_mapper_json_1.dart';
import 'package:activity_builder/src/data/mappers/themes/info_question_theme/info_question_theme_mapper_ver_1.dart';
import 'package:flutter/material.dart';

abstract class _Fields {
  static const String index = 'index';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isSkip = 'isSkip';
  static const String content = 'content';
  static const String primaryButtonText = 'primaryButtonText';
  static const String secondaryButtonText = 'secondaryButtonText';
  static const String theme = 'theme';
  static const String type = 'type';
  static const String primaryButtonAction = 'primaryButtonAction';
  static const String secondaryButtonAction = 'secondaryButtonAction';
}

class InfoQuestionDataMapperVer1
    extends QuestionDataMapperJson1<InfoQuestionData> {
  @override
  InfoQuestionData fromJson(Map<String, dynamic> json) {
    final theme = json[_Fields.theme];

    return InfoQuestionData(
      index: json[_Fields.index],
      title: json[_Fields.title],
      subtitle: json[_Fields.subtitle],
      isSkip: json[_Fields.isSkip],
      content: json[_Fields.content],
      theme: theme != null
          ? InfoQuestionThemeMapperVer1().fromJson(theme)
          : const InfoQuestionTheme.common(),
      secondaryButtonText: json[_Fields.secondaryButtonText],
      primaryButtonText: json[_Fields.primaryButtonText],
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
    InfoQuestionData data, {
    ThemeExtension<dynamic>? commonTheme,
  }) {
    late final InfoQuestionTheme? theme;
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
          ? InfoQuestionThemeMapperVer1().toJson(theme)
          : InfoQuestionThemeMapperVer1()
              .toJson(const InfoQuestionTheme.common()),
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
