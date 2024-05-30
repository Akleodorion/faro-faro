// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/address/domain/repositories/address_repository.dart';
import '../../../../core/errors/failures.dart';

class GetCurrentLocationAddress {
  GetCurrentLocationAddress({required this.repository});

  final AddressRepository repository;

  Future<Either<Failure, Address>> call() async {
    return await repository.getCurrentLocationAddress();
  }
}
