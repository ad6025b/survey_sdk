import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_admin/data/repositories/session_storage_repository_impl.dart';

import '../../utils/shared_mocks.mocks.dart';

void main() {
  final mockSessionStorageSource = MockSessionStorageDataSource();
  final mockActivityData = MockActivityData();
  final sessionStorageRepository =
      SessionStorageRepositoryImpl(mockSessionStorageSource);
  MockActivityData? savedData;

  group('test SessionStorageRepositoryImpl', () {
    when(
      mockSessionStorageSource.saveActivityData(mockActivityData),
    )
    .thenAnswer(
      (_) => savedData = mockActivityData,
    );

    when(
      mockSessionStorageSource.getActivityData(),
    )
    .thenAnswer(
      (_) => mockActivityData,
    );
      

    test('get activity data', () {
      final activityData = mockSessionStorageSource.getActivityData();
      expect(activityData, mockActivityData);
    });

    test('save activity data', () {
      sessionStorageRepository.saveActivityData(mockActivityData);
      expect(savedData, mockActivityData);
    });
  });
}
