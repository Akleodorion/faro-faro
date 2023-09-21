import 'package:equatable/equatable.dart';

enum FilterCategory {
  concert,
  loisir,
  sport,
  culture,
}

class Filter extends Equatable {
  const Filter({required this.filter});
  final Map<FilterCategory, dynamic> filter;

  @override
  List<Object?> get props => [filter];
}
