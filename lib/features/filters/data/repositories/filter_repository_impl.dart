import 'package:faro_clean_tdd/features/filters/data/datasources/filter_local_data_source.dart';
import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/filters/domain/repositories/filter_repository.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterLocalDataSource localDataSource;

  FilterRepositoryImpl({required this.localDataSource});

  @override
  FilterCategory toggleFilter(int index) {
    return localDataSource.getFilter(index);
  }
}
