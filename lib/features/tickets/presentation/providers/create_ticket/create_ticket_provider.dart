import 'package:faro_clean_tdd/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createTicketProvider =
    StateNotifierProvider<CreateTicketNotifier, CreateTicketState>((ref) {
  final CreateTicketUsecase usecase = sl();

  return CreateTicketNotifier(usecase: usecase);
});
