import '../../../../global/state_notifier.dart';
import 'sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state);

  void onUsernameChanged(String text) {
    onlyUpdate(
      state.copyWith(username: text.trim().toLowerCase()),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(password: text.replaceAll(' ', '')),
    );
  }

  void onFecthingChanged(bool value) {
    state = state.copyWith(fetching: value);
  }
}
