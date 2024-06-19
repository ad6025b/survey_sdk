import 'package:activity_builder/src/domain/entities/api_object.dart';
import 'package:equatable/equatable.dart';

abstract class _Fields {
  static const String parentQuestionIndex = 'parentQuestionIndex';
  static const String requiredValue = 'requiredValue';
}

/// Represents a dependency between questions.
class QuestionDependency extends Equatable implements ApiObject {
  /// Index of the parent question this dependency relies on.
  final int parentQuestionIndex;

  /// The value the parent question needs to have for this question to be visible.
  final String requiredValue;

  @override
  List<Object?> get props => [
        parentQuestionIndex,
        requiredValue,
      ];

  const QuestionDependency({
    required this.parentQuestionIndex,
    required this.requiredValue,
  });

  factory QuestionDependency.fromJson(Map<String, dynamic> json) {
    return QuestionDependency(
      parentQuestionIndex: json[_Fields.parentQuestionIndex],
      requiredValue: json[_Fields.requiredValue],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        _Fields.parentQuestionIndex: parentQuestionIndex,
        _Fields.requiredValue: requiredValue,
      };
}
