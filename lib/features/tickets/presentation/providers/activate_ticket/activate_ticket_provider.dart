import 'package:faro_clean_tdd/features/tickets/domain/usecases/activate_ticket_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_notifier.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activateTicketProvider =
    StateNotifierProvider<ActivateTicketNotifier, ActivateTicketState>(
  (ref) {
    final ActivateTicketUsecase usecase = sl();

    return ActivateTicketNotifier(usecase: usecase);
  },
);
