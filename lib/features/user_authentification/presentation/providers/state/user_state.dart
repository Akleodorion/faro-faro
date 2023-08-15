import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Initial extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {}

class Error extends UserState {
  final String message;

  Error({required this.message});
}
