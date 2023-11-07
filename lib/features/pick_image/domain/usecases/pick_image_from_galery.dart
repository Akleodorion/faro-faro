import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/pick_image/domain/repositories/picked_image_repository.dart';

class PickImageFromGalery {
  PickImageFromGalery({required this.repository});

  final PickedImageRepository repository;

  Future<Either<Failure, File?>?> call() async {
    return await repository.pickImageFromGalery();
  }
}
