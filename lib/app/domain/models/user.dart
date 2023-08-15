import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.username});
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
      );

  final int id;
  final String username;
  @override
  List<Object?> get props => [
        id,
        username,
      ];
}
