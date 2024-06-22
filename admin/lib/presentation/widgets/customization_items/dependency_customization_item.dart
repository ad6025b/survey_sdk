import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:survey_admin/presentation/widgets/customization_items/customization_widgets/customization_text_field.dart';
import 'package:survey_admin/presentation/widgets/customization_items/dropdown_customization_button.dart';

class DependencyCustomizationItem extends StatefulWidget {
  final List<QuestionDependency> dependencies;
  final int questionIndex; // Index of the current question being edited
  final List<QuestionData> questions; // List of all questions in the activity
  final ValueChanged<List<QuestionDependency>> onChanged;

  const DependencyCustomizationItem({
    required this.dependencies,
    required this.questionIndex,
    required this.questions,
    required this.onChanged,
    super.key,
  });

  @override
  State<DependencyCustomizationItem> createState() =>
      _DependencyCustomizationItemState();
}

class _DependencyCustomizationItemState
    extends State<DependencyCustomizationItem> {
  List<QuestionDependency> _dependencies = [];

  @override
  void initState() {
    super.initState();
    //_dependencies = widget.dependencies;  (this copies an unmodifiable list)
    _dependencies = List.from(widget.dependencies);
  }

  void _addDependency(questionIndex) {
    setState(() {
      final questions = widget.questions
          .where((q) => q.index != questionIndex && q is! InfoQuestionData);
      if (questions.isNotEmpty) {
        _dependencies.add(
          QuestionDependency(
            parentQuestionIndex: questions.first.index,
          ),
        );
      } else {
        _dependencies.add(
          const QuestionDependency(
              //parentQuestionIndex: 3,
              //requiredValue: 'First option',
              ),
        );
      }
    });
    widget.onChanged(_dependencies);
  }

  void _removeDependency(int index) {
    setState(() {
      _dependencies.removeAt(index);
    });
    widget.onChanged(_dependencies);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _dependencies.length; i++)
          _DependencyRow(
            dependency: _dependencies[i],
            questionIndex: widget.questionIndex,
            questions: widget.questions,
            onDependencyChanged: (updatedDependency) {
              setState(() {
                _dependencies[i] = updatedDependency;
              });
              widget.onChanged(_dependencies);
            },
            onRemoveDependency: () => _removeDependency(i),
          ),
        ElevatedButton(
          onPressed: () => _addDependency(widget.questionIndex),
          //child: Text('context.localization.addDependency'),
          child: const Text('Add Dependency'),
        ),
      ],
    );
  }
}

class _DependencyRow extends StatelessWidget {
  final QuestionDependency dependency;
  final int questionIndex;
  final List<QuestionData> questions;
  final ValueChanged<QuestionDependency> onDependencyChanged;
  final VoidCallback onRemoveDependency;

  const _DependencyRow({
    required this.dependency,
    required this.questionIndex,
    required this.questions,
    required this.onDependencyChanged,
    required this.onRemoveDependency,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the input widget based on parent question type
    Widget requiredValueInput =
        const SizedBox.shrink(); // Default (if no match)

    if (dependency.parentQuestionIndex != null) {
      final parentQuestion = questions
          .firstWhere((q) => q.index == dependency.parentQuestionIndex);

      if (parentQuestion is SliderQuestionData ||
          parentQuestion is InputQuestionData) {
        // Use a TextField for Slider and Input questions
        requiredValueInput = CustomizationTextField(
          initialValue: dependency.requiredValue,
          onChanged: (newValue) => onDependencyChanged(
            dependency.copyWith(requiredValue: newValue),
          ),
          decoration: const InputDecoration(
            //hintText: context.localization.enterValue,
            hintText: 'Enter Value',
            isCollapsed: true,
            border: InputBorder.none,
          ),
        );
      } else if (parentQuestion is ChoiceQuestionData) {
        // Use DropdownCustomizationButton for Choice questions
        requiredValueInput = DropdownCustomizationButton<String>(
          value: dependency.requiredValue,
          items: parentQuestion.options
              .map((value) => DropdownCustomizationItem<String>(
                    value: value,
                    onChange: (newValue) => onDependencyChanged(
                      dependency.copyWith(requiredValue: newValue),
                    ),
                    child: Text(value),
                  ))
              .toList(),
          withColor: true,
        );
      }
    }

    return Row(
      children: [
        Expanded(
          child: DropdownCustomizationButton<int>(
            value: dependency.parentQuestionIndex,
            items: questions
                .where(
                    (q) => q.index != questionIndex && q is! InfoQuestionData)
                .map(
                  (q) => DropdownCustomizationItem<int>(
                    value: q.index,
                    onChange: (index) => onDependencyChanged(
                      dependency.copyWith(parentQuestionIndex: index),
                    ),
                    child: Text(q.title),
                  ),
                )
                .toList(),
            withColor: true,
          ),
        ),
        const SizedBox(width: 8.0), // Add some spacing between widgets
        Expanded(
          child: requiredValueInput,
        ),
        const SizedBox(width: 8.0), // Add some spacing between widgets
        IconButton(
          onPressed: onRemoveDependency,
          icon: const Icon(Icons.delete),
          //iconSize: 16.0, // Adjust the icon size if needed
        ),
      ],
    );
  }
}
