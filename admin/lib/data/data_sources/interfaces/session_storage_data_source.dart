import 'package:survey_sdk/activity_sdk.dart';

abstract class SessionStorageDataSource {
  void saveActivityData(ActivityData activityData);

  ActivityData? getActivityData();
}
