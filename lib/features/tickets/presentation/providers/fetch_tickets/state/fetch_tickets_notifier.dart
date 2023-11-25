import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/tickets/domain/usecases/fetch_user_tickets_usecase.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/state/fetch_tickets_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchTicketsNotifier extends StateNotifier<FetchTicketsState> {
  FetchTicketsNotifier({required this.usecase}) : super(Initial());

  final FetchUserTicketsUsecase usecase;
  FetchTicketsState get initial => Initial();

  Future<FetchTicketsState> fetchUserTickets({required int userId}) async {
    state = Loading();
    final result = await usecase.execute(userId: userId);
    result.fold(
        (failure) => failure is ServerFailure
            ? state = Error(message: failure.errorMessage)
            : null,
        (tickets) => state = Loaded(tickets: tickets));
    return state;
  }
}
