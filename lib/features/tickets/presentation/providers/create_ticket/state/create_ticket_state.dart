// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';

abstract class CreateTicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends CreateTicketState {}

class Loading extends CreateTicketState {}

class Loaded extends CreateTicketState {
  final Ticket ticket;
  final String message;

  Loaded({
    required this.ticket,
    required this.message,
  });
}

class Error extends CreateTicketState {
  final String message;

  Error({required this.message});
}
