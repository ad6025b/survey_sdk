import 'package:survey_admin/data/data_sources/interfaces/session_storage_data_source.dart';
import 'package:survey_admin/domain/repository_interfaces/session_storage_repository.dart';
import 'package:survey_sdk/activity_sdk.dart';

class SessionStorageRepositoryImpl implements SessionStorageRepository {
  final SessionStorageDataSource _sessionStorageDataSource;

  const SessionStorageRepositoryImpl(this._sessionStorageDataSource);

  @override
  ActivityData? getActivityData() => _sessionStorageDataSource.getActivityData();

  @override
  void saveActivityData(ActivityData activityData) =>
      _sessionStorageDataSource.saveActivityData(activityData);
}
