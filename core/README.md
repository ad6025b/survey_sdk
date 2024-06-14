# Activity SDK

The Activity SDK is a toolkit that allows developers to integrate surveys and feedback mechanisms into their Flutter applications quickly and easily.

## Getting Started ❗

To get started with using the Activity SDK, simply follow these steps:

1.  Clone the GitHub repository into your local environment.

2.  Install the required dependencies by running the following command:

        flutter pub get

3.  Import the Activity SDK into your Flutter application by including it in your pubspec.yaml file:

        dependencies:
          survey_sdk: ^0.0.1

4.  Start using the Activity SDK in your Flutter application.

## Features 💡

The Activity SDK offers a range of customizable widgets and components that can be used to integrate surveys and feedback mechanisms into your Flutter application with ease. Some of the key features include:

- ⚙️ Customizable survey forms with a range of different question types.

- 🖥️ A variety of feedback mechanisms, including in-app feedback forms, email feedback forms, and more.

- 🧿 Integration with popular analytics platforms such as Google Analytics and Firebase Analytics.

- 🌐 Support for internationalization/localization, allowing you to support multiple languages and locales.

- 🖨️ You can also export or import the created survey to a json file in the admin package.

- 🖌️ Survey theme customization (background color, font styles, button colors, etc.).

## Survey

A widget that renders a survey form. It manages the state of the survey and renders the appropriate widgets based on the survey state.

The survey form is defined by either a `filePath` parameter or a `surveyData` parameter. The `filePath` is the path to a JSON file containing the survey data, while the `surveyData` parameter is the survey data itself.

Either `filePath` or `surveyData` must pe provided. Also there is a `controller` parameter that is optional and can be used to provide a custom survey controller.

# Example of usage

```dart
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey example'),
      ),
      // Add Survey to your widget tree with filePath parameter that accepts
      // a json file with parsed survey data
      body: const Survey(filePath: 'assets/questions.json'),
    );
  }
```

You can see a full example [here](example/).

## SurveyData

Holds the core survey data used in the whole app, including the list of questions and the common theme.

Besides that, there is method `toJson` and factory `.fromJson` to import and export this Survey data.

---

## Questions

### Types: _Choice_, _Input_, _Info_, _Slider_.

---

## QuestionData class

An abstract class that serves as the foundation for creating various types of question data classes. It provides common properties and methods that are shared among different question types.  
They are:

- `index`
- `title`
- `subtitle`
- `content`
- `isSkip`
- `primaryButtonText`
- `secondaryButtonText`
- `type`

_Note: to create subclasses from `QuestionData` must provide an implementation for the `type` property._

Besides, this class contains such methods as: `copyWith` and static method `fromType`.

## Question's data types

