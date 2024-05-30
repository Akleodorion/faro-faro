// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';
import 'package:faro_faro/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/tickets/data/models/ticket_model.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'fetch_all_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late FetchAllEvents usecase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    usecase = FetchAllEvents(repository: mockEventRepository);
  });

  const tTicket1 = TicketModel(
      id: 1,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 1,
      qrCodeUrl: "qrCodeUrl",
      verified: false);
  const tTicket2 = TicketModel(
      id: 2,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 2,
      qrCodeUrl: "qrCodeUrl",
      verified: false);
  const tTickets = [tTicket1, tTicket2];
  const tMember1 = MemberModel(id: 1, userId: 1, eventId: 1, username: "test");
  const tMember2 = MemberModel(id: 2, userId: 2, eventId: 1, username: "test2");
  const tMembers = [tMember1, tMember2];
  final tEvent1 = Event(
    name: 'Event 1',
    id: 1,
    description: 'short description',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 18, minute: 00),
    endTime: const TimeOfDay(hour: 18, minute: 00),
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
    closed: false,
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
    id: 1,
    description: 'short description',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 18, minute: 00),
    endTime: const TimeOfDay(hour: 18, minute: 00),
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
    closed: false,
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
