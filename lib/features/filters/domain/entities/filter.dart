import 'package:equatable/equatable.dart';

enum FilterCategory {
  concert,
  loisir,
  sport,
  culture,
  prixMin,
  prixMax,
}

class Filter extends Equatable {
  const Filter({required this.filters});
  final Map<FilterCategory, dynamic> filters;

  @override
  List<Object?> get props => [filters];
}
