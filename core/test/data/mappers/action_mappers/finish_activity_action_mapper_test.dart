import 'package:activity_builder/src/data/mappers/actions/finish_activity_action/finish_activity_action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';
import 'package:activity_builder/src/domain/entities/actions/finish_activity_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'GoNextActionMapper tests',
    () {
      final mapper = FinishActivityActionMapper();
      const object = FinishActivityAction();
      final receivedJson = {
        'type': 'FinishActivity',
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

          expect(action.runtimeType, FinishActivityAction);
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
