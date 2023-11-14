import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/events/data/datasources/event_remote_data_source.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/data/repositories/event_repository_impl.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
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

          final tEvent1 = EventModel(
            name: 'Event 1',
            eventId: 1,
            description: 'short description',
            date: DateTime.now(),
            address: 'Lille',
            latitude: 42.41454,
            longitude: -127.5345,
            category: Category.concert,
            imageUrl: 'imageUrl',
            userId: 1,
            modelEco: ModelEco.gratuit,
            standardTicketPrice: 5000,
            maxStandardTicket: 50,
            standardTicketDescription: "Standard ticket simple description",
            vipTicketPrice: 10000,
            maxVipTicket: 25,
            vipTicketDescription: "vip ticket simple description",
            vvipTicketPrice: 15000,
            maxVvipTicket: 10,
            vvipTicketDescription: "vvip ticket simple description",
          );

          final tEvent2 = EventModel(
            name: 'Event 2',
            eventId: 2,
            description: 'short description',
            date: DateTime.now(),
            address: 'Arras',
            latitude: 42.41454,
            longitude: -127.5345,
            category: Category.culture,
            imageUrl: 'imageUrl',
            userId: 1,
            modelEco: ModelEco.payant,
            standardTicketPrice: 5000,
            maxStandardTicket: 50,
            standardTicketDescription: "Standard ticket simple description",
            vipTicketPrice: 10000,
            maxVipTicket: 25,
            vipTicketDescription: "vip ticket simple description",
            vvipTicketPrice: 15000,
            maxVvipTicket: 10,
            vvipTicketDescription: "vvip ticket simple description",
          );

          final tEvents = [tEvent1, tEvent2];

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
              expect(
                  result,
                  const Left(
                      ServerFailure(errorMessage: "No internet connexion")));
            },
          );
        },
      );
    },
  );

  group('postAnEvent', () {
    final tEvent = EventModel(
        name: "My test event",
        eventId: 20,
        description: "Short description for the test event !",
        date: DateTime.now(),
        address: "Lille",
        latitude: 42.54596,
        longitude: -127.5345,
        category: Category.concert,
        imageUrl: "flyers.jpg",
        userId: 1,
        modelEco: ModelEco.gratuit,
        standardTicketPrice: 5000,
        maxStandardTicket: 15,
        standardTicketDescription: "Short ticket description for the test",
        vipTicketPrice: 5000,
        maxVipTicket: 15,
        vipTicketDescription: "Short ticket description for the test",
        vvipTicketPrice: 5000,
        maxVvipTicket: 15,
        vvipTicketDescription: "Short ticket description for the test");

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
}
