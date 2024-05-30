// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/pick_image/data/datasources/picked_image_local_data_source.dart';
import 'package:faro_faro/features/pick_image/data/models/picked_image_model.dart';
import 'package:faro_faro/features/pick_image/domain/repositories/picked_image_repository.dart';

class PickedImageRepositoryImpl implements PickedImageRepository {
  final PickedImageLocalDataSource repository;

  PickedImageRepositoryImpl({required this.repository});
  @override
  Future<Either<Failure, PickedImageModel?>> pickImageFromGalery() async {
    try {
      final response = await repository.pickImageFromGallery();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(errorMessage: error.errorMessage));
    }
  }
}
