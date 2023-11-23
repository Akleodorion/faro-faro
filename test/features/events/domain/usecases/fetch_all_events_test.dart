import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_all_events.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
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

  const tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const tMember2 = Member(id: 2, userId: 2, eventId: 1);
  const tMembers = [tMember1, tMember2];
  final tEvent1 = Event(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime.now(),
    address: const Address(
        latitude: 42.41454,
        longitude: -127.5345,
        addressName: "Lille",
        geocodeUrl: "geocodeUrl"),
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.gratuit,
    members: tMembers,
    activated: false,
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

  final tEvent2 = Event(
    name: 'Event 2',
    eventId: 2,
    description: 'short description',
    date: DateTime.now(),
    address: const Address(
        latitude: 42.41454,
        longitude: -127.5345,
        addressName: "Arras",
        geocodeUrl: "geocodeUrl"),
    category: Category.culture,
    imageUrl: 'imageUrl',
    userId: 1,
    modelEco: ModelEco.payant,
    members: tMembers,
    activated: false,
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
