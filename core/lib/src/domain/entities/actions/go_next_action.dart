import 'package:survey_sdk/src/domain/entities/actions/activity_action.dart';
import 'package:survey_sdk/src/domain/entities/constants/action_types.dart';

final class GoNextAction extends ActivityAction {
  @override
  String get type => ActionTypes.goNextAction;

  @override
  int get hashCode => type.hashCode ^ super.hashCode;

  @override
  List<Object?> get props => [];

  const GoNextAction();

  @override
  bool operator ==(Object other) => runtimeType == other.runtimeType;
}
