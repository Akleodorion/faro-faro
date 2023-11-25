import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

class CreateTicketUsecase {
  const CreateTicketUsecase({required this.repository});
  final TicketRepository repository;

  Future<Either<Failure, Ticket>> execute({required TicketModel ticket}) async {
    return await repository.createTicket(ticket: ticket);
  }
}
