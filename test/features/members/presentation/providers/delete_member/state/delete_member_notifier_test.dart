import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_notifier.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/delete_member/state/delete_member_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_member_notifier_test.mocks.dart';

@GenerateMocks([DeleteMemberUsecase])
void main() {
  late MockDeleteMemberUsecase mockDeleteMemberUsecase;
  late DeleteMemberNotifier sut;

  setUp(() {
    mockDeleteMemberUsecase = MockDeleteMemberUsecase();
    sut = DeleteMemberNotifier(usecase: mockDeleteMemberUsecase);
  });

  test(
    "should retrieve the initial value of the state.",
    () async {
      //act
      final result = sut.initialState;
      //assert
      expect(result, Initial());
    },
  );

  group(
    "deleteMember",
    () {
      const tMemberId = 1;
      test(
        "should emit in order [Loading, Initial] if the call is successfull ",
        () async {
          //arrange
          when(mockDeleteMemberUsecase.execute(memberId: anyNamed('memberId')))
              .thenAnswer((_) async => null);
          // assert late
          final expectedState = [Loading(), Initial()];
          expectLater(sut.stream, emitsInOrder(expectedState));

          //act
          await sut.deleteMember(memberId: tMemberId);
        },
      );

      test(
        "should emit in order [Loading, Error] if the call is unsuccessfull",
        () async {
          //arrange
          when(mockDeleteMemberUsecase.execute(memberId: anyNamed('memberId')))
              .thenAnswer(
                  (_) async => const ServerFailure(errorMessage: 'oops'));
          // assert late
          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //assert
          await sut.deleteMember(memberId: tMemberId);
        },
      );
    },
  );
}
