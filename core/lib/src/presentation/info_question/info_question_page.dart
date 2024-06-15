import 'package:activity_builder/src/domain/entities/question_types/info_question_data.dart';
import 'package:activity_builder/src/domain/entities/themes/info_question_theme.dart';
import 'package:activity_builder/src/presentation/utils/utils.dart';
import 'package:activity_builder/src/presentation/widgets/info_data_view.dart';
import 'package:activity_builder/src/presentation/widgets/question_bottom_button.dart';
import 'package:flutter/material.dart';

/// The question page for displaying info content.
///
/// The [InfoQuestionPage] widget is used to display information content to
/// the user. It can contain a title, subtitle, and buttons for navigation.
class InfoQuestionPage extends StatefulWidget {
  /// Contains the content for a page.
  final InfoQuestionData data;

  /// Optional callback that is called after pressing main button.
  final ActivityCallback? onPrimaryButtonTap;

  /// Optional callback that is called when the secondary button is tapped.
  final ActivityCallback? onSecondaryButtonTap;

  const InfoQuestionPage({
    required this.data,
    this.onPrimaryButtonTap,
    this.onSecondaryButtonTap,
    super.key,
  });

  @override
  State<InfoQuestionPage> createState() => _InfoQuestionPageState();
}

class _InfoQuestionPageState extends State<InfoQuestionPage> {
  @override
  Widget build(BuildContext context) {
    final theme =
        widget.data.theme ?? Theme.of(context).extension<InfoQuestionTheme>()!;
    return Scaffold(
      backgroundColor: theme.fill,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: ActivityDimensions.margin2XL,
                right: ActivityDimensions.margin2XL,
                top: ActivityDimensions.margin3XL,
                bottom: ActivityDimensions.marginXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoDataView(data: widget.data),
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: ActivityDimensions.marginS),
                    child: Row(
                      children: [
                        if (widget.data.isSkip)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: QuestionBottomButton(
                                text: widget.data.secondaryButtonText,
                                color: theme.secondaryButtonFill,
                                textColor: theme.secondaryButtonTextColor,
                                textSize: theme.secondaryButtonTextSize,
                                radius: theme.secondaryButtonRadius,
                                onPressed: () {
                                  widget.onSecondaryButtonTap?.call(
                                    index: widget.data.index,
                                    answer: null,
                                  );
                                },
                              ),
                            ),
                          ),
                        Flexible(
                          child: QuestionBottomButton(
                            text: widget.data.primaryButtonText,
                            color: theme.primaryButtonFill,
                            textColor: theme.primaryButtonTextColor,
                            textSize: theme.primaryButtonTextSize,
                            radius: theme.primaryButtonRadius,
                            onPressed: () {
                              widget.onPrimaryButtonTap?.call(
                                index: widget.data.index,
                                answer: null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
