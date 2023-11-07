import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class PickedImageRepository {
  // sélectionne une image depuis la Gallerie
  Future<Either<Failure, File?>?> pickImageFromGalery();
}
