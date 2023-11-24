import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  // Creates a ticket.
  Future<Either<Failure, Ticket>>? createTicket({required Ticket ticket});

  // Delete a ticket

  // Updates a ticket.
  Future<Either<Failure, Ticket>>? updateTicket(
      {required int userId, required Ticket updatedTicket});

  // Fetch all tickets from current user.
  Future<Either<Failure, List<Ticket>>>? fetchUserTickets(
      {required int userId});
}
