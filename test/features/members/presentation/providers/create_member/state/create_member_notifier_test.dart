import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/create_member_usecase.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_notifier.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
  const tUserId = 1;
  const tEventId = 1;
  const tMember = Member(id: 1, userId: tUserId, eventId: tEventId);

  group(
    "createMember",
    () {
      test(
        "should emit in order [Loading,Loaded] if the call has been successfull",
        () async {
          //arrange
          when(mockCreateMemberUsecase.execute(
                  eventId: anyNamed('eventId'), userId: anyNamed('userId')))
              .thenAnswer((_) async => const Right(tMember));
          //assert later
          final expectedState = [Loading(), Loaded(member: tMember)];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //act
          await sut.createMember(eventId: tEventId, userId: tUserId);
          verify(mockCreateMemberUsecase.execute(
              eventId: tEventId, userId: tUserId));
        },
      );

      test(
        "should emit in order [loading,error] if the call is unsuccessfull",
        () async {
          //arrange
          when(mockCreateMemberUsecase.execute(
                  eventId: anyNamed('eventId'), userId: anyNamed('userId')))
              .thenAnswer(
            (realInvocation) async => const Left(
              ServerFailure(errorMessage: 'oops'),
            ),
          );
          //assert later

          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //act
          sut.createMember(eventId: tEventId, userId: tUserId);
          verify(mockCreateMemberUsecase.execute(
              eventId: tEventId, userId: tUserId));
        },
      );
    },
  );
}
