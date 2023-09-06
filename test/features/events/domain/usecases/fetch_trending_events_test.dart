import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';
import 'package:faro_clean_tdd/features/events/domain/usecases/fetch_trending_events.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'fetch_trending_events_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late MockEventRepository mockEventRepository;
  late FetchTrendingEvents usecase;

  setUp(() {
    mockEventRepository = MockEventRepository();
    usecase = FetchTrendingEvents(repository: mockEventRepository);
  });

  final tEvent1 = Event(
      name: 'Event 1',
      description: 'short description',
      date: DateTime.now(),
      location: 'Lille',
      category: Category.concert,
      imageUrl: 'imageUrl',
      userId: 1,
      modelEco: ModelEco.gratuit);

  final tEvent2 = Event(
      name: 'Event 2',
      description: 'short description',
      date: DateTime.now(),
      location: 'Arras',
      category: Category.culture,
      imageUrl: 'imageUrl',
      userId: 1,
      modelEco: ModelEco.payant);
  final List<Event> tList = [tEvent1, tEvent2];
  test(
    "should get a list of trending events",
    () async {
      //arrange
      when(mockEventRepository.fetchTrendingEvent())
          .thenAnswer((_) async => Right(tList));
      //act
      final result = await usecase.execute();
      //assert
      expect(result, Right(tList));
      verify(mockEventRepository.fetchTrendingEvent()).called(1);
      verifyNoMoreInteractions(mockEventRepository);
    },
  );
}