Classes that extend the [QuestionData class](README.md#questiondata-class) and provides additional properties and methods specific to choice questions.

Also they contain named constructor `.common` which initializes class with default values.

---

## ChoiceQuestionData

Data class representing a question with multiple or single choice.

### Unique fields:

- `isMultipleChoice` Default value is _false_.
- `options` Default value is _\['First option', 'Second option', 'Third option']_.
- `selectedOptions` Default value is _null_.
- `ruleType` Default value is _RuleType.none_.
- `ruleValue` Default value is _0_.
  - `theme` Default value is _[ChoiceQuestionTheme](README.md#choicequestiontheme).common()_.

---

## InputQuestionData

Data class representing an input question.

### Unique fields:

- `validator` Default value is _InputValidator.number()_.
- `hintText` Default value is _null_.
- `theme` Default value is _[InputQuestionTheme](README.md#inputquestiontheme).common()_.

---

## InfoQuestionData

Data class representing an information question.

### Unique field:

- `theme` Default value is _[InfoQuestionTheme](README.md#infoquestiontheme).common()_.

---

## SliderQuestionData

Data class representing data for a question that uses a slider to select a value within minimum and maximum range.

### Unique fields:

- `minValue` Default value is _0_.
- `maxValue` Default value is _10_.
- `initialValue` Default value is _5_.
- `divisions` Default value is _8_.
- `theme` Default value is _[SliderQuestionTheme](README.md#sliderquestiontheme).common()_.

---

## Common Theme

A theme class that extends the `ThemeExtension` and includes common properties for various question types. It represents the visual styling and configuration for displaying questions in a consistent manner.

Contains:

- [`choice`](README.md#choicequestiondata)
- [`input`](README.md#inputquestiondata)
- [`info`](README.md#infoquestiondata)
- [`slider`](README.md#sliderquestiondata)

## Subclasses

These classes extend the `ThemeExtension` class and implements the `EquatableMixin` to provide equality checks and comparison methods.

Each class has named constructor `.common` that is a convenience constructor which creates a common instance of class with default values.

Besides, each class contains such fields as:

- `fill` Default value is _Colors.white_.
- `titleColor` Default value is _Colors.black_.
- `titleSize` Default value is _16.0_.
- `subtitleColor` Default value is _Colors.black_.
- `subtitleSize` Default value is _12.0_.
- `primaryButtonFill` Default value is _Colors.black_.
- `primaryButtonTextColor` Default value is _Colors.white_.
- `primaryButtonTextSize` Default value is _12.0_.
- `primaryButtonRadius` Default value is _10.0_.
- `secondaryButtonFill` Default value is _Colors.black_.
- `secondaryButtonTextColor` Default value is _Colors.white_.
- `secondaryButtonTextSize` Default value is _12.0_.
- `secondaryButtonRadius` Default value is _10.0_.

---

## ChoiceQuestionTheme

Represents the visual styling and appearance of options in a choice question.

Unique fields:

- `activeColor` Default value is _Colors.black_.
- `inactiveColor` Default value is _Colors.grey_.

---

## InputQuestionTheme

Represents the visual styling and appearance for an input question options.

Unique fields:

- `inputFill` Default value is _Colors.white_.
- `borderColor` Default value is _Colors.black_.
- `borderWidth` Default value is _1.0_.
- `hintColor` Default value is _Color(0xFF727272)_.
- `hintSize` Default value is _16.0_.
- `textColor` Default value is _Colors.black_.
- `textSize` Default value is _16.0_.
- `lines` Default value is _1_.
- `verticalPadding` Default value is _14.0_.
- `horizontalPadding` Default value is _14.0_.
- `isMultiline` Default value is _false_.
- `errorText` Default value is _'Error'_.
- `inputType` Default value is _InputType.text_.

---

## InfoQuestionTheme

Represents the visual styling and appearance for an info question options.

This class doesn't contains any unique fields.

---

## SliderQuestionTheme

Represents the visual styling and appearance for an slider question options.

Unique fields:

- `activeColor` Default value is _Colors.black_.
- `inactiveColor` Default value is _Color(0xFFCCCCCC)_.
- `thumbColor` Default value is _Colors.black_.
- `thumbRadius` Default value is _16.0_.

---

## Presentation

### Choice question

![choice_question_page](https://github.com/What-the-Flutter/survey_sdk/assets/94079414/6a0e08c0-146d-4358-ae04-4e736687ea4b)

---

### Input question

![input_question_page](https://github.com/What-the-Flutter/survey_sdk/assets/94079414/e0cd9e59-f996-45d0-adb8-516a8f86a0f8)

---

### Info question

![info_question_page](https://github.com/What-the-Flutter/survey_sdk/assets/94079414/9820aced-1bad-49bd-8d0b-8b4acab8d90c)

---

### Slider question

![slider_question_page](https://github.com/What-the-Flutter/survey_sdk/assets/94079414/ddb6660b-96af-4847-a743-798693fea229)

---

For detailed information on how to use the Activity SDK, refer to the documentation included in the package.
