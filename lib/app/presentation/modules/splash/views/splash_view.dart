import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});

  @override
  State<SplahView> createState() => _SplahViewState();
}

class _SplahViewState extends State<SplahView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _init();
    });
  }

  Future<void> _init() async {
    final routeName = await () async {
      final ConnectivityRepository connectivityRepository = context.read();
      final AuthenticationRepository authenticationRepository = context.read();
      final AccountRepository accountRepository = context.read();
      final SessionController sessionController = context.read();
      final FavoritesController favoritesController = context.read();

      final hasInternet = connectivityRepository.hasInternet;

      if (!hasInternet) {
        return Routes.offline;
      }

      final isSignedIn = await authenticationRepository.isSignedIn;

      if (!isSignedIn) {
        return Routes.signIn;
      }

      final user = await accountRepository.getUserData();

      if (user != null) {
        sessionController.setUser(user);
        favoritesController.init();
        return Routes.home;
      }

      return Routes.signIn;
    }();

    if (mounted) {
      _goTo(routeName);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
