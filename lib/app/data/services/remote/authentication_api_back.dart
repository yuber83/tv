import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._client);
  final Client _client;
  final _baseUrl = 'https://api.themoviedb.org/3';
  final _apiKey =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTJmYTRjZTBlYzc2MmUwNjcxMzQxNzZmZDUxNTkwOSIsInN1YiI6IjVmNWU0ZmMyZWMwYzU4MDAzNWI0OGJhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dzZHeJoJhiCWvnXeQO3DKWhlVoq42h9zzggDI9HrmZw';

  Future<String?> createRequestToken() async {
    try {
      final Response response = await _client.get(
        Uri.parse(
          '$_baseUrl/authentication/token/new',
        ),
        headers: {
          'Authorization': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final json = Map.from(jsonDecode(response.body));
        return json['request_token'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required username,
    required password,
    required requestToken,
  }) async {
    try {
      final url = '$_baseUrl/authentication/token/validate_with_login';
      print('url $url');
      final response = await _client.post(
        Uri.parse(url),
        // https://api.themoviedb.org/3/authentication/token/validate_with_login
        headers: {
          'Authorization': _apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'request_token': requestToken,
        }),
      );
      print('response statusCode ${response.statusCode}');
      switch (response.statusCode) {
        case 200:
          final json = Map<String, dynamic>.from(jsonDecode(response.body));

          print('response ${json.toString()}');
          final newRequestToken = json['request_token'];
          return Either.right(newRequestToken);

        case 401:
          return Either.left(SignInFailure.unauthorized);

        case 404:
          return Either.left(SignInFailure.notFound);

        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    print('created session');
    try {
      // final url = '$_baseUrl/authentication/session/new';
      // const url = 'https://api.themoviedb.org/3/authentication/session/new';
      final url =
          'https://api.themoviedb.org/3/authentication/token/new?api_key=$_apiKey';
      // /3/authentication/session/new

      final response = await _client.post(
        Uri.parse(url),
        headers: {
          'Authorization': _apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {'request_token': requestToken},
        ),
      );

/**
 * 
 * curl --request POST \
     --url https://api.themoviedb.org/3/authentication/session/new \
     --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTJmYTRjZTBlYzc2MmUwNjcxMzQxNzZmZDUxNTkwOSIsInN1YiI6IjVmNWU0ZmMyZWMwYzU4MDAzNWI0OGJhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dzZHeJoJhiCWvnXeQO3DKWhlVoq42h9zzggDI9HrmZw' \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
  "request_token": "6bc047b88f669d1fb86574f06381005d93d3517a"
}
 * 
 */

      print('url');
      print(url);
      print('response ${response.statusCode}');
      if (response.statusCode == 200) {
        final sessionId = jsonDecode(response.body)['session_id'] as String;
        return Either.right(sessionId);
      }
      return Either.left(SignInFailure.unknown);
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }
}
