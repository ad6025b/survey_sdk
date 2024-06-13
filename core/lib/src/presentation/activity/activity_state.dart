import 'package:survey_sdk/src/domain/entities/question_answer.dart';
import 'package:survey_sdk/src/domain/entities/activity_data.dart';
import 'package:survey_sdk/src/presentation/utils/activity_error_state.dart';

abstract class ActivityState {
  const ActivityState();
}

/// Represents the state when the activity data is loaded.
class ActivityLoadedState extends ActivityState {
  /// The loaded activity data.
  final ActivityData activityData;

  /// The map of question index to corresponding answer.
  final Map<int, QuestionAnswer> answers;

  List<Object?> get props => [activityData, answers];

  const ActivityLoadedState({required this.activityData, this.answers = const {}});

  ActivityLoadedState copyWith({
    ActivityData? activityData,
    Map<int, QuestionAnswer>? answers,
  }) {
    return ActivityLoadedState(
      activityData: activityData ?? this.activityData,
      answers: answers ?? this.answers,
    );
  }
}

class ActivityErrorLoadState extends ActivityState {
  final List<String> providedErrors;
  final ActivityErrorState errorState;

  List<Object?> get props => [
        providedErrors,
        errorState,
      ];

  const ActivityErrorLoadState({
    required this.providedErrors,
    required this.errorState,
  });

  ActivityErrorLoadState copyWith({
    List<String>? providedErrors,
    ActivityErrorState? errorState,
  }) {
    return ActivityErrorLoadState(
      providedErrors: providedErrors ?? this.providedErrors,
      errorState: errorState ?? this.errorState,
    );
  }
}

/// Represents the initial empty state of the activity.
class ActivityEmptyState extends ActivityState {
  const ActivityEmptyState();
}
