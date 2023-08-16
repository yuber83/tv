import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/failures/http_request.dart/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../views/widgets/trending_time_window.dart';
import 'trending_tile.dart';

typedef EitherListMedia = Either<HttpRequestFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late Future<EitherListMedia> _future;
  TimeWindow _timeWindow = TimeWindow.day;

  TrendingRepository get _trendingRepository => context.read();

  @override
  void initState() {
    super.initState();
    _future = _trendingRepository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
            timeWindow: _timeWindow,
            onChanged: (newTimeWindow) {
              setState(() {
                _timeWindow = newTimeWindow;
                _future = _trendingRepository.getMoviesAndSeries(newTimeWindow);
              });
            }),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, contraints) {
              final width = contraints.maxHeight * 0.65;
              return Center(
                child: FutureBuilder<EitherListMedia>(
                  // key: ValueKey(_future),
                  future: _future,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return snapshot.data!.when(
                      left: (failure) => Text(
                        failure.toString(),
                      ),
                      right: (list) {
                        return ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            final media = list[index];
                            return TrendingTile(
                              media: media,
                              width: width,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
