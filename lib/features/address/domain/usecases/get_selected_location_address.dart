// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/address/domain/repositories/address_repository.dart';
import '../../../../core/errors/failures.dart';

class GetSelectedLocationAddress {
  GetSelectedLocationAddress({required this.repository});

  final AddressRepository repository;

  Future<Either<Failure, Address>> call(
      double latitude, double longitude) async {
    return repository.getSelectedLocationAddress(latitude, longitude);
  }
}
