import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:survey_admin/data/data_sources/interfaces/filesystem_data_source.dart';
import 'package:activity_builder/activity_sdk.dart';
import 'package:universal_html/html.dart' as html;

class WebFilesystemDataSourceImpl implements FilesystemDataSource {
  @override
  Future<void> downloadActivityData(Map<String, dynamic> exportJson) async {
    const encoder = JsonEncoder.withIndent('  ');
    final mapObject = encoder.convert(exportJson);

    final bytes = utf8.encode(mapObject);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'questions.json';
    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Future<ActivityData?> importActivityData() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    try {
      final bytes = result?.files.single.bytes;
      final string = bytes?.let(const Utf8Decoder().convert);
      final map = string?.let((str) => json.decode(str));
      return map != null ? ActivityData.fromJson(map) : null;
    } catch (_) {
      return null;
    }
  }
}

extension _LetExtension<T> on T {
  R let<R>(R Function(T) block) => block(this);
}
