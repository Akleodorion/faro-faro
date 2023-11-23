import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/post_an_event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_notifier.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/state/post_event_state.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'post_event_notifier_test.mocks.dart';

@GenerateMocks([PostAnEvent])
void main() {
  late MockPostAnEvent mockPostAnEvent;
  late PostEventNotifier postEventNotifier;

  setUpAll(() {
    mockPostAnEvent = MockPostAnEvent();
    postEventNotifier = PostEventNotifier(postAnEventUsecase: mockPostAnEvent);
  });

  // Usecases tests
  test(
    "initialState should be Loading",
    () async {
      //assert
      expect(postEventNotifier.initialState, Initial(infoMap: const {}));
    },
  );
  const tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const tMember2 = Member(id: 2, userId: 2, eventId: 1);
  const tMembers = [tMember1, tMember2];
  group('postAnEvent', () {
    final tEvent = EventModel(
        name: "My test event",
        eventId: 20,
        description: "Short description for the test event !",
        date: DateTime.now(),
        address: const Address(
            latitude: 10.5264,
            longitude: 20.4585,
            addressName: "addressName",
            geocodeUrl: "geocodeUrl"),
        category: Category.concert,
        imageUrl: "flyers.jpg",
        userId: 1,
        modelEco: ModelEco.gratuit,
        members: tMembers,
        activated: false,
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
      "should emit [Loading, Loaded] if the request is successfull ",
      () async {
        //arrange
        when(mockPostAnEvent.execute(event: tEvent, image: tImage))
            .thenAnswer((_) async => Right(tEvent));
        //assert
        final expectedState = [Loading(), Loaded(event: tEvent)];
        expectLater(postEventNotifier.stream, emitsInOrder(expectedState));
        // act
        await postEventNotifier.postAnEvent(event: tEvent, image: tImage);
      },
    );

    test(
      "should emit [Error] if the request is unsuccessful",
      () async {
        //arrange
        when(mockPostAnEvent.execute(event: tEvent, image: tImage)).thenAnswer(
            (realInvocation) async => const Left(
                ServerFailure(errorMessage: "an error has occured")));
        //act
        final expectedState = [
          Loading(),
          Error(infoMap: const {}, message: "an error has occured")
        ];
        expectLater(postEventNotifier.stream, emitsInOrder(expectedState));
        //assert
        await postEventNotifier.postAnEvent(event: tEvent, image: tImage);
      },
    );
  });
}
