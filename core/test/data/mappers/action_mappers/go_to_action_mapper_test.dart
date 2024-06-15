import 'package:activity_builder/src/data/mappers/actions/go_to_action/go_to_action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';
import 'package:activity_builder/src/domain/entities/actions/go_to_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'GoBackActionMapper tests',
    () {
      final mapper = GoToActionMapper();
      const questionIndex = 2;
      const object = GoToAction(questionIndex: questionIndex);
      final receivedJson = {
        'type': 'GoTo',
        'questionIndex': 2,
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

          expect(action.runtimeType, GoToAction);
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
