import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';
import 'package:faro_clean_tdd/features/members/domain/usecases/delete_member_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_member_usecase_test.mocks.dart';

@GenerateMocks([MemberRepository])
void main() {
  late MockMemberRepository mockMemberRepository;
  late DeleteMemberUsecase sut;
  setUp(() {
    mockMemberRepository = MockMemberRepository();
    sut = DeleteMemberUsecase(repository: mockMemberRepository);
  });

  group(
    "Execute",
    () {
      const tMemberId = 1;
      test(
        "should return void if call is successfull",
        () async {
          //arrange
          when(mockMemberRepository.deleteMember(
                  memberId: anyNamed('memberId')))
              .thenAnswer((_) async => null);
          //act
          final result = await sut.execute(memberId: tMemberId);
          //assert
          expect(result, null);
        },
      );

      test(
        "should return a Server Failure is the test is unsuccessful",
        () async {
          //arrange
          when(mockMemberRepository.deleteMember(
                  memberId: anyNamed('memberId')))
              .thenAnswer(
                  (_) async => const ServerFailure(errorMessage: 'oops'));
          //act
          //assert
        },
      );
    },
  );
}
