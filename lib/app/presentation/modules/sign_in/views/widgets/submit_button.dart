import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../../../global/controllers/session_controller.dart';
import '../../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    }

    return MaterialButton(
        onPressed: () {
          final isValid = Form.of(context).validate();
          if (isValid) {
            _submit(context);
          }
        },
        color: Colors.blue,
        child: const Text('Sign in'));
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }
    result.when(left: (failure) {
      final message = failure.when(
        notVerified: () => 'Email not verified',
        notFoud: () => 'Not Found',
        network: () => 'Network error',
        unauthorized: () => 'Invalid password',
        unknown: () => 'Error desconocido',
      );

      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, right: (user) {
      final SessionController sessionController = context.read();
      final FavoritesController favoritesController = context.read();
      sessionController.setUser(user);
      favoritesController.init();
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
