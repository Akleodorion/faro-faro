// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/delete_member/state/delete_member_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/delete_member/state/delete_member_state.dart';
import 'package:faro_faro/injection_container.dart';

final deleteMemberProvider =
    StateNotifierProvider<DeleteMemberNotifier, DeleteMemberState>((ref) {
  final DeleteMemberUsecase usecase = sl<DeleteMemberUsecase>();

  return DeleteMemberNotifier(usecase: usecase);
});

final deleteMemberMessageProvider = Provider<String?>((ref) {
  final state = ref.watch(deleteMemberProvider);
  if (state is Error) {
    return state.message;
  }
  return null;
});
