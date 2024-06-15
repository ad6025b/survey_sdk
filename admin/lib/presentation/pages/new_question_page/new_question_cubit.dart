import 'package:activity_builder/activity_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_admin/presentation/pages/new_question_page/new_question_state.dart';
import 'package:survey_admin/presentation/pages/new_question_page/new_question_tabs.dart';

class NewQuestionCubit extends Cubit<NewQuestionState> {
  NewQuestionCubit(ActivityData data)
      : super(
          NewQuestionState(data: data),
        );

  void selectTab(NewQuestionTabs tab) => emit(
        state.copyWith(selectedTab: tab),
      );

  void updateData(QuestionData data) {
    var activityData = state.data;
    final common = activityData.commonTheme;
    switch (data.type) {
      case QuestionTypes.choice:
        activityData = activityData.copyWith(
          commonTheme: common.copyWith(choice: data as ChoiceQuestionData),
        );
      case QuestionTypes.input:
        activityData = activityData.copyWith(
          commonTheme: common.copyWith(input: data as InputQuestionData),
        );

      case QuestionTypes.info:
        activityData = activityData.copyWith(
          commonTheme: common.copyWith(info: data as InfoQuestionData),
        );
      case QuestionTypes.slider:
        activityData = activityData.copyWith(
          commonTheme: common.copyWith(slider: data as SliderQuestionData),
        );
    }
    emit(state.copyWith(data: activityData));
  }
}
