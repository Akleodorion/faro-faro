import 'package:faro_clean_tdd/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_notifier.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_state.dart';
import 'package:faro_clean_tdd/injection_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
