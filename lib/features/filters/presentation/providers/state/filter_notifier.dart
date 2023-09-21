import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/filters/domain/usecases/toggle_filter.dart';
import 'package:faro_clean_tdd/features/filters/presentation/providers/filter_provider.dart';
import 'package:faro_clean_tdd/features/filters/presentation/providers/state/filter_state.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart'
    as ev;

import 'package:flutter_riverpod/flutter_riverpod.dart';

const baseFilter = {
  FilterCategory.concert: false,
  FilterCategory.culture: false,
  FilterCategory.loisir: false,
  FilterCategory.sport: false,
};

class FilterNotifier extends StateNotifier<FilterState> {
  final ToggleFilter toggleFilterUsecase;

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
    if (filters.filters[FilterCategory.concert] == false &&
        filters.filters[FilterCategory.culture] == false &&
        filters.filters[FilterCategory.loisir] == false &&
        filters.filters[FilterCategory.sport] == false) {
      return events.indexEvent;
    } else {
      final eventsList = events.indexEvent.where((element) {
        if (filters.filters[FilterCategory.concert] == true &&
            element.category.name == FilterCategory.concert.name) {
          return true;
        }
        if (filters.filters[FilterCategory.culture] == true &&
            element.category.name == FilterCategory.culture.name) {
          return true;
        }
        if (filters.filters[FilterCategory.loisir] == true &&
            element.category.name == FilterCategory.loisir.name) {
          return true;
        }
        if (filters.filters[FilterCategory.sport] == true &&
            element.category.name == FilterCategory.sport.name) {
          return true;
        }
        return false;
      }).toList();
      return eventsList;
    }
  }
});
