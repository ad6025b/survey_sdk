import 'package:equatable/equatable.dart';
import 'package:activity_builder/activity_sdk.dart';

abstract class BuilderState extends Equatable {
  final ActivityData activityData;

  const BuilderState({
    required this.activityData,
  });

  BuilderState copyWith({
    ActivityData? activityData,
  });
}

class EditQuestionBuilderState extends BuilderState {
  final int selectedIndex;

  @override
  List<Object?> get props => [selectedIndex, activityData];

  const EditQuestionBuilderState({
    required super.activityData,
    required this.selectedIndex,
  });

  @override
  BuilderState copyWith({
    int? selectedIndex,
    ActivityData? activityData,
  }) {
    return EditQuestionBuilderState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      activityData: activityData ?? this.activityData,
    );
  }
}

class PreviewQuestionBuilderState extends BuilderState {
  final QuestionData? selectedQuestion;

  @override
  List<Object?> get props => [selectedQuestion, activityData];

  const PreviewQuestionBuilderState({
    required super.activityData,
    required this.selectedQuestion,
  });

  @override
  BuilderState copyWith({
    ActivityData? activityData,
    QuestionData? selectedQuestion,
  }) {
    return PreviewQuestionBuilderState(
      activityData: activityData ?? this.activityData,
      selectedQuestion: selectedQuestion ?? this.selectedQuestion,
    );
  }

}

class ImportSuccessActivityDataBuilderState extends BuilderState {
  @override
  List<Object?> get props => [activityData];

  const ImportSuccessActivityDataBuilderState({
    required super.activityData,
  });

  @override
  BuilderState copyWith({
    ActivityData? activityData,
  }) {
    return ImportSuccessActivityDataBuilderState(
      activityData: activityData ?? this.activityData,
    );
  }
}

class ImportErrorActivityDataBuilderState extends BuilderState {
  @override
  List<Object?> get props => [activityData];

  const ImportErrorActivityDataBuilderState({
    required super.activityData,
  });

  @override
  BuilderState copyWith({
    ActivityData? activityData,
  }) {
    return ImportErrorActivityDataBuilderState(
      activityData: activityData ?? this.activityData,
    );
  }
}
