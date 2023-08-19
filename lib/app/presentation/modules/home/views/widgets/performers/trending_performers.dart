import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../domain/either/either.dart';
import '../../../../../../domain/failures/http_request.dart/http_request_failure.dart';
import '../../../../../../domain/models/performer/performer.dart';
import '../../../../../../domain/repositories/trending_repository.dart';
import 'performer_tile.dart';

typedef EitherListPerformer = Either<HttpRequestFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherListPerformer> _future;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    _pageController = PageController();
    _future = context.read<TrendingRepository>().getPerformers();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<EitherListPerformer>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data!.when(
            left: (_) => const Text('Error'),
            right: (list) => Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    padEnds: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final performer = list[index];
                      return PerformerTile(performer: performer);
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: _pageController,
                  builder: (
                    _,
                    __,
                  ) {
                    final int currentCard = _pageController.page?.toInt() ?? 0;
                    return Text('${currentCard + 1}/${list.length}');
                  },
                ),
                const SizedBox(height: 10)
              ],
            ),
          );
        },
      ),
    );
  }
}
