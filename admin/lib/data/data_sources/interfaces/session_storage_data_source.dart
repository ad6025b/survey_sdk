import 'package:activity_builder/activity_sdk.dart';

abstract class SessionStorageDataSource {
  void saveActivityData(ActivityData activityData);

  ActivityData? getActivityData();
}
