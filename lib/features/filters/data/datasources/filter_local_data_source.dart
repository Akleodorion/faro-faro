// ignore_for_file: constant_identifier_names

import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';

const FILTERS = [
  FilterCategory.concert,
  FilterCategory.loisir,
  FilterCategory.culture,
  FilterCategory.sport,
];

abstract class FilterLocalDataSource {
  FilterCategory getFilter(int index);
}

class FilterLocalDataSourceImpl implements FilterLocalDataSource {
  @override
  FilterCategory getFilter(int index) {
    return FILTERS.singleWhere((element) => element.index == index);
  }
}
