import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';

abstract class CategoryFilterRepository {
  // Enregistre l'état des filtres
  Category toggleCategoryFilter(int index);
}
