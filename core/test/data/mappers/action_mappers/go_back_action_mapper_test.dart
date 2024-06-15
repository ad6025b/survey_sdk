import 'package:flutter_test/flutter_test.dart';
import 'package:activity_builder/src/data/mappers/actions/go_back_action/go_back_action_mapper.dart';
import 'package:activity_builder/src/domain/entities/actions/go_back_action.dart';
import 'package:activity_builder/src/domain/entities/actions/activity_action.dart';

void main() {
  group(
    'GoBackActionMapper tests',
        () {
      final mapper = GoBackActionMapper();
      const object = GoBackAction();
      final receivedJson = {
        'type': 'GoBack',
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

          expect(action.runtimeType, GoBackAction);
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
