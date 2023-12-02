import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/contacts/domain/repositories/contact_repository.dart';
import 'package:faro_clean_tdd/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_contacts_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late MockContactRepository mockContactRepository;
  late FetchContactUsecase sut;

  setUp(() {
    mockContactRepository = MockContactRepository();
    sut = FetchContactUsecase(repository: mockContactRepository);
  });

  group(
    "execute",
    () {
      const Contact tContact1 =
          Contact(userId: 1, phoneNumber: "+2254542625474", username: "user 1");
      const Contact tContact2 =
          Contact(userId: 2, phoneNumber: "+2251025452674", username: "user 2");
      const tContacts = [tContact1, tContact2];
      test(
        "should return a valid list of contact if the call is a success",
        () async {
          //arrange
          when(mockContactRepository.fectchConctacts())
              .thenAnswer((realInvocation) async => const Right(tContacts));
          //act
          final result = await sut.execute();
          //assert
          expect(result, const Right(tContacts));
          verify(mockContactRepository.fectchConctacts());
        },
      );

      test(
        "should return a ServerFailure if the call is not a success",
        () async {
          //arrange
          when(mockContactRepository.fectchConctacts()).thenAnswer(
              (realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute();
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
          verify(mockContactRepository.fectchConctacts());
        },
      );
    },
  );
}
