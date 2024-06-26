// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/domain/entities/member.dart';
import 'package:faro_faro/features/members/domain/usecases/fetch_members_usecase.dart';
import 'package:faro_faro/features/members/presentation/providers/fetch_members/state/fetch_members_notifier.dart';
import 'package:faro_faro/features/members/presentation/providers/fetch_members/state/fetch_members_state.dart';
import 'fetch_members_notifier_test.mocks.dart';

@GenerateMocks([FetchMembersUsecase])
void main() {
  late MockFetchMembersUsecase mockFetchMembersUsecase;
  late FetchMemberNotifier sut;

  setUp(() {
    mockFetchMembersUsecase = MockFetchMembersUsecase();
    sut = FetchMemberNotifier(usecase: mockFetchMembersUsecase);
  });

  test(
    "should provide the initialState of the notifier.",
    () async {
      //act
      final result = sut.initialState;
      //assert
      expect(result, Initial());
    },
  );

  group(
    "fetchMember",
    () {
      const tSuccessMessage = "Réussi";
      const tUserId = 1;
      const tEventId1 = 1;
      const tEventId2 = 2;
      const tUsername1 = "test1";
      const tUsername2 = "test2";
      const tMember1 = Member(
          id: 1, userId: tUserId, eventId: tEventId1, username: tUsername1);
      const tMember2 = Member(
          id: 2, userId: tUserId, eventId: tEventId2, username: tUsername2);
      const tMembers = [tMember1, tMember2];
      test(
        "should emit in order [Loading, Loaded] if the call is successfull",
        () async {
          //arrange
          when(mockFetchMembersUsecase.execute(userId: tUserId))
              .thenAnswer((_) async => const Right(tMembers));
          //assert later
          final expectedState = [
            Loading(),
            Loaded(members: tMembers, message: tSuccessMessage)
          ];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //assert
          await sut.fetchMember(userId: tUserId);
        },
      );

      test(
        "should emit in order [Loading, Error] if the call is successfull",
        () async {
          //arrange
          when(mockFetchMembersUsecase.execute(userId: tUserId)).thenAnswer(
              (_) async => const Left(ServerFailure(errorMessage: 'oops')));
          //assert later
          final expectedState = [Loading(), Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expectedState));
          //assert
          await sut.fetchMember(userId: tUserId);
        },
      );
    },
  );
}
