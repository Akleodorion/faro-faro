import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GeneralFilter {
  free,
  paid,
  minPrice,
  date,
}

final baseFilter = {
  GeneralFilter.free: true,
  GeneralFilter.paid: true,
  GeneralFilter.minPrice: 0.0,
  GeneralFilter.date: DateTime.now()
};

class GeneralFiltersNotifier
    extends StateNotifier<Map<GeneralFilter, dynamic>> {
  GeneralFiltersNotifier() : super(baseFilter);

  void setFilter(GeneralFilter filter, dynamic value) {
    state = {...state, filter: value};
  }
}

final generalFiltersProvider =
    StateNotifierProvider<GeneralFiltersNotifier, Map<GeneralFilter, dynamic>>(
        (ref) {
  return GeneralFiltersNotifier();
});

final generalFiltersEventProvider = Provider((ref) {
  final List<Event> events = ref.watch(eventsProvider);
  final generalFilters = ref.watch(generalFiltersProvider);

  final filteredEvents = events.where((event) {
    final eventDate = event.date;
    final isEventAfterDate =
        eventDate.isAfter(generalFilters[GeneralFilter.date]);
    final isEventPayant = event.modelEco == ModelEco.payant;
    final isEventGratuit = event.modelEco == ModelEco.gratuit;
    final isMinPriceSatisfied =
        event.standardTicketPrice >= generalFilters[GeneralFilter.minPrice];

    if (isEventAfterDate &&
        ((generalFilters[GeneralFilter.paid] &&
                isEventPayant &&
                isMinPriceSatisfied) ||
            (generalFilters[GeneralFilter.free] && isEventGratuit))) {
      return true;
    }

    return false;
  }).toList();

  return filteredEvents;
});

final maxPaidEventPrice = Provider((ref) {
  late int price;
  final events = ref.watch(eventsProvider);
  if (events != []) {
    price = events[0].standardTicketPrice;
  }

  for (var event in events) {
    if (event.standardTicketPrice > price) {
      price = event.standardTicketPrice;
    }
  }
  return price.toDouble();
});
