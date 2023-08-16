import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/failures/http_request.dart/http_request_failure.dart';
import '../../domain/models/media/media.dart';
import '../../domain/repositories/trending_repository.dart';
import '../services/remote/trending_api.dart';

class TrendingRepositoryImplentation implements TrendingRepository {
  TrendingRepositoryImplentation(this._trendingAPI);
  final TrendingAPI _trendingAPI;

  @override
  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) {
    return _trendingAPI.getMoviesAndSeries(
      timeWindow,
    );
  }
}
