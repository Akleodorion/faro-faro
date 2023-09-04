import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';

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

  Loaded({required this.user});
}

class Error extends UserState {
  final String message;

  Error({required this.message});
}
