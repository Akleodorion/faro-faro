// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';

abstract class UpdateTicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends UpdateTicketState {}

class Loading extends UpdateTicketState {}

class Loaded extends UpdateTicketState {
  final Ticket ticket;
  final String message;

  Loaded({
    required this.ticket,
    required this.message,
  });
}

class Error extends UpdateTicketState {
  final String message;

  Error({required this.message});
}
