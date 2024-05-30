// Package imports:
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.jwtToken,
    required this.id,
  });

  final String username;
  final String email;
  final String phoneNumber;
  final String jwtToken;
  final int id;

  @override
  List<Object?> get props => [
        username,
        email,
        phoneNumber,
        jwtToken,
        id,
      ];
}
