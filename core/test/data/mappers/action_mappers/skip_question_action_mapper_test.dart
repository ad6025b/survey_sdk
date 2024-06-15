import 'package:flutter_test/flutter_test.dart';
import 'package:activity_builder/src/data/mappers/actions/skip_question_action/skip_question_action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/skip_question_action.dart';
import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';

void main() {
  group(
    'GoNextActionMapper tests',
    () {
      final mapper = SkipQuestionActionMapper();
      const object = SkipQuestionAction();
      final receivedJson = {
        'type': 'SkipQuestion',
      };

      test(
        'fromJson method',
        () {
          final action = mapper.fromJson(receivedJson);

          expect(action, equals(object));
        },
      );

      test(
        'toJson method',
        () {
          final json = mapper.toJson(object);

          expect(json, equals(receivedJson));
        },
      );

      test(
        'fromType',
        () {
          final action = ActivityAction.fromJson(receivedJson);

          expect(action.runtimeType, SkipQuestionAction);
          expect(action, equals(object));
        },
      );

      test(
        'toJsonByType',
        () {
          final json = ActivityAction.toJson(object);

          expect(json, equals(receivedJson));
        },
      );
    },
  );
}
