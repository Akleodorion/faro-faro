// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/internal_features/general_filter/general_filter_provider.dart';

final baseFilter = {
  Category.concert: false,
  Category.sport: false,
  Category.loisir: false,
  Category.culture: false,
};

class FiltersNotifier extends StateNotifier<Map<Category, bool>> {
  FiltersNotifier() : super(baseFilter);

  void setFilter(Category filter) {
    state = {...state, filter: !state[filter]!};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Category, bool>>((ref) {
  return FiltersNotifier();
});

final filteredEventProvider = Provider((ref) {
  final List<Event> events = ref.watch(generalFiltersEventProvider);
  final filters = ref.watch(filtersProvider);

  final filteredEvents = events.where((event) {
    if (filters[Category.concert]! && event.category == Category.concert) {
      return true;
    }
    if (filters[Category.culture]! && event.category == Category.culture) {
      return true;
    }
    if (filters[Category.sport]! && event.category == Category.sport) {
      return true;
    }
    if (filters[Category.loisir]! && event.category == Category.loisir) {
      return true;
    }

    return false;
  }).toList();

  if (filters[Category.concert] == false &&
      filters[Category.culture] == false &&
      filters[Category.sport] == false &&
      filters[Category.loisir] == false) {
    return events;
  }
  return filteredEvents;
});
