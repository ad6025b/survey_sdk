import 'package:equatable/equatable.dart';
import 'package:activity_builder/src/data/mappers/actions/finish_activity_action/finish_activity_action_mapper.dart';
import 'package:activity_builder/src/data/mappers/actions/go_back_action/go_back_action_mapper.dart';
import 'package:activity_builder/src/data/mappers/actions/go_next_action/go_next_action_mapper.dart';
import 'package:activity_builder/src/data/mappers/actions/go_to_action/go_to_action_mapper.dart';
import 'package:activity_builder/src/data/mappers/actions/skip_question_action/skip_question_action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/finish_activity_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_back_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_next_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_to_action.dart';
import 'package:activity_builder/src/domain/entities/actions/skip_question_action.dart';
import 'package:activity_builder/src/domain/entities/constants/action_types.dart';

abstract final class _Fields {
  static const String type = 'type';
}

abstract class ActivityAction extends Equatable {
  String get type;

  const ActivityAction();

  static Map<String, dynamic> toJson(ActivityAction data) =>
      switch (data.runtimeType) {
        GoToAction => GoToActionMapper().toJson(
            data as GoToAction,
          ),
        FinishActivityAction => FinishActivityActionMapper().toJson(
            data as FinishActivityAction,
          ),
        SkipQuestionAction => SkipQuestionActionMapper().toJson(
            data as SkipQuestionAction,
          ),
        GoNextAction => GoNextActionMapper().toJson(
            data as GoNextAction,
          ),
        GoBackAction => GoBackActionMapper().toJson(
            data as GoBackAction,
          ),
        _ => throw UnimplementedError(),
      };

  static ActivityAction? fromJson(dynamic json) => json == null
      ? null
      : switch ((json as Map<String, dynamic>)[_Fields.type]) {
          ActionTypes.goToAction => GoToActionMapper().fromJson(json),
          ActionTypes.finishActivityAction => FinishActivityActionMapper().fromJson(
              json,
            ),
          ActionTypes.skipQuestionAction =>
            SkipQuestionActionMapper().fromJson(json),
          ActionTypes.goNextAction => GoNextActionMapper().fromJson(
              json,
            ),
          ActionTypes.goBackAction => GoBackActionMapper().fromJson(
              json,
            ),
          _ => null,
        };
}
