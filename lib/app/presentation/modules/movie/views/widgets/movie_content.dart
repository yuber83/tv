import 'package:flutter/material.dart';

import '../../../../../domain/models/movie/movie.dart';
import '../../controller/state/movie_state.dart';
import 'movie_cast.dart';
import 'movie_header.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({
    super.key,
    required this.state,
  });
  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieHeader(movie: movie),
          _Resumen(
            movie: movie,
          ),
          MovieCast(
            movieId: movie.id,
          ),
        ],
      ),
    );
  }
}

class _Resumen extends StatelessWidget {
  const _Resumen({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        movie.overview,
      ),
    );
  }
}
