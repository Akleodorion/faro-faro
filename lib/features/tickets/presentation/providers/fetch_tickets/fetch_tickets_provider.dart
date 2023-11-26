import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchTicketsProvider =
    StateNotifierProvider<FetchTicketsNotifier, FetchTicketsState>((ref) {
  final FetchUserTicketsUsecase usecase = sl();

  return FetchTicketsNotifier(usecase: usecase);
});

final userTicketsProvider = Provider<List<Ticket>>((ref) {
  final state = ref.watch(fetchTicketsProvider);
  return state is Loaded ? state.tickets : [];
});
