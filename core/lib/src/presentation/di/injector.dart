import 'package:survey_sdk/src/data/data_sources/filesystem_data_source_impl.dart';
import 'package:survey_sdk/src/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:survey_sdk/src/data/repositories/activity_data_repository_impl.dart';
import 'package:survey_sdk/src/domain/repository_interfaces/activity_data_repository.dart';
import 'package:survey_sdk/src/presentation/activity/activity_cubit.dart';
import 'package:survey_sdk/activity_sdk.dart';

class Injector {
  late ActivityCubit activityCubit;
  static final Injector _singleton = Injector._internal();
  late FilesystemDataSource _filesystemDataSource;
  late ActivityDataRepository activityDataRepository;

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  void init() {
    _filesystemDataSource = FilesystemDataSourceImpl();

    activityDataRepository = ActivityDataRepositoryImpl(_filesystemDataSource);

    activityCubit = ActivityCubit(activityDataRepository);
  }
}
