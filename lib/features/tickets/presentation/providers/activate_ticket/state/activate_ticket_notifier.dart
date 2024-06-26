// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/usecases/activate_ticket_usecase.dart';
import 'package:faro_faro/features/tickets/presentation/providers/activate_ticket/state/activate_ticket_state.dart';

class ActivateTicketNotifier extends StateNotifier<ActivateTicketState> {
  ActivateTicketNotifier({required this.usecase}) : super(Initial());

  final ActivateTicketUsecase usecase;

  ActivateTicketState get initialState => Initial();

  Future<ActivateTicketState> activateTicket(
      {required int userId, required TicketModel ticket}) async {
    state = Loading();
    final result = await usecase.execute(userId: userId, ticket: ticket);
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (success) {
      state = Loaded(message: success);
    });
    return state;
  }
}
