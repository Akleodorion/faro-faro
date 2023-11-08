import 'package:faro_clean_tdd/features/pick_image/domain/usecases/pick_image_from_galery.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_notifier.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection_container.dart';

final pickedImageProvider =
    StateNotifierProvider<PickedImageNotifier, PickedImageState>((ref) {
  final PickImageFromGalery pickImageFromGalery = sl<PickImageFromGalery>();

  return PickedImageNotifier(pickImageFromGaleryUsecase: pickImageFromGalery);
});
