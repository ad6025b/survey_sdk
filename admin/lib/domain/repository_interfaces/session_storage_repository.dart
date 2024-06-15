import 'package:activity_builder/activity_sdk.dart';

abstract class SessionStorageRepository {
  void saveActivityData(ActivityData activityData);

  ActivityData? getActivityData();
}
