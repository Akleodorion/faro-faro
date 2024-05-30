// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/members/domain/entities/member.dart';
import 'package:faro_faro/features/members/domain/usecases/fetch_members_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/fetch_members/state/fetch_members_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/fetch_members/state/fetch_members_state.dart';
import 'package:faro_faro/injection_container.dart';

final fetchMembersProvider =
    StateNotifierProvider<FetchMemberNotifier, FetchMembersState>((ref) {
  final FetchMembersUsecase usecase = sl<FetchMembersUsecase>();

  return FetchMemberNotifier(usecase: usecase);
});

final membersProvider = Provider<List<Member>>((ref) {
  List<Member> members = [];
  final state = ref.watch(fetchMembersProvider);
  if (state is Loaded) {
    members = state.members;
  }
  return members;
});
