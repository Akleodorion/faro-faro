import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/create_member_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_member_usecase_test.mocks.dart';

@GenerateMocks([MemberRepository])
void main() {
  late MockMemberRepository mockMemberRepository;
  late CreateMemberUsecase sut;
  setUp(() {
    mockMemberRepository = MockMemberRepository();
    sut = CreateMemberUsecase(repository: mockMemberRepository);
  });

  group(
    "Execute",
    () {
      const tUserId = 1;
      const tEventId = 1;
      const tMember = Member(id: 1, userId: tUserId, eventIid: tEventId);
      test(
        "should return a valid Member if call is successfull",
        () async {
          //arrange
          when(mockMemberRepository.createMember(
                  eventId: anyNamed('eventId'), userId: anyNamed('userId')))
              .thenAnswer((_) async => const Right(tMember));
          //act
          final result = await sut.execute(eventId: tEventId, userId: tUserId);
          //assert
          expect(result, const Right(tMember));
          verify(mockMemberRepository.createMember(
                  eventId: tEventId, userId: tUserId))
              .called(1);
        },
      );

      test(
        "should return a Server Failure is the test is unsuccessful",
        () async {
          //arrange
          when(mockMemberRepository.createMember(
                  eventId: anyNamed('eventId'), userId: anyNamed('userId')))
              .thenAnswer(
                  (_) async => const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(eventId: tEventId, userId: tUserId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
          verify(mockMemberRepository.createMember(
                  eventId: tEventId, userId: tUserId))
              .called(1);
        },
      );
    },
  );
}
