import 'package:activity_builder/activity_sdk.dart';
import 'package:mockito/annotations.dart';
import 'package:survey_admin/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:survey_admin/data/data_sources/interfaces/session_storage_data_source.dart';
import 'package:survey_admin/domain/repository_interfaces/file_system_repository.dart.dart';
import 'package:survey_admin/domain/repository_interfaces/session_storage_repository.dart';

@GenerateMocks([
  FilesystemDataSource,
  SessionStorageDataSource,
  FileSystemRepository,
  SessionStorageRepository,
  ActivityData,
])
class SharedMocks {}
