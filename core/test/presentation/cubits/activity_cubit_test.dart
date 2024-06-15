import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:activity_builder/src/data/repositories/activity_data_repository_impl.dart';
import 'package:activity_builder/src/presentation/activity/activity_state.dart';
import 'package:activity_builder/activity_sdk.dart';

import '../../../lib/src/presentation/activity/activity_cubit.dart';

// ignore: prefer-match-file-name
class MockActivityDataRepository extends Mock
    implements ActivityDataRepositoryImpl {}

// TODO(dev): add test save answer
void main() {
  group(
    'Activity cubit tests',
    () {
      final mockedActivityRepo = MockActivityDataRepository();
      final activityCubit = ActivityCubit(mockedActivityRepo);

      test(
        'Get activity data',
        () {
          final currentState = activityCubit.state;
          final activityData = ActivityData(
            questions: [],
            commonTheme: CommonTheme(
              slider: const SliderQuestionData.common(),
              choice: const ChoiceQuestionData.common(),
              input: InputQuestionData.common(),
              info: const InfoQuestionData.common(),
            ),
          );
          when(() => mockedActivityRepo.getActivityData(''))
              .thenAnswer((_) async => (activityData, <String>[]));
          activityCubit.initData('');
          if (currentState is ActivityLoadedState) {
            expect(currentState.activityData, activityData);
          }
        },
      );
    },
  );
}
