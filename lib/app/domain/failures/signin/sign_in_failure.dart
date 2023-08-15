import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  factory SignInFailure.notFoud() = _NotFound;
  factory SignInFailure.network() = _Network;
  factory SignInFailure.unauthorized() = _Unauthorized;
  factory SignInFailure.unknown() = _Unknown;
}
