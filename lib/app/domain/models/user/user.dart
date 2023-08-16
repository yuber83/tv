import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,

    ///
    @JsonKey(
      name: 'avatar',
      fromJson: avatarPathFromJson,
    )
    String? avatarPath,
  }) = _User;
  const User._();

  getFortmatted() {
    return '$username $id';
  }

  factory User.fromJson(JsonTypedef json) => _$UserFromJson(json);
}

String? avatarPathFromJson(JsonTypedef json) =>
    json['tmdb']?['avatar_path'] as String?;
