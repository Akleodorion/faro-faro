import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';

abstract class FilterRepository {
  // Enregistre l'état des filtres
  FilterCategory toggleFilter(int index);
}
