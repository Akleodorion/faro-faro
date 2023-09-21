import 'package:equatable/equatable.dart';

import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loaded extends FilterState {
  Loaded({
    required this.filters,
  });
  final Map<Category, dynamic> filters;
  @override
  List<Object?> get props => [filters];
}
