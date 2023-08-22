import 'package:flutter/material.dart';

import '../modules/favorites/views/favorites_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.spash: (context) => const SplahView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.favorites: (context) => const FavoritesView(),
    // Routes.movie: (context) => MovieView(
    //       movieId: ModalRoute.of(context)?.settings.arguments as int,
    //     ),
  };
}
