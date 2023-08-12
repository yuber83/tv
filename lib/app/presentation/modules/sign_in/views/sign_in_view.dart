import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/enums.dart';
import '../../../routes/routes.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = 'ytorox', _password = 'Tueagles83.';
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: AbsorbPointer(
              absorbing: _fetching,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: 'ytorox',
                    onChanged: (text) {
                      setState(() {
                        _username = text.trim().toLowerCase();
                      });
                    },
                    decoration: const InputDecoration(hintText: 'username'),
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
                      setState(() {
                        _password = text.replaceAll(' ', '');
                      });
                    },
                    decoration: const InputDecoration(hintText: 'username'),
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
                  Builder(builder: (context) {
                    return _fetching
                        ? const CircularProgressIndicator()
                        : MaterialButton(
                            onPressed: () {
                              final isValid = Form.of(context).validate();
                              if (isValid) {
                                _submit(context);
                              }
                            },
                            color: Colors.blue,
                            child: const Text('Sign in'),
                          );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    final result = await Injector.of(context)
        .authenticationRepository
        .signIn(_username, _password);

    if (!mounted) {
      return;
    }

    result.when((failure) {
      setState(() {
        _fetching = false;
      });
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
