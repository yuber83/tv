import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  final TrendingRepository trendingRepository;

  Future<void> init() async {
    await loadMoviesAndSeries();
    await loadPerformers();
  }

  void onTimeWindowChaned(timeWindow) {
    if (state.moviesAndSeries.timeWindow == timeWindow) {
      return;
    }
    state = state.copyWith(
      moviesAndSeries: MoviesAndSeriesState.loading(timeWindow),
    );
    loadMoviesAndSeries();
  }

  Future<void> loadMoviesAndSeries(
      {MoviesAndSeriesState? moviesAndSeries}) async {
    if (moviesAndSeries != null) {
      state = state.copyWith(
        moviesAndSeries: moviesAndSeries,
      );
    }
    final timeWindow = state.moviesAndSeries.timeWindow;

    final result = await trendingRepository.getMoviesAndSeries(timeWindow);
    state = result.when(
        left: (_) => state.copyWith(
              moviesAndSeries: MoviesAndSeriesState.failed(
                timeWindow,
              ),
            ),
        right: (list) => state.copyWith(
              moviesAndSeries: MoviesAndSeriesState.loaded(
                timeWindow: timeWindow,
                list: list,
              ),
            ));
  }

  Future<void> loadPerformers({PerformersState? performers}) async {
    if (performers != null) {
      state = state.copyWith(performers: performers);
    }
    final result = await trendingRepository.getPerformers();

    state = result.when(
      left: (left) =>
          state.copyWith(performers: const PerformersState.failed()),
      right: (list) => state.copyWith(
        performers: PerformersState.loaded(list),
      ),
    );
  }
}
