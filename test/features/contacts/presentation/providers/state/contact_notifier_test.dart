import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/contacts/domain/usecases/fetch_contact_usecase.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_notifier.dart';
import 'package:faro_clean_tdd/features/contacts/presentation/providers/state/contact_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_notifier_test.mocks.dart';

@GenerateMocks([FetchContactUsecase])
void main() {
  late MockFetchContactUsecase mockFetchContactUsecase;
  late ContactNotifier sut;

  setUp(() {
    mockFetchContactUsecase = MockFetchContactUsecase();
    sut = ContactNotifier(usecase: mockFetchContactUsecase);
  });

  test(
    "should return the initial value",
    () async {
      //act
      final result = sut.initialState;
      //assert
      expect(result, Loading());
    },
  );

  group(
    "fetchContact",
    () {
      const Contact tContact1 =
          Contact(userId: 1, phoneNumber: "+2254542625474", username: "user 1");
      const Contact tContact2 =
          Contact(userId: 2, phoneNumber: "+2251025452674", username: "user 2");
      const tContacts = [tContact1, tContact2];
      const tNumbersList = ["+2254546585", "+22552525252"];
      const tSuccessMessage = "Contacts récupérés avec succès";
      test(
        "should call emit [Loaded] if the call is successfull",
        () async {
          //arrange
          when(mockFetchContactUsecase.execute(numbers: anyNamed("numbers")))
              .thenAnswer((realInvocation) async => const Right(tContacts));
          //assert later
          final expected = [
            Loaded(contacts: tContacts, message: tSuccessMessage)
          ];
          expectLater(sut.stream, emitsInOrder(expected));
          // act
          await sut.fetchContact(numbers: tNumbersList);
          verify(mockFetchContactUsecase.execute(numbers: tNumbersList))
              .called(1);
        },
      );

      test(
        "should call emit [Error] if the call is not successfull",
        () async {
          //arrange
          when(mockFetchContactUsecase.execute(numbers: anyNamed("numbers")))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //assert later
          final expected = [Error(message: 'oops')];
          expectLater(sut.stream, emitsInOrder(expected));
          // act
          await sut.fetchContact(numbers: tNumbersList);
          verify(mockFetchContactUsecase.execute(numbers: tNumbersList))
              .called(1);
        },
      );
    },
  );
}
