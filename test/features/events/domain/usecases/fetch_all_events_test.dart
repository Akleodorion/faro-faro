import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fetch_all_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late FetchAllEvents usecase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    usecase = FetchAllEvents(repository: mockEventRepository);
  });

  const tTicket1 = Ticket(
      id: 1,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 1,
      verified: false);
  const tTicket2 = Ticket(
      id: 2,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 2,
      verified: false);
  const tTickets = [tTicket1, tTicket2];
  const tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const tMember2 = Member(id: 2, userId: 2, eventId: 1);
  const tMembers = [tMember1, tMember2];
  final tEvent1 = Event(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime.now(),
    address: const Address(
        latitude: 4.7,
        longitude: -3.9,
        geocodeUrl: "geocodeUrl",
        country: "Côte d'Ivoire",
        countryCode: "CI",
        locality: "Abidjan",
        plusCode: "9359+HXR",
        road: "Route d'Abatta",
        sublocality: "Cocody"),
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.gratuit,
    members: tMembers,
    tickets: const [],
    activated: false,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    goldTicketPrice: 10000,
    maxGoldTicket: 25,
    goldTicketDescription: "vip ticket simple description",
    platinumTicketPrice: 15000,
    maxPlatinumTicket: 10,
    platinumTicketDescription: "vvip ticket simple description",
  );

  final tEvent2 = Event(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime.now(),
    address: const Address(
        latitude: 4.7,
        longitude: -3.9,
        geocodeUrl: "geocodeUrl",
        country: "Côte d'Ivoire",
        countryCode: "CI",
        locality: "Abidjan",
        plusCode: "9359+HXR",
        road: "Route d'Abatta",
        sublocality: "Cocody"),
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.gratuit,
    members: tMembers,
    tickets: tTickets,
    activated: false,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    goldTicketPrice: 10000,
    maxGoldTicket: 25,
    goldTicketDescription: "vip ticket simple description",
    platinumTicketPrice: 15000,
    maxPlatinumTicket: 10,
    platinumTicketDescription: "vvip ticket simple description",
  );

  final tEvents = [tEvent1, tEvent2];

  group(
    "execute",
    () {
      test(
        "should return the right list of Events",
        () async {
          //arrange
          when(mockEventRepository.fetchAllEvents())
              .thenAnswer((realInvocation) async => Right(tEvents));
          //act
          final result = await usecase.execute();
          //assert
          expect(result, Right(tEvents));
          verify(mockEventRepository.fetchAllEvents()).called(1);
        },
      );

      test(
        "should return the right failure message is the request is unsuccesfful",
        () async {
          when(mockEventRepository.fetchAllEvents()).thenAnswer(
              (realInvocation) async => const Left(
                  ServerFailure(errorMessage: "An error has occured")));
          //act
          final result = await usecase.execute();
          //assert
          expect(result,
              const Left(ServerFailure(errorMessage: "An error has occured")));
          verify(mockEventRepository.fetchAllEvents()).called(1);
        },
      );
    },
  );
}
