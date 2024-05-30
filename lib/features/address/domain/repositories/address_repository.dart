// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';
import '../../../../core/errors/failures.dart';

abstract class AddressRepository {
  // Récupère la position du téléphone et l'utilise pour établir le lieu de l'évènement.
  Future<Either<Failure, Address>> getCurrentLocationAddress();

  // Utilise la position fournie via la carte interactive et s'en sert pour établir le lieu de l'évènement.
  Future<Either<Failure, Address>> getSelectedLocationAddress(
      double latitude, double longitude);
}
