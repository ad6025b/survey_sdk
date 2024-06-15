import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/utils/no_single_zero_formatter.dart';
import 'package:survey_admin/presentation/utils/utils.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/dropdown_customization_button.dart';
import 'package:survey_admin/presentation/widgets/vector_image.dart';
import 'package:activity_builder/activity_sdk.dart';

class ActionsCustomizationItem extends StatefulWidget {
  final ValueChanged<ActivityAction?> onChanged;
  final ActivityAction? activityAction;
  final CallbackType callbackType;
  final int questionsLength;

  const ActionsCustomizationItem({
    required this.onChanged,
    required this.activityAction,
    required this.callbackType,
    required this.questionsLength,
    super.key,
  });

  @override
  State<ActionsCustomizationItem> createState() =>
      _ActionsCustomizationItemState();
}

class _ActionsCustomizationItemState extends State<ActionsCustomizationItem> {
  late int _questionIndex;

  void _setQuestionIndex() {
    _questionIndex = widget.activityAction is GoToAction
        ? (widget.activityAction! as GoToAction).questionIndex
        : 1;
  }

  ActivityAction _defaultCallbackByType() => switch (widget.callbackType) {
        CallbackType.primaryCallback => const GoNextAction(),
        CallbackType.secondaryCallback => const SkipQuestionAction(),
      };

  @override
  Widget build(BuildContext context) {
    _setQuestionIndex();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ActivityActionDropdownButton(
                activityAction: widget.activityAction,
                onChanged: widget.onChanged,
                questionIndex: _questionIndex,
              ),
            ),
            if (widget.activityAction.runtimeType !=
                _defaultCallbackByType().runtimeType)
              GestureDetector(
                onTap: () => widget.onChanged(
                  _defaultCallbackByType(),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(ActivityDimensions.marginS),
                  child: VectorImage(assetName: AppAssets.closeIcon),
                ),
              ),
          ],
        ),
        if (widget.activityAction is GoToAction)
          _IndexSelector(
            questionIndex: (widget.activityAction! as GoToAction).questionIndex,
            onIndexChanged: (value) => widget.onChanged(
              GoToAction(questionIndex: value),
            ),
            questionsLength: widget.questionsLength,
          ),
      ],
    );
  }
}

class _ActivityActionDropdownButton extends StatelessWidget {
  final ActivityAction? activityAction;
  final ValueChanged<ActivityAction?> onChanged;
  final int questionIndex;

  const _ActivityActionDropdownButton({
    required this.activityAction,
    required this.onChanged,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownCustomizationButton<ActivityAction?>(
      value: activityAction,
      items: [
        DropdownCustomizationItem(
          value: const GoNextAction(),
          onChange: onChanged,
          child: Text(context.localization.goNextQuestion),
        ),
        DropdownCustomizationItem(
          value: const GoBackAction(),
          onChange: onChanged,
          child: Text(context.localization.goPreviousQuestion),
        ),
        DropdownCustomizationItem(
          value: GoToAction(questionIndex: questionIndex),
          onChange: onChanged,
          child: Text(context.localization.goToQuestion),
        ),
        DropdownCustomizationItem(
          value: const SkipQuestionAction(),
          onChange: onChanged,
          child: Text(context.localization.skipQuestion),
        ),
        DropdownCustomizationItem(
          value: const FinishActivityAction(),
          onChange: onChanged,
          child: Text(context.localization.finishActivity),
        ),
      ],
      withColor: true,
    );
  }
}

class _IndexSelector extends StatefulWidget {
  final int questionIndex;
  final ValueChanged<int> onIndexChanged;
  final int questionsLength;

  const _IndexSelector({
    required this.onIndexChanged,
    required this.questionIndex,
    required this.questionsLength,
  });

  @override
  State<_IndexSelector> createState() => _IndexSelectorState();
}

class _IndexSelectorState extends State<_IndexSelector> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..text = widget.questionIndex.toString();

    _focusNode = FocusNode()
      ..addListener(
        () {
          if (!_focusNode.hasFocus) {
            _controller.text = widget.questionIndex.toString();
            _formKey.currentState!.reset();
          }
        },
      );

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        ActivityDimensions.marginM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localization.questionIndex,
            style: context.theme.textTheme.titleSmall,
          ),
          const SizedBox(height: ActivityDimensions.marginS),
          Form(
            key: _formKey,
            child: CustomizationTextField.int(
              controller: _controller,
              focusNode: _focusNode,
              style: context.theme.textTheme.bodyMedium,
              initialValue: widget.questionIndex.toString(),
              validator: (value) {
                final parsedValue = int.tryParse(value ?? '');

                return parsedValue != null
                    ? parsedValue > widget.questionsLength + 1
                        ? context.localization
                            .questionIndexError(widget.questionsLength + 1)
                        : null
                    : null;
              },
              inputFormatters: const [
                NoSingleZeroFormatter(),
              ],
              hintText: context.localization.questionIndex,
              emptyValue: widget.questionIndex.toString(),
              onChanged: (value) {
                if (_formKey.currentState!.validate()) {
                  widget.onIndexChanged(
                    int.parse(value!),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
