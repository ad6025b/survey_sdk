import 'dart:convert';

import 'package:survey_admin/data/data_sources/interfaces/session_storage_data_source.dart';
import 'package:activity_builder/activity_sdk.dart';
import 'package:universal_html/html.dart' as html;

class WebSessionStorageDataSource implements SessionStorageDataSource {
  static final _sessionStorage = html.window.sessionStorage;
  static const _activityDataKey = 'ActivityData';

  @override
  ActivityData? getActivityData() {
    final data = _sessionStorage[_activityDataKey];
    if (data != null) {
      return ActivityData.fromJson(jsonDecode(data));
    }
    return null;
  }

  @override
  void saveActivityData(ActivityData activityData) {
    _sessionStorage[_activityDataKey] = jsonEncode(activityData.toJson());
  }
}
