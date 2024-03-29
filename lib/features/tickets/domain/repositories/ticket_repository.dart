import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  // Crée un ticket à l'achat.
  Future<Either<Failure, Ticket>> createTicket({required TicketModel ticket});

  // Transfert un ticket.
  Future<Either<Failure, Ticket>> updateTicket(
      {required int userId, required int ticketId});

  // Récupère tout les tickets d'un utilisateur depuis l'API.
  Future<Either<Failure, List<Ticket>>> fetchUserTickets({required int userId});

  // Vérifie la validité et active un ticket.

  Future<Either<Failure, String>> activateTicket(
      {required int userId, required TicketModel ticket});
}
