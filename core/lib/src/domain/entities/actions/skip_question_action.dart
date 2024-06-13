import 'package:survey_sdk/src/domain/entities/actions/activity_action.dart';
import 'package:survey_sdk/src/domain/entities/constants/action_types.dart';

final class SkipQuestionAction extends ActivityAction {
  @override
  String get type => ActionTypes.skipQuestionAction;

  @override
  int get hashCode => type.hashCode ^ super.hashCode;

  @override
  List<Object?> get props => [];

  const SkipQuestionAction();

  @override
  bool operator ==(Object other) => runtimeType == other.runtimeType;
}
