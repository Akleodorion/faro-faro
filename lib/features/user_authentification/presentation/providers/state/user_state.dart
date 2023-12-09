import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends UserState {
  final Map<String, dynamic> userInfo;

  Initial({required this.userInfo});
}

class Loading extends UserState {}

class Loaded extends UserState {
  final User user;
  final String message;

  Loaded({
    required this.user,
    required this.message,
  });
}

class Error extends UserState {
  final String message;

  Error({required this.message});
}
