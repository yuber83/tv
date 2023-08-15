import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('ytorox') String username,
    @Default('Tueagles83.') password,
    @Default(false) bool fetching,
  }) = _SignInState;

  /*
    this.username = 'ytorox',
    this.password = 'Tueagles83.',
    this.fetching = false,
*/
}
