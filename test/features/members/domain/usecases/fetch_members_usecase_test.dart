// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/members/domain/repositories/member_repository.dart';
import 'package:faro_faro/features/members/domain/usecases/fetch_members_usecase.dart';
import 'fetch_members_usecase_test.mocks.dart';

@GenerateMocks([MemberRepository])
void main() {
  late MockMemberRepository mockMemberRepository;
  late FetchMembersUsecase sut;

  setUp(() {
    mockMemberRepository = MockMemberRepository();
    sut = FetchMembersUsecase(repository: mockMemberRepository);
  });

  group(
    "execute",
    () {
      const tUserId = 1;
      const tUsername = "test";
      const tMember1 =
          MemberModel(id: 1, userId: tUserId, eventId: 1, username: tUsername);
      const tMember2 =
          MemberModel(id: 2, userId: tUserId, eventId: 2, username: tUsername);

      const tMembers = [tMember1, tMember2];
      test(
        "should return a valid List of Members if the call is successfull",
        () async {
          //arrange
          when(mockMemberRepository.fetchMembers(userId: anyNamed('userId')))
              .thenAnswer((_) async => const Right(tMembers));
          //act
          final result = await sut.execute(userId: tUserId);
          //assert
          expect(result, const Right(tMembers));
          verify(mockMemberRepository.fetchMembers(userId: tUserId)).called(1);
        },
      );

      test(
        "should return a Server Failure if the call is unsuccessfull",
        () async {
          //arrange
          when(mockMemberRepository.fetchMembers(userId: anyNamed('userId')))
              .thenAnswer(
                  (_) async => const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(userId: tUserId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    },
  );
}
