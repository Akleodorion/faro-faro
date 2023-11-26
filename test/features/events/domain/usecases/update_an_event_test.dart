import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/update_an_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late UpdateAnEventUsecase sut;

  setUp(() {
    mockEventRepository = MockEventRepository();
    sut = UpdateAnEventUsecase(repository: mockEventRepository);
  });

  group(
    "execute",
    () {
      final tFile = File("flyers.jpg");
      final tEvent = EventModel(
          name: "name",
          eventId: 1,
          description: "description",
          date: DateTime.now(),
          address: const Address(
              addressName: "sesame streets",
              longitude: 42.452,
              latitude: 123.54,
              geocodeUrl: ""),
          category: Category.concert,
          imageUrl: tFile.path,
          userId: 1,
          modelEco: ModelEco.gratuit,
          members: const [],
          tickets: const [],
          activated: false,
          maxStandardTicket: 20,
          standardTicketDescription: "standardTicketDescription");
      test(
        "should return a valid Event if the call is a success",
        () async {
          //arrange
          when(mockEventRepository.updateAnEvent(
                  event: anyNamed('event'), image: anyNamed('image')))
              .thenAnswer((realInvocation) async => Right(tEvent));
          //act
          final result = await sut.execute(event: tEvent, image: tFile);
          //assert
          expect(result, Right(tEvent));
        },
      );

      test(
        "should return a ServerFailure is the call is not a success",
        () async {
          //arrange
          when(mockEventRepository.updateAnEvent(
                  event: anyNamed('event'), image: anyNamed('image')))
              .thenAnswer((realInvocation) async =>
                  const Left(ServerFailure(errorMessage: 'oops')));
          //act
          final result = await sut.execute(event: tEvent, image: tFile);
          //assert
          expect(result, const Left(ServerFailure(errorMessage: "oops")));
        },
      );
    },
  );
}
