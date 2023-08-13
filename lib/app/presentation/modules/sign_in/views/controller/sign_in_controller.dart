import 'package:flutter/foundation.dart';

import 'sign_in_state.dart';

class SignInController extends ChangeNotifier {
  SignInState _state = const SignInState();
  bool _mounted = true;

  SignInState get state => _state;
  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _state = _state.copyWith(username: text.trim().toLowerCase());
  }

  void onPasswordChanged(String text) {
    _state = _state.copyWith(password: text.replaceAll(' ', ''));
  }

  void onFecthingChanged(bool value) {
    _state = _state.copyWith(fetching: value);
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
