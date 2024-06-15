import 'package:activity_builder/src/data/mappers/actions/action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/skip_question_action.dart';

abstract final class _Fields {
  static const String type = 'type';
}

final class SkipQuestionActionMapper
    implements ActionMapper<SkipQuestionAction> {
  @override
  Map<String, dynamic> toJson(SkipQuestionAction data) {
    return {
      _Fields.type: data.type,
    };
  }

  @override
  SkipQuestionAction fromJson(Map<String, dynamic> json) {
    return const SkipQuestionAction();
  }
}
