import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _username = 'ytorox', _password = 'Tueagles83.';
  bool _fetching = false, _mounted = true;

  String get username => _username;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _username = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
  }

  void onFecthingChanged(bool value) {
    _fetching = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    print('dispose');
    super.dispose();
  }
}
