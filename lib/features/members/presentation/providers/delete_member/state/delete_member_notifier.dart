import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteMemberNotifier extends StateNotifier<DeleteMemberState> {
  DeleteMemberNotifier({required this.usecase}) : super(Initial());
  final DeleteMemberUsecase usecase;

  DeleteMemberState get initialState => Initial();

  Future<DeleteMemberState> deleteMember({required MemberModel member}) async {
    state = Loading();
    final result = await usecase.execute(member: member);
    if (result == null) {
      state = Initial(message: "Membre supprimé avec succès!");
    } else if (result is ServerFailure) {
      state = Error(message: result.errorMessage);
    }
    return state;
  }
}
