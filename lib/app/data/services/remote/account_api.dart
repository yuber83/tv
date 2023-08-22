import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request.dart/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../local/session_service.dart';
import '../utils/handle_failure.dart';

class AccountAPI {
  AccountAPI(this._http, this._sessionService);
  final SessionService _sessionService;

  final Http _http;

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request('/account/9658257', headers: {
      // final result = await _http.request('/account', headers: {
      'session_id': sessionId,
    }, onSuccess: (json) {
      return User.fromJson(json);
    });

    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
      MediaType mediaType) async {
    final sessionId = await _sessionService.sessionId;
    final accountId = await _sessionService.accountId;
    final result = await _http.request(
      '/account/$accountId/favorite/${mediaType == MediaType.movie ? "movies" : "tv"}',
      headers: {
        'session_id': sessionId ?? '',
      },
      onSuccess: (json) {
        final list = json['results'] as List;
        final newEntries = list.map(
          (e) {
            final media = Media.fromJson({
              ...e,
              'media_type': mediaType.name,
            });
            return MapEntry(media.id, media);
          },
        );
        final map = <int, Media>{};
        map.addEntries(newEntries);
        return map;
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (value) => Either.right(value),
    );
  }
}
