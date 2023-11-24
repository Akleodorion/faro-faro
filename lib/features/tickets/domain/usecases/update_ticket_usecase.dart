import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

class UpdateTicketUsecase {
  const UpdateTicketUsecase({required this.repository});
  final TicketRepository repository;

  Future<Either<Failure, Ticket>?> execute(
      {required Ticket updatedTicket, required int userId}) async {
    return await repository.updateTicket(
        userId: userId, updatedTicket: updatedTicket);
  }
}
