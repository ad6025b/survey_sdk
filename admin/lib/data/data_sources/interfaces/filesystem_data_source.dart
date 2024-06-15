import 'package:activity_builder/activity_sdk.dart';

abstract class FilesystemDataSource {
  void downloadActivityData(Map<String, dynamic> exportJson);

  Future<ActivityData?> importActivityData();
}
