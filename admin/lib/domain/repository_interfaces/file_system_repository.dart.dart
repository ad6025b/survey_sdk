import 'package:activity_builder/activity_sdk.dart';

abstract class FileSystemRepository {
  void downloadActivityData(Map<String, dynamic> exportJson);

  Future<ActivityData?> importActivityData();
}
