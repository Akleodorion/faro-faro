import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/filters/domain/entities/filter.dart';

abstract class FilterRepository {
  // Enregistre l'état des filtres
  Future<Either<Failure, Filter>> setFilter(
      Map<FilterCategory, dynamic> filters);
}
