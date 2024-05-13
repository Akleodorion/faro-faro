import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';

abstract class LoggedInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends LoggedInState {}

class Loaded extends LoggedInState {
  final User user;
  final String message;

  Loaded({
    required this.user,
    required this.message,
  });
}

class Unloaded extends LoggedInState {
  final Map<String, dynamic> userInfo;

  Unloaded({required this.userInfo});
}
