import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/filters/domain/repositories/filter_repository.dart';

class ToggleFilter {
  ToggleFilter({required this.repository});
  final FilterRepository repository;

  FilterCategory call(int index) {
    return repository.toggleFilter(index);
  }
}
