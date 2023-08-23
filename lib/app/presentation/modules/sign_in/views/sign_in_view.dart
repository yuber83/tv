import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/sign_in_controller.dart';
import 'controller/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (BuildContext context) => SignInController(
          sessionController: context.read(),
          favoritesController: context.read(),
          const SignInState(),
          authenticationRepository: context.read()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Builder(
                builder: (context) {
                  final controller = Provider.of<SignInController>(context);
                  return AbsorbPointer(
                    absorbing: controller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: 'ytorox',
                          onChanged: (text) {
                            controller.onUsernameChanged(text);
                          },
                          decoration:
                              const InputDecoration(hintText: 'username'),
                          validator: (text) {
                            text = text?.trim().toLowerCase() ?? '';
                            if (text.isEmpty) {
                              return 'Invalid username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: 'Tueagles83.',
                          onChanged: (text) {
                            controller.onPasswordChanged(text);
                          },
                          decoration:
                              const InputDecoration(hintText: 'username'),
                          validator: (text) {
                            text = text?.replaceAll(' ', '') ?? '';
                            if (text.length < 4) {
                              return 'invalid password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        //aqui un error esque cuando _fetching es true, no se muestra Builder por eso el contexto falla
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
