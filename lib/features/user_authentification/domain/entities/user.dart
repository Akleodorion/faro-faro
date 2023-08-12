import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.username,
      required this.email,
      required this.phoneNumber,
      required this.password});

  final String username;
  final String email;
  final String phoneNumber;
  final String password;

  @override
  List<Object?> get props => [username, email, phoneNumber, password];
}
