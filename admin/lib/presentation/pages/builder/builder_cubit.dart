import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_admin/domain/repository_interfaces/file_system_repository.dart.dart';
import 'package:survey_admin/domain/repository_interfaces/session_storage_repository.dart';
import 'package:survey_admin/presentation/app/di/injector.dart';
import 'package:survey_admin/presentation/pages/builder/builder_state.dart';
import 'package:survey_admin/presentation/utils/common_data.dart';
import 'package:survey_sdk/activity_sdk.dart';

class BuilderCubit extends Cubit<BuilderState> {
  final FileSystemRepository _fileSystemRepository;
  final SessionStorageRepository _sessionStorageRepository;

  BuilderCubit(
    this._fileSystemRepository,
    this._sessionStorageRepository,
  ) : super(
          EditQuestionBuilderState(
            activityData: i.get<CommonData>().activityData,
            selectedIndex: 1,
          ),
        ) {
    _init();
  }

  void downloadActivityData() {
    _fileSystemRepository.downloadActivityData(state.activityData.toJson());
  }

  void copyActivityData() {
    final jsonText = jsonEncode(state.activityData.toJson());
    Clipboard.setData(ClipboardData(text: jsonText));
  }

  void updateCommonTheme(ActivityData data) {
    _sessionStorageRepository.saveActivityData(data);
    emit(state.copyWith(activityData: data));
  }

  void select(QuestionData data) {
    if (state is EditQuestionBuilderState ||
        state is ImportSuccessActivityDataBuilderState) {
      emit(
        EditQuestionBuilderState(
          selectedIndex: data.index,
          activityData: state.activityData,
        ),
      );
    } else if (state is PreviewQuestionBuilderState) {
      emit(
        PreviewQuestionBuilderState(
          activityData: state.activityData,
          selectedQuestion: data,
        ),
      );
    }
  }

  void deleteQuestionData(QuestionData data) {
    final questionList = List<QuestionData>.of(state.activityData.questions)
      ..remove(data);

    _updateIndex(questionList);

    final activityData = state.activityData.copyWith(questions: questionList);
    _sessionStorageRepository.saveActivityData(activityData);
    emit(state.copyWith(activityData: activityData));
    if (state.activityData.questions.isEmpty) {
      emit(
        EditQuestionBuilderState(
          selectedIndex: 0,
          activityData: state.activityData,
        ),
      );
    } else {
      select(state.activityData.questions.first);
    }
  }

  void addQuestionData(QuestionData data) {
    final questionList = List<QuestionData>.of(state.activityData.questions)
      ..add(data);

    final activityData = state.activityData.copyWith(questions: questionList);
    _sessionStorageRepository.saveActivityData(activityData);
    emit(state.copyWith(activityData: activityData));
    select(state.activityData.questions.last);
  }

  Future<void> importData() async {
    final selectedIndex = (state is EditQuestionBuilderState)
        ? (state as EditQuestionBuilderState).selectedIndex
        : 1;

    final activityData = await _fileSystemRepository.importActivityData();

    if (activityData != null) {
      emit(
        ImportSuccessActivityDataBuilderState(activityData: activityData),
      );
      select(activityData.questions.first);
    } else {
      emit(
        ImportErrorActivityDataBuilderState(activityData: state.activityData),
      );
      emit(
        EditQuestionBuilderState(
          selectedIndex: selectedIndex,
          activityData: state.activityData,
        ),
      );
    }
  }

  void updateQuestionData(QuestionData data) {
    final questions = List.of(state.activityData.questions);

    final index = questions.indexWhere(
      (question) => question.index == data.index,
    );
    if (index != -1) questions[index] = data;

    final activityData = state.activityData.copyWith(questions: questions);
    _sessionStorageRepository.saveActivityData(activityData);
    emit(state.copyWith(activityData: activityData));
  }

  void updateQuestions(List<QuestionData> questionList) {
    final activityData = state.activityData.copyWith(questions: questionList);
    _sessionStorageRepository.saveActivityData(activityData);
    emit(state.copyWith(activityData: activityData));
  }

  void openPreviewMode() {
    if (state is! EditQuestionBuilderState) return;

    final index = (state as EditQuestionBuilderState).selectedIndex;
    final selectedQuestion =
        state.activityData.questions.firstWhereOrNull((e) => e.index == index);

    emit(
      PreviewQuestionBuilderState(
        selectedQuestion: selectedQuestion,
        activityData: state.activityData,
      ),
    );
  }

  void openEditMode() {
    if (state is! PreviewQuestionBuilderState) return;

    final selectedIndex =
        (state as PreviewQuestionBuilderState).selectedQuestion?.index ?? 1;

    emit(
      EditQuestionBuilderState(
        selectedIndex: selectedIndex,
        activityData: state.activityData,
      ),
    );
  }

  void _updateIndex(List<QuestionData> data) {
    for (var i = 0; i < data.length; i++) {
      data[i] = data[i].copyWith(index: i + 1);
    }
  }

  void _init() {
    final activityData = _sessionStorageRepository.getActivityData() ??
        i.get<CommonData>().activityData;
    emit(state.copyWith(activityData: activityData));
  }
}
