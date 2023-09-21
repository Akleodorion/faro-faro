import 'package:faro_clean_tdd/features/category_filter/data/datasources/filter_local_data_source.dart';
import 'package:faro_clean_tdd/features/category_filter/domain/entities/filter.dart';
import 'package:faro_clean_tdd/features/category_filter/domain/repositories/category_filter_repository.dart';

class CategoryFilterRepositoryImpl implements CategoryFilterRepository {
  final FilterLocalDataSource localDataSource;

  CategoryFilterRepositoryImpl({required this.localDataSource});

  @override
  Category toggleCategoryFilter(int index) {
    return localDataSource.getFilter(index);
  }
}
