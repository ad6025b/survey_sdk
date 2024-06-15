import 'package:activity_builder/src/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:activity_builder/src/domain/entities/activity_data.dart';
import 'package:activity_builder/src/domain/repository_interfaces/activity_data_repository.dart';

class ActivityDataRepositoryImpl implements ActivityDataRepository {
  final FilesystemDataSource _fileSystemDataSource;

  ActivityDataRepositoryImpl(this._fileSystemDataSource);

  @override
  Future<(ActivityData?, List<String>)> getActivityData(String filePath) =>
      _fileSystemDataSource.getActivityData(filePath);
}
