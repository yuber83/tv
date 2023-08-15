import '../../../../../domain/either.dart';
import '../../../../../domain/failures/signin/sign_in_failure.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../../domain/repositories/authentication_repository.dart';
import '../../../../global/state_notifier.dart';
import 'state/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state, {required this.authenticationRepository});
  final AuthenticationRepository authenticationRepository;

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

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(fetching: true);
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
    );

    result.when(
        left: (_) => state = state.copyWith(
              fetching: false,
            ),
        right: (_) => null);

    return result;
  }
}
