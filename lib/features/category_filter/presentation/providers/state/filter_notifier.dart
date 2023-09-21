import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/category_filter/domain/usecases/toggle_category_filter.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/filter_provider.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/state/filter_state.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart'
    as ev;

import 'package:flutter_riverpod/flutter_riverpod.dart';

const baseFilter = {
  Category.concert: false,
  Category.culture: false,
  Category.loisir: false,
  Category.sport: false,
};

class FilterNotifier extends StateNotifier<FilterState> {
  final ToggleCategoryFilter toggleFilterUsecase;

  FilterNotifier({
    required this.toggleFilterUsecase,
  }) : super(Loaded(filters: baseFilter));

  toggleFilter(int index, FilterState filterState) {
    final filterCategory = toggleFilterUsecase.call(index);
    var filters = filterState is Loaded ? {...filterState.filters} : baseFilter;
    filters[filterCategory] = !filters[filterCategory];
    state = Loaded(filters: filters);
  }
}

final filteredEventsProvider = Provider((ref) {
  final events = ref.watch(eventProvider);
  final filters = ref.watch(filterProvider);

  if (filters is Loaded && events is ev.Loaded) {
    if (filters.filters[Category.concert] == false &&
        filters.filters[Category.culture] == false &&
        filters.filters[Category.loisir] == false &&
        filters.filters[Category.sport] == false) {
      return events.indexEvent;
    } else {
      final eventsList = events.indexEvent.where((element) {
        if (filters.filters[Category.concert] == true &&
            element.category.name == Category.concert.name) {
          return true;
        }
        if (filters.filters[Category.culture] == true &&
            element.category.name == Category.culture.name) {
          return true;
        }
        if (filters.filters[Category.loisir] == true &&
            element.category.name == Category.loisir.name) {
          return true;
        }
        if (filters.filters[Category.sport] == true &&
            element.category.name == Category.sport.name) {
          return true;
        }
        return false;
      }).toList();
      return eventsList;
    }
  }
});
