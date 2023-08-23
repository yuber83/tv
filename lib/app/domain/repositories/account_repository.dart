import '../either/either.dart';
import '../failures/http_request.dart/http_request_failure.dart';
import '../models/media/media.dart';
import '../models/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
    MediaType mediaType,
  );

  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType type,
    required bool favorite,
  });
}
