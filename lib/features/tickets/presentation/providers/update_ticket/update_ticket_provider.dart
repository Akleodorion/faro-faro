import 'package:faro_clean_tdd/features/tickets/domain/usecases/update_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateTicketProvider =
    StateNotifierProvider<UpdateTicketNotifier, UpdateTicketState>((ref) {
  final UpdateTicketUsecase usecase = sl();

  return UpdateTicketNotifier(usecase: usecase);
});
