import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/repositories/authentication_repository.dart';
import '../../../../routes/routes.dart';
import '../../../sign_in/views/controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
    if (controller.fetching) {
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

    controller.onFecthingChanged(true);

    final result = await context
        .read<AuthenticationRepository>()
        .signIn(controller.username, controller.password);

    if (!controller.mounted) {
      return;
    }
    result.when((failure) {
      controller.onFecthingChanged(false);

      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid Password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error'
      }[failure];
      final snackBar = SnackBar(content: Text(message!));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
