// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/repositories/ticket_repository.dart';

class ActivateTicketUsecase {
  final TicketRepository repository;

  ActivateTicketUsecase({required this.repository});

  Future<Either<Failure, String>> execute(
      {required int userId, required TicketModel ticket}) async {
    return repository.activateTicket(userId: userId, ticket: ticket);
  }
}
