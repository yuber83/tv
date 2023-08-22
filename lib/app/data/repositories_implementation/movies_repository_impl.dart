import '../../domain/either/either.dart';
import '../../domain/failures/http_request.dart/http_request_failure.dart';
import '../../domain/models/movie/movie.dart';
import '../../domain/models/performer/performer.dart';
import '../../domain/repositories/movies_repository.dart';
import '../services/remote/movies_api.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesAPI _moviesAPI;

  MoviesRepositoryImpl(this._moviesAPI);
  @override
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) {
    return _moviesAPI.getMovieById(id);
  }

  @override
  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(
      int movieId) async {
    await Future.delayed(const Duration(seconds: 4));
    return _moviesAPI.getCastByMovie(movieId);
  }
}
