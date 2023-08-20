import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/performer/performer.dart';

part 'home_state.freezed.dart';
// part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    ///
    @Default(MoviesAndSeriesState.loading(TimeWindow.day))
    MoviesAndSeriesState moviesAndSeries,
    @Default(PerformersState.loading()) PerformersState performers,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required TimeWindow timeWindow,
    required List<Media> list,
  }) = MoviesAndSeriesStateLoaded;
}

@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading() = _PerformersLoading;
  const factory PerformersState.failed() = _PerformersFailed;
  const factory PerformersState.loaded(
    List<Performer> list,
  ) = _PerformersLoaded;
}
