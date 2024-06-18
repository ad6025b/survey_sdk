//dependency structure
class QuestionDependency {
  final int parentQuestionIndex;
  final String requiredValue;

  QuestionDependency({
    required this.parentQuestionIndex,
    required this.requiredValue,
  });
}
