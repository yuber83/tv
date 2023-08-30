import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';

enum HttpMethod { get, post, patch, delete, put }

class Http {
  Http({
    required Client client,
    required String baseUrl,
    required String apiKey,
  })  : _client = client,
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  final Client _client;
  final String _baseUrl;
  final String _apiKey;

  Future<Either<HttpFailure, R>> request<R>(
    String path, {
    required R Function(dynamic responseBody) onSuccess,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;

    try {
      if (useApiKey) {
        headers = {
          'Authorization': _apiKey,
          ...headers,
        };
      }
      Uri uri = Uri.parse(path.startsWith('http') ? path : '$_baseUrl$path');
      if (queryParameters.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParameters);
      }

      headers = {
        // 'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
        ...headers,
      };

      late final Response response;
      final bodyString = jsonEncode(body);
      logs = {
        'url': uri.toString(),
        'startTime': DateTime.now().toString(),
        'method': method.name,
        'body': body,
      };
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(uri, headers: headers).timeout(timeout);
          break;
        case HttpMethod.post:
          response = await _client
              .post(
                uri,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.patch:
          _client.patch(uri);
          response = await _client
              .patch(
                uri,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.delete:
          response = await _client
              .delete(
                uri,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
        case HttpMethod.put:
          response = await _client
              .put(
                uri,
                headers: headers,
                body: bodyString,
              )
              .timeout(timeout);
          break;
      }

      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(response.body);
      logs = {
        ...logs,
        'statusCode': statusCode,
        'responseBody': responseBody,
      };

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(onSuccess(responseBody));
      }
      return Either.left(
          HttpFailure(statusCode: statusCode, data: responseBody));
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        // 'exception': e.runtimeType.toString(),
        'exception': e.toString()
      };

      if (e is SocketException || e is ClientException) {
        logs = {...logs, 'exception': 'NetworkException'};
        return Either.left(HttpFailure(exception: NetworkException()));
      }

      return Either.left(HttpFailure(exception: e));
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };

      // _printLogs(logs, stackTrace);
    }
  }
}
