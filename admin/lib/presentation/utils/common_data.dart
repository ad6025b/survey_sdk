import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';

class CommonData {
  final BuildContext context;
  static const _minValue = 0;
  static const _maxValue = 10;
  static const _initialValue = 5;
  static const _firstIndex = 1;
  static const _secondIndex = 2;
  static const _thirdIndex = 3;
  static const _fourthIndex = 4;
  static const _fifthIndex = 5;
  static const _dividers = 10;

  CommonTheme get commonTheme {
    return CommonTheme(
      slider: slider(),
      info: info(),
      input: input(),
      choice: choice(),
    );
  }

  ActivityData get activityData {
    return ActivityData(
      questions: [
        info(index: _firstIndex),
        // info(index: _firstIndex).copyWith(
        //   title: 'yyy',
        //   dependencies: [
        //     const QuestionDependency(
        //       parentQuestionIndex:
        //           _secondIndex, // Depends on the input question
        //       requiredValue: 'hh', // Only show if the input is "Hello"
        //     ),
        //   ],
        // ),

        input(index: _secondIndex),
        // input(index: _secondIndex).copyWith(
        //   title: 'ppp',
        //   dependencies: [
        //     const QuestionDependency(
        //       parentQuestionIndex: _thirdIndex, // Depends on the input question
        //       //requiredValue: 'hh', // Only show if the input is "Hello"
        //     ),
        //   ],
        // ),

        //choice(index: _thirdIndex),
        //not  needed later...load from json file// // // Create the choice question and add the dependency
        choice(index: _thirdIndex).copyWith(
          //title: 'Choices Title',
          secondaryButtonAction: const GoBackAction(),
          secondaryButtonText: 'BACK',
          isSkip: true,
          dependencies: [
            const QuestionDependency(
              parentQuestionIndex:
                  _secondIndex, // Depends on the input question
              requiredValue: 'hh', // Only show if the input is "Hello"
            ),
          ],
        ),

        //slider(index: _fourthIndex),
        slider(index: _fourthIndex).copyWith(
          title: 'Slider Title',
          secondaryButtonAction: const GoBackAction(),
          secondaryButtonText: 'BACK',
          isSkip: true,
          dependencies: [
            const QuestionDependency(
              parentQuestionIndex:
                  _secondIndex, // Depends on the input question
              requiredValue: 'hh', // Only show if the input is "Hello"
            ),
            const QuestionDependency(
              parentQuestionIndex: _thirdIndex, // Depends on the input question
              requiredValue:
                  'Second option', // Only show if the input is "Hello"
            ),
          ],
        ),

        info(index: _fifthIndex).copyWith(
          title: 'You are done.',
          subtitle: 'Thank you for taking this survey.',
          primaryButtonText: 'DONE',
          mainButtonAction: const FinishActivityAction(),
        ),
      ],
      commonTheme: commonTheme,
    );
  }

  const CommonData(this.context);

  InfoQuestionData info({int index = 0}) {
    return InfoQuestionData(
      primaryButtonText: context.localization.next,
      title: context.localization.info,
      index: index,
      subtitle: context.localization.emptySubtitle,
      isSkip: false,
      content: context.localization.questionContent,
      theme: const InfoQuestionTheme.common(),
      secondaryButtonText: context.localization.skip,
      mainButtonAction: const GoNextAction(),
      secondaryButtonAction: const SkipQuestionAction(),
    );
  }

  InputQuestionData input({int index = 0}) {
    return InputQuestionData(
      validator: InputValidator.text(),
      index: index,
      title: context.localization.input,
      subtitle: context.localization.emptySubtitle,
      isSkip: false,
      content: context.localization.questionContent,
      hintText: context.localization.inputHintText,
      theme: const InputQuestionTheme.common(),
      primaryButtonText: context.localization.next,
      secondaryButtonText: context.localization.skip,
      mainButtonAction: const GoNextAction(),
      secondaryButtonAction: const SkipQuestionAction(),
    );
  }

  ChoiceQuestionData choice({int index = 0}) {
    return ChoiceQuestionData(
      isMultipleChoice: false,
      options: [
        context.localization.firstOption,
        context.localization.secondOption,
        context.localization.thirdOption,
      ],
      title: context.localization.choice,
      subtitle: context.localization.emptySubtitle,
      isSkip: false,
      content: context.localization.questionContent,
      index: index,
      ruleType: RuleType.none,
      ruleValue: 0,
      theme: const ChoiceQuestionTheme.common(),
      primaryButtonText: context.localization.next,
      secondaryButtonText: context.localization.skip,
      mainButtonAction: const GoNextAction(),
      secondaryButtonAction: const SkipQuestionAction(),
    );
  }

  SliderQuestionData slider({int index = 0}) {
    return SliderQuestionData(
      minValue: _minValue,
      maxValue: _maxValue,
      initialValue: _initialValue,
      title: context.localization.slider,
      index: index,
      subtitle: context.localization.emptySubtitle,
      isSkip: false,
      content: context.localization.questionContent,
      divisions: _dividers,
      theme: const SliderQuestionTheme.common(),
      secondaryButtonText: context.localization.skip,
      primaryButtonText: context.localization.next,
      mainButtonAction: const GoNextAction(),
      secondaryButtonAction: const SkipQuestionAction(),
    );
  }
}
