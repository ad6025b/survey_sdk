import 'package:activity_builder/activity_sdk.dart';
import 'package:activity_builder/src/presentation/widgets/question_content.dart';
import 'package:activity_builder/src/presentation/widgets/question_title.dart';
import 'package:flutter/material.dart';

class InfoDataView extends StatelessWidget {
  final InfoQuestionData data;

  const InfoDataView({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        data.theme ?? Theme.of(context).extension<InfoQuestionTheme>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (data.title.isNotEmpty)
          QuestionTitle(
            title: data.title,
            textColor: theme.titleColor,
            textSize: theme.titleSize,
          ),
        const Padding(
          padding: EdgeInsets.only(
            top: ActivityDimensions.margin2XL,
          ),
          child: Divider(
            height: 1,
            color: ActivityColors.itemDivider,
          ),
        ),
        if (data.subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: ActivityDimensions.marginS,
            ),
            child: QuestionContent(
              content: data.subtitle,
              textColor: theme.subtitleColor,
              textSize: theme.subtitleSize,
            ),
          ),
      ],
    );
  }
}
