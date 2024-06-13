import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_common_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_content_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/customization_panel/input/input_customization_tab.dart';
import 'package:survey_admin/presentation/widgets/question_settings_tab_bar.dart';
import 'package:survey_sdk/activity_sdk.dart';

class InputCustomizationPanel extends StatelessWidget {
  final ValueChanged<QuestionData> onChange;
  final InputQuestionData editable;
  final int? questionsAmount;

  const InputCustomizationPanel({
    required this.onChange,
    required this.editable,
    required this.questionsAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QuestionSettingsTabBar(
      tabs: [
        InputContentCustomizationTab(
          onChange: onChange,
          title: context.localization.content,
          editable: editable,
          questionsAmount: questionsAmount,
        ),
        InputCustomizationTab(
          onChange: onChange,
          title: context.localization.input,
          editable: editable,
        ),
        InputCommonCustomizationTab(
          onChange: onChange,
          title: context.localization.common,
          editable: editable,
        ),
      ],
    );
  }
}
