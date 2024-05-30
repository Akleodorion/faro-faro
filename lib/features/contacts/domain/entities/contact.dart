// Package imports:
import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  const Contact({
    required this.userId,
    required this.phoneNumber,
    required this.username,
  });

  final int userId;
  final String phoneNumber;
  final String username;

  @override
  List<Object?> get props => [
        userId,
        phoneNumber,
        username,
      ];
}
