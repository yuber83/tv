import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoritesController favoritesController = context.watch();

    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoritesController.state.maybeMap(
            // orElse: () => const SizedBox.shrink(),
            orElse: () => const Text('error'),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            loaded: (favoritesState) => IconButton(
              icon: Icon(
                favoritesState.movies.containsKey(movieState.movie.id)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
