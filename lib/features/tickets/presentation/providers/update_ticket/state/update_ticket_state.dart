import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';

abstract class UpdateTicketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends UpdateTicketState {}

class Loading extends UpdateTicketState {}

class Loaded extends UpdateTicketState {
  final Ticket ticket;

  Loaded({required this.ticket});
}

class Error extends UpdateTicketState {
  final String message;

  Error({required this.message});
}
