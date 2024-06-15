import 'package:flutter_test/flutter_test.dart';
import 'package:activity_builder/src/data/data_sources/filesystem_data_source_impl.dart';
import 'package:activity_builder/src/data/repositories/activity_data_repository_impl.dart';
import 'package:activity_builder/src/domain/entities/activity_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final activityDataSource = FilesystemDataSourceImpl();
  final activityRepository = ActivityDataRepositoryImpl(activityDataSource);

  const pathWithCorrectJson = 'test/assets/test_activity_data.json';
  const pathWithIncorrectJson = 'test/assets/test_activity_incorrect_data.json';

  group('test ActivityDataRepository', () {
    test(
      'getActivityData should receive correct data when json is correct',
      () async {
        final receivedActivityData = await activityRepository.getActivityData(
          pathWithCorrectJson,
        );

        expect(receivedActivityData.$1 is ActivityData, isTrue);
        expect(receivedActivityData.$2.isEmpty, isTrue);
      },
    );

    test(
      'getActivityData should receive correct data when json is incorrect',
      () async {
        final receivedActivityData = await activityRepository.getActivityData(
          pathWithIncorrectJson,
        );

        expect(receivedActivityData.$1, isNull);
        expect(receivedActivityData.$2.length, equals(2));
      },
    );

    test(
      'getActivityData should receive correct data when path is incorrect',
      () async {
        final receivedActivityData = await activityRepository.getActivityData(
          'incorrect_path',
        );

        expect(receivedActivityData.$1, isNull);
        expect(
          receivedActivityData.$2.length,
          equals(2),
        );
      },
    );
  });
}
