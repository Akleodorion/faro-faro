// Package imports:
import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends PasswordState {}

class Loading extends PasswordState {}

class Error extends PasswordState {
  final String message;

  Error({required this.message});
}
