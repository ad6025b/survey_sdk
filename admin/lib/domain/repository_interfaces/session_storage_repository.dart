import 'package:survey_sdk/activity_sdk.dart';

abstract class SessionStorageRepository {
  void saveActivityData(ActivityData activityData);

  ActivityData? getActivityData();
}
