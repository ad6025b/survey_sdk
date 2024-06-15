import 'package:activity_builder/src/data/mappers/question_types/choice_question_data/choice_question_data_mapper_ver1.dart';
import 'package:activity_builder/src/domain/entities/question_types/choice_question_data.dart';
import 'package:activity_builder/src/domain/entities/question_types/question_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Choice question mapper tests',
    () {
      final mapper = ChoiceQuestionDataMapperVer1();
      const question = ChoiceQuestionData.common();
      final receivedJson = mapper.toJson(question);

      test(
        'fromJson',
        () {
          final receivedQuestion = mapper.fromJson(receivedJson);

          expect(receivedQuestion.runtimeType, equals(question.runtimeType));
          expect(receivedQuestion, equals(question));
        },
      );

      test(
        'toJson',
        () {
          final json = mapper.toJson(question);

          expect(json, equals(receivedJson));
        },
      );

      test(
        'fromType',
        () {
          final receivedQuestion = QuestionData.fromType(receivedJson, 1);

          expect(receivedQuestion.runtimeType, ChoiceQuestionData);
          expect(receivedQuestion, equals(question));
        },
      );
    },
  );
}
