import 'package:activity_builder/activity_sdk.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/pages/new_question_page/new_question_page.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/builder_page/question_list_item.dart';

class QuestionList extends StatefulWidget {
  final ValueChanged<QuestionData> onSelect;
  final ValueChanged<QuestionData> onAdd;
  final ValueChanged<QuestionData> onDelete;
  final ValueChanged<List<QuestionData>> onUpdate;
  final int? selectedIndex;
  final ActivityData data;
  final ValueChanged<ActivityData> onDataUpdate;
  final bool isEditMode;

  const QuestionList({
    required this.onSelect,
    required this.onAdd,
    required this.data,
    required this.onUpdate,
    required this.onDelete,
    required this.onDataUpdate,
    required this.selectedIndex,
    this.isEditMode = true,
    super.key,
  });

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  void _updateQuestion(int oldIndex, int newIndex) {
    final updatedIndex = newIndex >= widget.data.questions.length
        ? widget.data.questions.length - 1
        : newIndex;

    final itemOld = widget.data.questions.removeAt(oldIndex);
    widget.data.questions.insert(updatedIndex, itemOld);

    for (var i = 0; i < widget.data.questions.length; i++) {
      widget.data.questions[i] =
          widget.data.questions[i].copyWith(index: i + 1);
    }

    widget.onUpdate(widget.data.questions);
  }

  @override
  Widget build(BuildContext context) {
    final length = widget.data.questions.length;

    return AnimatedContainer(
      duration: ActivityDurations.panelSwitchingDuration,
      color: ActivityColors.white,
      width: widget.isEditMode ? ActivityDimensions.activityContentBarWidth : 0,
      child: OverflowBox(
        maxWidth: ActivityDimensions.activityContentBarWidth,
        child: Column(
          children: [
            const Divider(),
            _ListHeader(
              //ignore: avoid-passing-async-when-sync-expected
              onAddButtonTap: () async {
                final activityData = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewQuestionPage(
                      data: widget.data,
                    ),
                  ),
                );

                //alex101 return if just cancel add screen
                if (activityData == null) return;

                widget.onDataUpdate(activityData);
              },
              isEditingCommonTheme: widget.selectedIndex == -1,
              questionList: widget.data.questions,
            ),
            Expanded(
              child: ContextMenuOverlay(
                child: ReorderableListView(
                  proxyDecorator: (widget, _, __) => widget,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      _updateQuestion(oldIndex, newIndex);
                    });
                  },
                  buildDefaultDragHandles: false,
                  children: [
                    for (int index = 0; index < length; index++)
                      _Question(
                        key: ValueKey(index),
                        index: index,
                        isSelected: index == widget.selectedIndex,
                        onDeleteButtonPressed: () => widget.onDelete(
                          widget.data.questions[index],
                        ),
                        question: widget.data.questions[index],
                        onQuestionTap: widget.onSelect,
                      ),
                  ],
                ),
                cardBuilder: (_, children) {
                  return DecoratedBox(
                    decoration: const BoxDecoration(
                      color: ActivityColors.white,
                      border: Border.fromBorderSide(BorderSide(width: 0.5)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(ActivityDimensions.circularRadiusXS),
                      ),
                    ),
                    child: Column(children: children),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListHeader extends StatelessWidget {
  final VoidCallback onAddButtonTap;
  final List<QuestionData> questionList;
  final bool isEditingCommonTheme;

  const _ListHeader({
    required this.onAddButtonTap,
    required this.questionList,
    required this.isEditingCommonTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: ActivityDimensions.margin2XS,
        horizontal: ActivityDimensions.marginXL,
      ),
      child: Row(
        children: [
          Text(
            context.localization.activity,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: ActivityFonts.weightBold,
            ),
          ),
          const SizedBox(
            width: ActivityDimensions.margin4XL,
          ),
          GestureDetector(
            onTap: onAddButtonTap,
            child: SizedBox(
              height: ActivityDimensions.sizeL,
              width: ActivityDimensions.sizeL,
              child: SvgPicture.asset(AppAssets.addCircleIcon),
            ),
          ),
        ],
      ),
    );
  }
}

class _Question extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback? onDeleteButtonPressed;
  final ValueChanged<QuestionData> onQuestionTap;
  final QuestionData question;

  const _Question({
    required this.index,
    required this.isSelected,
    required this.question,
    required this.onQuestionTap,
    this.onDeleteButtonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: ContextMenuRegion(
        contextMenu: GenericContextMenu(
          buttonConfigs: [
            ContextMenuButtonConfig(
              context.localization.deleteQuestion,
              onPressed: onDeleteButtonPressed,
            ),
          ],
        ),
        child: QuestionListItem(
          isSelected: isSelected,
          questionData: question,
          onTap: onQuestionTap,
        ),
      ),
    );
  }
}
