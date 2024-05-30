// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/pick_image/domain/entities/picked_image.dart';
import '../../../../core/errors/failures.dart';

abstract class PickedImageRepository {
  // sélectionne une image depuis la Gallerie
  Future<Either<Failure, PickedImage?>> pickImageFromGalery();
}
