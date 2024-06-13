import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_admin/data/repositories/file_system_repository_impl.dart';

import '../../utils/shared_mocks.mocks.dart';

void main() {
  final mockFilesystemDataSource = MockFilesystemDataSource();
  final mockActivityData = MockActivityData();
  final activityDataRepository =
      FileSystemRepositoryImpl(mockFilesystemDataSource);
  var activityData = <String, dynamic>{};

  group('test ActivityDataRepository', () {
    when(
      mockFilesystemDataSource.downloadActivityData({'test': 'test'}),
    )
    .thenAnswer(
      (_) => activityData = {'test': 'test'},
    );

    when(
      mockFilesystemDataSource.importActivityData(),
    )
    .thenAnswer(
      (_) => Future.value(mockActivityData),
    );
      

    test('get activity data', () {
      activityDataRepository.downloadActivityData({'test': 'test'});
      expect(activityData, {'test': 'test'});
    });

    test('import activity data', () async {
      final activityData = await activityDataRepository.importActivityData();
      expect(activityData, mockActivityData);
    });
  });
}
