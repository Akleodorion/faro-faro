import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.username, required this.email, required this.phoneNumber});

  final String username;
  final String email;
  final String phoneNumber;

  @override
  List<Object?> get props => [username, email, phoneNumber];
}
