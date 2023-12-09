import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/failures.dart';

class PickedImageNotifier extends StateNotifier<PickedImageState> {
  PickedImageNotifier({required this.pickImageFromGaleryUsecase})
      : super(Initial());

  final PickImageFromGalery pickImageFromGaleryUsecase;

  PickedImageState get initialState => Initial();

  Future<PickedImageState> pickImageFromGalery() async {
    state = Loading();
    final response = await pickImageFromGaleryUsecase.call();

    response.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (pickedImage) {
      final isImagedPicked = pickedImage == null;
      if (!isImagedPicked) {
        state = Loaded(
            pickedImage: pickedImage,
            message: "L'image a été ajoutée avec succès!");
      } else {
        state = Initial();
      }
    });
    return state;
  }
}
