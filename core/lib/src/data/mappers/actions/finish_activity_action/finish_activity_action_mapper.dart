import 'package:activity_builder/src/data/mappers/actions/action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/finish_activity_action.dart';

abstract final class _Fields {
  static const String type = 'type';
}

final class FinishActivityActionMapper
    implements ActionMapper<FinishActivityAction> {
  @override
  Map<String, dynamic> toJson(FinishActivityAction data) {
    return {
      _Fields.type: data.type,
    };
  }

  @override
  FinishActivityAction fromJson(Map<String, dynamic> json) {
    return const FinishActivityAction();
  }
}
