// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';

enum GeneralFilter {
  free,
  paid,
  minPrice,
  date,
}

final today = DateTime.now();

final baseFilter = {
  GeneralFilter.free: true,
  GeneralFilter.paid: true,
  GeneralFilter.minPrice: 0.0,
  GeneralFilter.date: DateTime(
    today.year,
    today.month,
    today.day,
  )
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
  final List<Event> events = ref.watch(indexEventProvider);
  final generalFilters = ref.watch(generalFiltersProvider);

  final filteredEvents = events.where((event) {
    final eventDate = event.date;
    final isEventAfterDate =
        eventDate.isAfter(generalFilters[GeneralFilter.date]);
    final isEventPayant = event.modelEco == ModelEco.payant;
    final isEventGratuit = event.modelEco == ModelEco.gratuit;
    bool isMinPriceSatisfied = true;

    if (event.standardTicketPrice != null) {
      isMinPriceSatisfied =
          event.standardTicketPrice! >= generalFilters[GeneralFilter.minPrice];
    }

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
  final events = ref.watch(indexEventProvider);
  if (events != []) {
    price = events.first.standardTicketPrice ?? 0;
  }

  for (var event in events) {
    if (event.standardTicketPrice == null) {
      continue;
    } else if (event.standardTicketPrice! > price) {
      price = event.standardTicketPrice!;
    }
  }
  return price.toDouble();
});
