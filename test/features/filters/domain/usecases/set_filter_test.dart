import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/filters/domain/repositories/filter_repository.dart';
import 'package:faro_clean_tdd/features/filters/domain/usecases/set_filter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_filter_test.mocks.dart';

@GenerateMocks([FilterRepository])
void main() {
  late MockFilterRepository mockFilterRepository;
  late SetFilter setFilter;

  setUp(() {
    mockFilterRepository = MockFilterRepository();
    setFilter = SetFilter(repository: mockFilterRepository);
  });

  group(
    "setFilter",
    () {
      final tFilterMap = {
        FilterCategory.concert: true,
        FilterCategory.culture: true,
        FilterCategory.loisir: true,
        FilterCategory.sport: true,
        FilterCategory.prixMax: null,
        FilterCategory.prixMin: null,
      };
      final tFilter = Filter(
        filters: tFilterMap,
      );
      test(
        "should return a Filter",
        () async {
          //arrange
          when(mockFilterRepository.setFilter(any))
              .thenAnswer((realInvocation) async => tFilter);
          //act
          final result = await setFilter.call(Params(filters: tFilterMap));
          //assert
          verify(mockFilterRepository.setFilter(tFilterMap));
          expect(result, tFilter);
        },
      );
    },
  );
}
