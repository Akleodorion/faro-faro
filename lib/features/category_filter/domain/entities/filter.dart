import 'package:equatable/equatable.dart';

enum Category {
  concert,
  loisir,
  sport,
  culture,
}

class CategoryFilter extends Equatable {
  const CategoryFilter({required this.filter});
  final Map<Category, dynamic> filter;

  @override
  List<Object?> get props => [filter];
}
