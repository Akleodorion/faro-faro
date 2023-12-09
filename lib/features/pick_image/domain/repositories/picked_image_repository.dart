import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/entities/picked_image.dart';

import '../../../../core/errors/failures.dart';

abstract class PickedImageRepository {
  // sélectionne une image depuis la Gallerie
  Future<Either<Failure, PickedImage?>> pickImageFromGalery();
}
