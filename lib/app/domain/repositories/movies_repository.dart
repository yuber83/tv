import '../either/either.dart';
import '../failures/http_request.dart/http_request_failure.dart';
import '../models/movie/movie.dart';
import '../models/performer/performer.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id);
  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(
      int movieId);
}
