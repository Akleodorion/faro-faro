// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/domain/usecases/update_ticket_usecase.dart';
import 'package:faro_faro/features/tickets/presentation/providers/update_ticket/state/update_ticket_state.dart';

class UpdateTicketNotifier extends StateNotifier<UpdateTicketState> {
  UpdateTicketNotifier({required this.usecase}) : super(Initial());
  final UpdateTicketUsecase usecase;
  UpdateTicketState get initial => Initial();

  Future<UpdateTicketState> updateTicket({
    required int ticketId,
    required int userId,
  }) async {
    state = Loading();
    final result = await usecase.execute(ticketId: ticketId, userId: userId);
    result.fold(
        (failure) => failure is ServerFailure
            ? state = Error(message: failure.errorMessage)
            : null,
        (ticket) => state = Loaded(
            ticket: ticket, message: "Le ticket a été transféré avec succès!"));
    return state;
  }
}
