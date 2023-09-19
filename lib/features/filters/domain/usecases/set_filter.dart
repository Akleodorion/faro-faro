import 'package:equatable/equatable.dart';
import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/filters/domain/repositories/filter_repository.dart';

class SetFilter {
  SetFilter({required this.repository});
  final FilterRepository repository;

  Future<Filter> call(Params params) async {
    return repository.setFilter(params.filters);
  }
}

class Params extends Equatable {
  const Params({required this.filters});

  final Map<FilterCategory, dynamic> filters;

  @override
  List<Object?> get props => [filters];
}
