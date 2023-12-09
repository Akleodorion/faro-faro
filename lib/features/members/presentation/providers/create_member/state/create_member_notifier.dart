import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/create_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateMemberNotifier extends StateNotifier<CreateMemberState> {
  CreateMemberNotifier({required this.usecase}) : super(Initial());
  final CreateMemberUsecase usecase;

  CreateMemberState get initialState => Initial();

  Future<CreateMemberState> createMember(
      {required int eventId, required int userId}) async {
    state = Loading();
    final result = await usecase.execute(eventId: eventId, userId: userId);
    result!.fold((error) {
      if (error is ServerFailure) {
        state = Error(message: error.errorMessage);
      }
    }, (member) {
      state = Loaded(member: member);
    });
    return state;
  }
}
