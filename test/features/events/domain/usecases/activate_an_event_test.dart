import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/activate_an_event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'activate_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late ActivateAnEvent usecase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    usecase = ActivateAnEvent(repository: mockEventRepository);
  });

  group(
    "execute",
    () {
      const tMember1 = Member(id: 1, userId: 1, eventId: 1);
      const tMember2 = Member(id: 2, userId: 2, eventId: 1);
      const tMembers = [tMember1, tMember2];
      const int tEventId = 1;
      const int tUserId = 1;
      Event tEvent = Event(
          name: "name",
          eventId: tEventId,
          description: "description",
          date: DateTime.now(),
          address: const Address(
              latitude: 10.5264,
              longitude: 20.4585,
              addressName: "addressName",
              geocodeUrl: "geocodeUrl"),
          category: Category.concert,
          imageUrl: "imageUrl",
          userId: tUserId,
          modelEco: ModelEco.gratuit,
          members: tMembers,
          activated: false,
          standardTicketPrice: 5000,
          maxStandardTicket: 10,
          standardTicketDescription: "standardTicketDescription",
          vipTicketPrice: 10000,
          maxVipTicket: 5,
          vipTicketDescription: "vipTicketDescription",
          vvipTicketPrice: 15000,
          maxVvipTicket: 5,
          vvipTicketDescription: "vvipTicketDescription");
      test(
        "should return a valid Event when call is successful",
        () async {
          when(mockEventRepository.activateAnEvent(
                  event: anyNamed('event'), userId: anyNamed('userId')))
              .thenAnswer((_) async => Right(tEvent));
          //act
          final result = await usecase.execute(event: tEvent, userId: tUserId);
          //assert
          expect(result, Right(tEvent));
          verify(mockEventRepository.activateAnEvent(
              event: tEvent, userId: tUserId));
        },
      );

      test(
        "should return a failure with an error message",
        () async {
          //arrange
          when(mockEventRepository.activateAnEvent(
                  event: anyNamed('event'), userId: anyNamed('userId')))
              .thenAnswer((_) async =>
                  const Left(ServerFailure(errorMessage: 'oops ')));
          //act
          final result = await usecase.execute(event: tEvent, userId: tUserId);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops ')));
          verify(mockEventRepository.activateAnEvent(
                  event: tEvent, userId: tUserId))
              .called(1);
        },
      );
    },
  );
}
