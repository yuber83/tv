part of 'http.dart';

dynamic _parseResponseBody(responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (_) {
    return responseBody;
  }
}
