import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_an_event_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late PostAnEvent postAnEvent;

  setUp(() {
    mockEventRepository = MockEventRepository();
    postAnEvent = PostAnEvent(repository: mockEventRepository);
  });

  group('Execute', () {
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

    test(
      "should return the newly created Event",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(event: tEvent, image: tImage))
            .thenAnswer((_) async => Right(tEvent));
        //act
        final result = await postAnEvent.execute(event: tEvent, image: tImage);
        //assert
        expect(result, Right(tEvent));
      },
    );

    test(
      "should return Left Failure message is unsuccessful",
      () async {
        //arrange
        when(mockEventRepository.postAnEvent(event: tEvent, image: tImage))
            .thenAnswer(
                (_) async => const Left(ServerFailure(errorMessage: 'oops')));
        //act
        final result = await postAnEvent.execute(event: tEvent, image: tImage);
        //assert
        expect(result, const Left(ServerFailure(errorMessage: 'oops')));
      },
    );
  });
}
