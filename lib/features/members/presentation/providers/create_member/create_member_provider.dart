// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/members/domain/entities/member.dart';
import 'package:faro_faro/features/members/domain/usecases/create_member_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/create_member/state/create_member_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'package:faro_faro/injection_container.dart';

final createMemberProvider =
    StateNotifierProvider<CreateMemberNotifier, CreateMemberState>(
  (ref) {
    final CreateMemberUsecase createMemberUsecase = sl<CreateMemberUsecase>();

    return CreateMemberNotifier(usecase: createMemberUsecase);
  },
);

final memberProvider = Provider<Member?>((ref) {
  final state = ref.watch(createMemberProvider);
  if (state is Loaded) {
    return state.member;
  }
  return null;
});
