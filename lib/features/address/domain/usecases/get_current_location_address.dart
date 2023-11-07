import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/address/domain/repositories/address_repository.dart';

import '../../../../core/errors/failures.dart';

class GetCurrentLocationAddress {
  GetCurrentLocationAddress({required this.repository});

  final AddressRepository repository;

  Future<Either<Failure, Address?>?> call() async {
    return await repository.getCurrentLocationAddress();
  }
}
