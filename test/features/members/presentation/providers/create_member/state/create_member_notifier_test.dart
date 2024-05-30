// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/members/domain/usecases/create_member_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/create_member/state/create_member_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'create_member_notifier_test.mocks.dart';

@GenerateMocks([CreateMemberUsecase])
void main() {
  late MockCreateMemberUsecase mockCreateMemberUsecase;
  late CreateMemberNotifier sut;

  setUp(() {
    mockCreateMemberUsecase = MockCreateMemberUsecase();
    sut = CreateMemberNotifier(usecase: mockCreateMemberUsecase);
  });

  test(
    "should get the initial state of the notifier",
    () async {
      //act
      final result = sut.initialState;
      //assert
      expect(result, Initial());
    },
  );
  const tSuccessMessage = "Réussi";
  const tUserId = 1;
  const tEventId = 1;
  const tUsername = "test";
  const tMember = MemberModel(
      id: 1, userId: tUserId, eventId: tEventId, username: tUsername);

  group(
    "createMember",
    () {
      test(
        "should emit in order [Loading,Loaded] if the call has been successfull",
        () async {
          //arrange
          when(mockCreateMemberUsecase.execute(member: anyNamed('member')))
              .thenAnswer((_) async => const Right(tMember));
          //assert later
          final expectedState = [
            Loading(),
            Loaded(member: tMember, message: tSuccessMessage)
          ];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //act
          await sut.createMember(member: tMember);
          verify(mockCreateMemberUsecase.execute(member: tMember));
        },
      );

      test(
        "should emit in order [loading,error] if the call is unsuccessfull",
        () async {
          //arrange
          when(mockCreateMemberUsecase.execute(member: anyNamed('member')))
              .thenAnswer(
            (realInvocation) async => const Left(
              ServerFailure(errorMessage: 'oops'),
            ),
          );
          //assert later

          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //act
          sut.createMember(member: tMember);
          verify(mockCreateMemberUsecase.execute(member: tMember));
        },
      );
    },
  );
}
