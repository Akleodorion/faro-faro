import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  // Creates a ticket.
  Future<Either<Failure, Ticket>> createTicket({required TicketModel ticket});

  // Updates a ticket.
  Future<Either<Failure, Ticket>> updateTicket(
      {required int userId, required int ticketId});

  // Fetch all tickets from current user.
  Future<Either<Failure, List<Ticket>>> fetchUserTickets({required int userId});
}
