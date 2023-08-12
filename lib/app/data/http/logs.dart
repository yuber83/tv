part of 'http.dart';

void _printLogs(Map<String, dynamic> logs, StackTrace? stackTrace) {
  if (kDebugMode) {
    final result = const JsonEncoder.withIndent(' ').convert(logs);
    log(
      '''
---------------------------------------------------------
        $result
---------------------------------------------------------
''',
      stackTrace: stackTrace,
    );
  }
}
