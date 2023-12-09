import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/fetch_members_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/fetch_members/state/fetch_members_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void addMember(
      {required Member member, required FetchMembersState fetchMembersState}) {
    if (fetchMembersState is Loaded) {
      final updateMembersList = List<Member>.from(fetchMembersState.members)
        ..add(member);

      state = fetchMembersState.copyWith(members: updateMembersList);
    }
  }

  void removeMember(
      {required Member member, required FetchMembersState fetchMembersState}) {
    if (fetchMembersState is Loaded) {
      final updateMembersList = List<Member>.from(fetchMembersState.members)
        ..removeWhere((element) => element.id == member.id);
      state = fetchMembersState.copyWith(members: updateMembersList);
    }
  }
}
