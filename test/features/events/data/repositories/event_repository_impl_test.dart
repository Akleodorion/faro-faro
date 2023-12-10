import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/datasources/event_remote_data_source.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/data/repositories/event_repository_impl.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'event_repository_impl_test.mocks.dart';

@GenerateMocks([EventRemoteDatasource, NetworkInfo])
void main() {
  late MockEventRemoteDatasource mockEventRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late EventRepositoryImpl eventRepositoryImpl;

  setUp(() {
    mockEventRemoteDatasource = MockEventRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    eventRepositoryImpl = EventRepositoryImpl(
        remoteDatasource: mockEventRemoteDatasource,
        networkInfo: mockNetworkInfo);
  });

  const tMember1 = Member(
    id: 1,
    userId: 1,
    eventId: 1,
    username: "test",
  );

  const tMember2 = Member(
    id: 2,
    userId: 2,
    eventId: 1,
    username: "test2",
  );
  const tTicket1 = Ticket(
    id: 1,
    type: Type.standard,
    description: "description",
    eventId: 1,
    userId: 1,
    qrCodeUrl: "qrCodeUrl",
    verified: false,
  );
  const tTicket2 = Ticket(
    id: 2,
    type: Type.standard,
    description: "description",
    eventId: 1,
    userId: 2,
    qrCodeUrl: "qrCodeUrl",
    verified: false,
  );
  const tTickets = [
    tTicket1,
    tTicket2,
  ];
  const tMembers = [
    tMember1,
    tMember2,
  ];

  final tEvent1 = EventModel(
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
      sublocality: "Cocody",
    ),
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

  final tEvent2 = EventModel(
    name: 'Event 2',
    id: 2,
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
      sublocality: "Cocody",
    ),
    category: Category.culture,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.payant,
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

  final tEvents = [
    tEvent1,
    tEvent2,
  ];

  group(
    "fetchAllEvents",
    () {
      group(
        "If there is an internet connexion",
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected)
                .thenAnswer((realInvocation) async => true);
          });

          test(
            "should return the list of Events",
            () async {
              //arrange
              when(mockEventRemoteDatasource.fetchAllEvents())
                  .thenAnswer((_) async => tEvents);
              //act
              final result = await eventRepositoryImpl.fetchAllEvents();
              //assert
              expect(result, Right(tEvents));
              verify(mockEventRemoteDatasource.fetchAllEvents()).called(1);
            },
          );
        },
      );

      group(
        "If there is no internet connexion",
        () {
          test(
            "should return a Failure",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected)
                  .thenAnswer((realInvocation) async => false);
              //act
              final result = await eventRepositoryImpl.fetchAllEvents();
              //assert
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
            },
          );
        },
      );
    },
  );

  group('postAnEvent', () {
    const tTicket1 = Ticket(
        id: 1,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTicket2 = Ticket(
        id: 2,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 2,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTickets = [tTicket1, tTicket2];
    const tMember1 = Member(id: 1, userId: 1, eventId: 1, username: "test");
    const tMember2 = Member(id: 2, userId: 2, eventId: 1, username: "test2");
    const tMembers = [tMember1, tMember2];
    final tEvent = EventModel(
        name: "My test event",
        id: 20,
        description: "Short description for the test event !",
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
        imageUrl: "flyers.jpg",
        userId: 1,
        modelEco: ModelEco.gratuit,
        members: tMembers,
        tickets: tTickets,
        activated: false,
        closed: false,
        standardTicketPrice: 5000,
        maxStandardTicket: 15,
        standardTicketDescription: "Short ticket description for the test",
        goldTicketPrice: 5000,
        maxGoldTicket: 15,
        goldTicketDescription: "Short ticket description for the test",
        platinumTicketPrice: 5000,
        maxPlatinumTicket: 15,
        platinumTicketDescription: "Short ticket description for the test");

    final tImage = File('flyers.jpg');
    group('if there is an internet connexion', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      test(
        "should return a  valid EventModel if the request is successfull ",
        () async {
          //arrange
          when(mockEventRemoteDatasource.postAnEvent(
                  event: anyNamed(('event')), image: tImage))
              .thenAnswer((realInvocation) async => tEvent);
          //act
          final result = await eventRepositoryImpl.postAnEvent(
              event: tEvent, image: tImage);
          //assert
          expect(result, Right(tEvent));
        },
      );

      test(
        "should return a ServerFailure if the request is unsuccessfull ",
        () async {
          //arrange
          when(mockEventRemoteDatasource.postAnEvent(
                  event: anyNamed(('event')), image: tImage))
              .thenThrow(ServerException(errorMessage: 'oops'));
          //act
          final result = await eventRepositoryImpl.postAnEvent(
              event: tEvent, image: tImage);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    });

    group('if there is no internet connexion', () {
      test(
        "should return a ServerFailure with the correct message",
        () async {
          //arrange
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
          //act
          final result = await eventRepositoryImpl.postAnEvent(
              event: tEvent, image: tImage);
          //assert
          verify(mockNetworkInfo.isConnected).called(1);
          expect(result,
              const Left(ServerFailure(errorMessage: 'No internet connexion')));
        },
      );
    });
  });

  group('updateAnEvent', () {
    const tTicket1 = Ticket(
        id: 1,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 1,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTicket2 = Ticket(
        id: 2,
        type: Type.standard,
        description: "description",
        eventId: 1,
        userId: 2,
        qrCodeUrl: "qrCodeUrl",
        verified: false);
    const tTickets = [tTicket1, tTicket2];
    const tMember1 = Member(id: 1, userId: 1, eventId: 1, username: "test");
    const tMember2 = Member(id: 2, userId: 2, eventId: 1, username: "test2");
    const tMembers = [tMember1, tMember2];
    final tEvent = EventModel(
        name: "My test event",
        id: 20,
        description: "Short description for the test event !",
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
        imageUrl: "flyers.jpg",
        userId: 1,
        modelEco: ModelEco.gratuit,
        members: tMembers,
        tickets: tTickets,
        activated: false,
        closed: false,
        standardTicketPrice: 5000,
        maxStandardTicket: 15,
        standardTicketDescription: "Short ticket description for the test",
        goldTicketPrice: 5000,
        maxGoldTicket: 15,
        goldTicketDescription: "Short ticket description for the test",
        platinumTicketPrice: 5000,
        maxPlatinumTicket: 15,
        platinumTicketDescription: "Short ticket description for the test");

    final tImage = File('flyers.jpg');
    group('if there is an internet connexion', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      test(
        "should return a  valid EventModel if the request is successfull ",
        () async {
          //arrange
          when(mockEventRemoteDatasource.updateAnEvent(
                  event: anyNamed(('event')), image: tImage))
              .thenAnswer((realInvocation) async => tEvent);
          //act
          final result = await eventRepositoryImpl.updateAnEvent(
              event: tEvent, image: tImage);
          //assert
          expect(result, Right(tEvent));
        },
      );

      test(
        "should return a ServerFailure if the request is unsuccessfull ",
        () async {
          //arrange
          when(mockEventRemoteDatasource.updateAnEvent(
                  event: anyNamed(('event')), image: tImage))
              .thenThrow(ServerException(errorMessage: 'oops'));
          //act
          final result = await eventRepositoryImpl.updateAnEvent(
              event: tEvent, image: tImage);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: 'oops')));
        },
      );
    });

    group('if there is no internet connexion', () {
      test(
        "should return a ServerFailure with the correct message",
        () async {
          //arrange
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
          //act
          final result = await eventRepositoryImpl.updateAnEvent(
              event: tEvent, image: tImage);
          //assert
          verify(mockNetworkInfo.isConnected).called(1);
          expect(result,
              const Left(ServerFailure(errorMessage: 'No internet connexion')));
        },
      );
    });
  });

  group(
    "activate an Event",
    () {
      const tEventId = 1;
      final tEvent = EventModel(
          name: "My test event",
          id: tEventId,
          description: "Short description for the test event !",
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
          imageUrl: "flyers.jpg",
          userId: 1,
          modelEco: ModelEco.gratuit,
          members: const [],
          tickets: const [],
          activated: false,
          closed: false,
          standardTicketPrice: 5000,
          maxStandardTicket: 15,
          standardTicketDescription: "Short ticket description for the test",
          goldTicketPrice: 5000,
          maxGoldTicket: 15,
          goldTicketDescription: "Short ticket description for the test",
          platinumTicketPrice: 5000,
          maxPlatinumTicket: 15,
          platinumTicketDescription: "Short ticket description for the test");
      group(
        "if there is no internet connexion",
        () {
          test(
            "should return a ServerFailure with the right message",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected)
                  .thenAnswer((realInvocation) async => false);
              //act
              final result =
                  await eventRepositoryImpl.activateAnEvent(eventId: tEventId);
              //assert

              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
              verify(mockNetworkInfo.isConnected).called(1);
            },
          );
        },
      );

      group(
        "if there is an internet connexion",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));
          test(
            "should return the event model when the call is a success",
            () async {
              //arrange
              when(mockEventRemoteDatasource.activateAnEvent(
                      eventId: anyNamed('eventId')))
                  .thenAnswer((realInvocation) async => tEvent);
              //act
              final result =
                  await eventRepositoryImpl.activateAnEvent(eventId: tEventId);
              //assert

              expect(result, Right(tEvent));
              verify(mockEventRemoteDatasource.activateAnEvent(
                      eventId: tEventId))
                  .called(1);
            },
          );

          test(
            "should return a ServerFailure when the call is not success",
            () async {
              //arrange
              when(mockEventRemoteDatasource.activateAnEvent(
                      eventId: anyNamed('eventId')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result =
                  await eventRepositoryImpl.activateAnEvent(eventId: tEventId);
              //assert

              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
              verify(mockEventRemoteDatasource.activateAnEvent(
                      eventId: tEventId))
                  .called(1);
            },
          );
        },
      );
    },
  );

  group(
    "close an Event",
    () {
      group(
        "if there is no internet connexion",
        () {
          test(
            "should return a ServerFailure with the right message",
            () async {
              //arrange
              when(mockNetworkInfo.isConnected)
                  .thenAnswer((realInvocation) async => false);
              //act
              final result =
                  await eventRepositoryImpl.closeAnEvent(eventId: tEvent1.id!);
              //assert

              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
              verify(mockNetworkInfo.isConnected).called(1);
            },
          );
        },
      );

      group(
        "if there is an internet connexion",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));
          test(
            "should return the event model when the call is a success",
            () async {
              //arrange
              when(mockEventRemoteDatasource.closeAnEvent(
                      eventId: anyNamed('eventId')))
                  .thenAnswer((realInvocation) async => tEvent1);
              //act
              final result =
                  await eventRepositoryImpl.closeAnEvent(eventId: tEvent1.id!);
              //assert

              expect(result, Right(tEvent1));
              verify(mockEventRemoteDatasource.closeAnEvent(
                      eventId: tEvent1.id!))
                  .called(1);
            },
          );

          test(
            "should return a ServerFailure when the call is not success",
            () async {
              //arrange
              when(mockEventRemoteDatasource.closeAnEvent(
                      eventId: anyNamed('eventId')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result =
                  await eventRepositoryImpl.closeAnEvent(eventId: tEvent1.id!);
              //assert

              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
              verify(mockEventRemoteDatasource.closeAnEvent(
                      eventId: tEvent1.id!))
                  .called(1);
            },
          );
        },
      );
    },
  );
}
