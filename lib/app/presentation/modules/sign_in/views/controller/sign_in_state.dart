import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  const SignInState({
    this.username = 'ytorox',
    this.password = 'Tueagles83.',
    this.fetching = false,
  });

  final String username, password;
  final bool fetching;

  SignInState copyWith({
    String? username,
    String? password,
    bool? fetching,
  }) =>
      SignInState(
        username: username ?? this.username,
        password: password ?? this.password,
        fetching: fetching ?? this.fetching,
      );

  @override
  List<Object?> get props => [
        username,
        password,
        fetching,
      ];
}
