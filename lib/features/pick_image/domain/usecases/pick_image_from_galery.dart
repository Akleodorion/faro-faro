// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/pick_image/domain/entities/picked_image.dart';
import 'package:faro_faro/features/pick_image/domain/repositories/picked_image_repository.dart';

class PickImageFromGalery {
  PickImageFromGalery({required this.repository});

  final PickedImageRepository repository;

  Future<Either<Failure, PickedImage?>> call() async {
    return await repository.pickImageFromGalery();
  }
}
