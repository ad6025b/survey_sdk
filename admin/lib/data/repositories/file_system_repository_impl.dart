import 'package:activity_builder/activity_sdk.dart';
import 'package:survey_admin/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:survey_admin/domain/repository_interfaces/file_system_repository.dart.dart';

class FileSystemRepositoryImpl extends FileSystemRepository {
  final FilesystemDataSource _fileSystemDataSource;

  FileSystemRepositoryImpl(this._fileSystemDataSource);

  @override
  Future<ActivityData?> importActivityData() =>
      _fileSystemDataSource.importActivityData();

  @override
  void downloadActivityData(Map<String, dynamic> exportJson) =>
      _fileSystemDataSource.downloadActivityData(exportJson);
}
