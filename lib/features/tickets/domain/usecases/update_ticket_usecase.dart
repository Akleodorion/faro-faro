// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

class UpdateTicketUsecase {
  const UpdateTicketUsecase({required this.repository});
  final TicketRepository repository;

  Future<Either<Failure, Ticket>> execute(
      {required int ticketId, required int userId}) async {
    return await repository.updateTicket(userId: userId, ticketId: ticketId);
  }
}
