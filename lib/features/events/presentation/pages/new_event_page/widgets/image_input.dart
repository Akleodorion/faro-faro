import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/permission_handler.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/picked_image_provider.dart';
import 'package:faro_clean_tdd/features/pick_image/presentation/providers/state/picked_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageInput extends ConsumerStatefulWidget {
  const ImageInput({
    super.key,
  });

  @override
  ConsumerState<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends ConsumerState<ImageInput> {
  @override
  Widget build(BuildContext context) {
    final pickedImageState = ref.watch(imageProvider);
    late Widget content;

    if (pickedImageState is Initial) {
      content = TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('Add a picture'),
        onPressed: () async {
          await _pickImage(context);
        },
      );
    }
    if (pickedImageState is Loading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (pickedImageState is Loaded) {
      content = Image.file(
        pickedImageState.pickedImage.image,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 1, color: Theme.of(context).colorScheme.primary),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: InkWell(
          onTap: () async {
            await _pickImage(context);
          },
          child: content),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      await PermissionHandlerImp(
              context: context, permissionEnum: PermissionEnum.photos)
          .requestPermission();
      await ref.read(imageProvider.notifier).pickImageFromGalery();
    } on UtilException {
      if (context.mounted) {
        await PermissionHandlerImp(
                context: context, permissionEnum: PermissionEnum.photos)
            .showPermissionErrorDialog();
      }
    }
  }
}
