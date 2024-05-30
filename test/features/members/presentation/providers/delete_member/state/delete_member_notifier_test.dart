// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/delete_member/state/delete_member_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/delete_member/state/delete_member_state.dart';
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
      const tMember = MemberModel(
        id: 1,
        userId: 1,
        eventId: 1,
        username: "test",
      );
      test(
        "should emit in order [Loading, Initial] if the call is successfull ",
        () async {
          //arrange
          when(mockDeleteMemberUsecase.execute(member: anyNamed('member')))
              .thenAnswer((_) async => null);
          // assert late
          final expectedState = [Loading(), Initial()];
          expectLater(sut.stream, emitsInOrder(expectedState));

          //act
          await sut.deleteMember(member: tMember);
        },
      );

      test(
        "should emit in order [Loading, Error] if the call is unsuccessfull",
        () async {
          //arrange
          when(mockDeleteMemberUsecase.execute(member: anyNamed('member')))
              .thenAnswer(
                  (_) async => const ServerFailure(errorMessage: 'oops'));
          // assert late
          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //assert
          await sut.deleteMember(member: tMember);
        },
      );
    },
  );
}
