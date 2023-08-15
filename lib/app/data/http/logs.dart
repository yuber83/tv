part of 'http.dart';

void _printLogs(Map<String, dynamic> logs, StackTrace? stackTrace) {
  print(stackTrace);
  if (kDebugMode) {
    print('pribt >> logs');
    print(logs);
    final result = const JsonEncoder.withIndent(' ').convert(logs);
    // final result = '$logs $stackTrace';
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
