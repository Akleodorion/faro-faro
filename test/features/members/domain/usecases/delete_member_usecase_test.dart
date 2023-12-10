import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
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
      const tMember =
          MemberModel(id: 1, userId: 1, eventId: 1, username: "test");
      test(
        "should return void if call is successfull",
        () async {
          //arrange
          when(mockMemberRepository.deleteMember(member: anyNamed('member')))
              .thenAnswer((_) async => null);
          //act
          final result = await sut.execute(member: tMember);
          //assert
          expect(result, null);
        },
      );

      test(
        "should return a Server Failure is the test is unsuccessful",
        () async {
          //arrange
          when(mockMemberRepository.deleteMember(member: anyNamed('member')))
              .thenAnswer(
                  (_) async => const ServerFailure(errorMessage: 'oops'));
          //act
          final result = await sut.execute(member: tMember);
          //assert
          expect(result, const ServerFailure(errorMessage: 'oops'));
        },
      );
    },
  );
}
