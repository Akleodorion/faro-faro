import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/tickets/domain/repositories/ticket_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/ticket.dart';

class FetchUserTicketsUsecase {
  const FetchUserTicketsUsecase({required this.repository});
  final TicketRepository repository;

  Future<Either<Failure, List<Ticket>>> execute({required int userId}) async {
    return await repository.fetchUserTickets(userId: userId);
  }
}
