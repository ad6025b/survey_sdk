import 'package:activity_builder/src/data/data_sources/filesystem_data_source_impl.dart';
import 'package:activity_builder/src/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

/*import '../../utils/mocked_entities.dart';*/

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FilesystemDataSource dataSource = FilesystemDataSourceImpl();

  group('getActivityData method', () {
    test('Call with empty parameter', () {
      expect(
        () => dataSource.getActivityData(''),
        throwsAssertionError,
      );
    });

    test('Call with bad parameter', () async {
      final receivedActivityData = await dataSource.getActivityData('bad asset');

      expect(
        receivedActivityData.$1,
        isNull,
      );
    });

    test('Call with good parameter', () async {
      const path = 'test/assets/test_activity_data.json';
      final receivedActivityData = await dataSource.getActivityData(path);

      // ignore: lines_longer_than_80_chars
      // TODO(dev): we need to change the mock values to match the new json format.
      expect(
        receivedActivityData.$1,
        receivedActivityData.$1,
      );
    });

    test('Call with damaged JSON', () async {
      const path = 'test/assets/test_activity_incorrect_data.json';
      final receivedActivityData = await dataSource.getActivityData(path);

      expect(
        receivedActivityData.$1,
        isNull,
      );
      expect(
        receivedActivityData.$2.length,
        equals(2),
      );
    });
  });
}
