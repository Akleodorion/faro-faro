// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/domain/usecases/fetch_members_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/fetch_members/state/fetch_members_state.dart';

class FetchMemberNotifier extends StateNotifier<FetchMembersState> {
  FetchMemberNotifier({required this.usecase}) : super(Initial());
  final FetchMembersUsecase usecase;

  FetchMembersState get initialState => Initial();

  Future<FetchMembersState?> fetchMember({required int userId}) async {
    state = Loading();
    final result = await usecase.execute(userId: userId);
    result.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (members) {
      state = Loaded(
          members: members,
          message: "Les membres ont étés récupérés avec succès!");
    });
    return state;
  }
}
