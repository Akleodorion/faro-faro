// ignore_for_file: constant_identifier_names

import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';

const FILTERS = [
  Category.concert,
  Category.loisir,
  Category.culture,
  Category.sport,
];

abstract class FilterLocalDataSource {
  Category getFilter(int index);
}

class FilterLocalDataSourceImpl implements FilterLocalDataSource {
  @override
  Category getFilter(int index) {
    return FILTERS.singleWhere((element) => element.index == index);
  }
}
