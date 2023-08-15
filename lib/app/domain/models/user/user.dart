import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    this.avatarPath,
  });

  ///sirve para mapear resultados de la api y guardarlo con nombre definidos en esta clase
  // @JsonKey(name: 'userId')
  final int id;
  final String username;
  @JsonKey(name: 'avatar_path', fromJson: avatarPathFromJson)
  final String? avatarPath;

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

String? avatarPathFromJson(Map<String, dynamic> json) =>
    json['tmdb']?['avatar_path'];
