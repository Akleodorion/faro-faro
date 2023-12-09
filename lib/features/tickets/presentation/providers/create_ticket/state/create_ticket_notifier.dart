import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTicketNotifier extends StateNotifier<CreateTicketState> {
  CreateTicketNotifier({required this.usecase}) : super(Initial());

  final CreateTicketUsecase usecase;
  CreateTicketState get initial => Initial();

  Future<CreateTicketState> createTicket({required TicketModel ticket}) async {
    state = Loading();
    final result = await usecase.execute(ticket: ticket);
    result.fold(
        (failure) => failure is ServerFailure
            ? state = Error(message: failure.errorMessage)
            : null,
        (ticket) => state = Loaded(
            ticket: ticket, message: "Le ticket a été crée avec succès!"));
    return state;
  }
}
