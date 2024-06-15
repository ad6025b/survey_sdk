import 'package:flutter_test/flutter_test.dart';
import 'package:activity_builder/src/presentation/di/injector.dart';
import 'package:activity_builder/src/presentation/activity/activity_state.dart';
import 'package:activity_builder/activity_sdk.dart';

import '../presentation/widget/app_tester.dart';
import '../utils/mocked_entities.dart';

void main() {
  group('Info question page integration test', () {
    final app = AppTester(child: Activity(activityData: MockedEntities.data2));
    testWidgets('next button info click', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.text('Next'));
      final cubit = Injector().activityCubit;
      expect((cubit.state as ActivityLoadedState).answers.length, 0);
    });
  });
}
