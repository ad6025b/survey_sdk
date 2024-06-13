import 'package:flutter/material.dart';
import 'package:survey_sdk/src/presentation/utils/utils.dart';

/// Represents the title of a activity question.
class QuestionTitle extends StatelessWidget {
  /// Title text of the question.
  final String title;

  /// Text color of the question title.
  final Color? textColor;

  /// Font size of the question title.
  final double? textSize;

  const QuestionTitle({
    required this.title,
    this.textColor,
    this.textSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: textColor ?? ActivityColors.black,
        fontSize: textSize ?? ActivityFonts.sizeL,
        fontWeight: ActivityFonts.weightBold,
      ),
    );
  }
}
