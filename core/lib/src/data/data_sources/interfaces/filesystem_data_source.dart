import 'package:activity_builder/src/domain/entities/activity_data.dart';

// ignore: one_member_abstracts
abstract class FilesystemDataSource {
  Future<(ActivityData?, List<String>)> getActivityData(String filePath);
}
