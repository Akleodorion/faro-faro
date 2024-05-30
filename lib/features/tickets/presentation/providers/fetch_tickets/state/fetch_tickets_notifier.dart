// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_faro/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_state.dart';

class FetchTicketsNotifier extends StateNotifier<FetchTicketsState> {
  FetchTicketsNotifier({required this.usecase}) : super(Loading());

  final FetchUserTicketsUsecase usecase;
  FetchTicketsState get initial => Loading();

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
      {required Ticket ticket, required FetchTicketsState fetchTicketsState}) {
    if (fetchTicketsState is Loaded) {
      final updateTicketsList = List<Ticket>.from(fetchTicketsState.tickets)
        ..add(ticket);
      state = fetchTicketsState.copyWith(tickets: updateTicketsList);
    }
  }

  void removeTicket(
      {required Ticket ticket, required FetchTicketsState fetchTicketsState}) {
    if (fetchTicketsState is Loaded) {
      final updateTicketsList = List<Ticket>.from(fetchTicketsState.tickets)
        ..removeWhere((element) => element.id == ticket.id);
      state = fetchTicketsState.copyWith(tickets: updateTicketsList);
    }
  }
}
