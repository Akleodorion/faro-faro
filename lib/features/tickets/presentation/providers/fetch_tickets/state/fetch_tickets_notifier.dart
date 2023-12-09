import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchTicketsNotifier extends StateNotifier<FetchTicketsState> {
  FetchTicketsNotifier({required this.usecase}) : super(Loading());

  final FetchUserTicketsUsecase usecase;
  FetchTicketsState get initial => Loading();
  FetchTicketsState get currentState => state;

  Future<FetchTicketsState> fetchUserTickets({required int userId}) async {
    final result = await usecase.execute(userId: userId);
    result.fold(
        (failure) => failure is ServerFailure
            ? state = Error(message: failure.errorMessage)
            : null,
        (tickets) => state = Loaded(
            tickets: tickets,
            message: "Les tickets ont étés récupérés avec succès!"));
    return state;
  }

  void addTicket(
      {required Ticket ticket, required FetchTicketsState providedState}) {
    if (providedState is Loaded) {
      final updatedTicketList = List<Ticket>.from(providedState.tickets)
        ..add(ticket);
      state = providedState.copyWith(tickets: updatedTicketList);
    }
  }

  void removeTicket(
      {required Ticket ticket, required FetchTicketsState providedState}) {
    if (providedState is Loaded) {
      final updatedTicketList = List<Ticket>.from(providedState.tickets)
        ..removeWhere((element) => element.id == ticket.id);
      state = providedState.copyWith(tickets: updatedTicketList);
    }
  }
}
