// Package imports:
import 'package:equatable/equatable.dart';

abstract class ActivateTicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends ActivateTicketState {}

class Loading extends ActivateTicketState {}

class Loaded extends ActivateTicketState {
  final String message;

  Loaded({required this.message});
}

class Error extends ActivateTicketState {
  final String message;

  Error({required this.message});
}
