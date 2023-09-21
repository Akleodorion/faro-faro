import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/category_filter/domain/repositories/category_filter_repository.dart';

class ToggleCategoryFilter {
  ToggleCategoryFilter({required this.repository});
  final CategoryFilterRepository repository;

  Category call(int index) {
    return repository.toggleCategoryFilter(index);
  }
}
