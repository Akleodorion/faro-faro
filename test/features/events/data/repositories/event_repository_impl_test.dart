import 'package:dartz/dartz.dart';
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
            location: 'Lille',
            category: Category.concert,
            imageUrl: 'imageUrl',
            userId: 1,
            modelEco: ModelEco.gratuit,
            standardTicketPrice: 5000,
            maxStandardTicket: 50,
            vipTicketPrice: 10000,
            maxVipTicket: 25,
            vvipTicketPrice: 15000,
            maxVvipTicket: 10,
          );

          final tEvent2 = EventModel(
            name: 'Event 2',
            eventId: 2,
            description: 'short description',
            date: DateTime.now(),
            location: 'Arras',
            category: Category.culture,
            imageUrl: 'imageUrl',
            userId: 1,
            modelEco: ModelEco.payant,
            standardTicketPrice: 5000,
            maxStandardTicket: 50,
            vipTicketPrice: 10000,
            maxVipTicket: 25,
            vvipTicketPrice: 15000,
            maxVvipTicket: 10,
          );

          final tEvents = [tEvent1, tEvent2];

          test(
            "should return the list of Events",
            () async {
              //arrange
              when(mockEventRemoteDatasource.fetchAllEvents())
                  .thenAnswer((realInvocation) async => tEvents);
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
}
