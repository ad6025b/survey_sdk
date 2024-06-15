import 'package:activity_builder/src/data/data_sources/filesystem_data_source_impl.dart';
import 'package:activity_builder/src/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:activity_builder/src/data/repositories/activity_data_repository_impl.dart';
import 'package:activity_builder/src/domain/repository_interfaces/activity_data_repository.dart';
import 'package:activity_builder/src/presentation/activity/activity_cubit.dart';

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
