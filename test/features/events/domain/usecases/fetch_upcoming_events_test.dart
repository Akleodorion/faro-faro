import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_upcoming_events.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'fetch_upcoming_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late FetchUpcomingEvents usecase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    usecase = FetchUpcomingEvents(repository: mockEventRepository);
  });

  final tEvent1 = Event(
      name: 'Event 1',
      eventId: 1,
      description: 'short description',
      date: DateTime.now(),
      location: 'Lille',
      category: Category.concert,
      imageUrl: 'imageUrl',
      userId: 1,
      modelEco: ModelEco.gratuit);

  final tEvent2 = Event(
      name: 'Event 2',
      eventId: 2,
      description: 'short description',
      date: DateTime.now(),
      location: 'Arras',
      category: Category.culture,
      imageUrl: 'imageUrl',
      userId: 1,
      modelEco: ModelEco.payant);
  final List<Event> tList = [tEvent1, tEvent2];

  test(
    "should retrieve a list of upcoming events",
    () async {
      //arrange
      when(mockEventRepository.fetchUpcomingEvents())
          .thenAnswer((realInvocation) async => Right(tList));
      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(tList));
      verify(mockEventRepository.fetchUpcomingEvents()).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
