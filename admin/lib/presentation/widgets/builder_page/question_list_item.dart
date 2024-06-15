import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/vector_image.dart';
import 'package:activity_builder/activity_sdk.dart';

class QuestionListItem extends StatelessWidget {
  final QuestionData questionData;
  final void Function(QuestionData data) onTap;
  final bool isSelected;

  const QuestionListItem({
    required this.questionData,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  Widget _questionImage(QuestionData questionData) {
    switch (questionData.type) {
      case QuestionTypes.info:
        return const VectorImage(assetName: AppAssets.infoIcon);
      case QuestionTypes.input:
        return const VectorImage(assetName: AppAssets.inputIcon);
      case QuestionTypes.slider:
        return const VectorImage(assetName: AppAssets.sliderIcon);
      case QuestionTypes.choice:
        return (questionData as ChoiceQuestionData).isMultipleChoice
            ? const VectorImage(assetName: AppAssets.multipleChoiceIcon)
            : const VectorImage(assetName: AppAssets.singleChoiceIcon);
      default:
        throw Exception('Unimplemented error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    const maxLines = 2;
    return Material(
      child: ListTile(
        onTap: () => onTap(questionData),
        selected: isSelected,
        tileColor:
            isSelected ? ActivityColors.greyBackground : ActivityColors.white,
        title: Padding(
          padding: const EdgeInsets.all(ActivityDimensions.margin2XS),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: ActivityDimensions.marginXS),
                child: SizedBox(
                  width: ActivityDimensions.marginXS + ActivityDimensions.margin3XS,
                  child: Text(
                    questionData.index.toString(),
                    style: textTheme.bodySmall?.copyWith(
                      color: ActivityColors.textGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: ActivityDimensions.marginXS),
              Container(
                decoration: const BoxDecoration(
                  color: ActivityColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(ActivityDimensions.circularRadiusS),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      width: ActivityDimensions.thinBorderWidth,
                    ),
                  ),
                ),
                height: ActivityDimensions.imageSizeS,
                width: ActivityDimensions.imageSizeS,
                child: Center(
                  //ignore: avoid-returning-widgets
                  child: _questionImage(questionData),
                ),
              ),
              const SizedBox(width: ActivityDimensions.marginXS),
              Expanded(
                child: Text(
                  questionData.title,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
