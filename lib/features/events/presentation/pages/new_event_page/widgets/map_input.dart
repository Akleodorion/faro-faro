import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/permission_handler.dart';
import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../address/presentation/providers/address_provider.dart';
import '../../../../../../pages/ticket_page/pop_page/map_page.dart';

class MapInput extends ConsumerStatefulWidget {
  const MapInput({super.key});

  @override
  ConsumerState<MapInput> createState() => _MapInputState();
}

class _MapInputState extends ConsumerState<MapInput> {
  @override
  Widget build(BuildContext context) {
    Widget locationContent = Center(
        child: Text(
      "Aucun lieu sélectionné",
      style: Theme.of(context).textTheme.bodyLarge,
    ));
    final addressState = ref.watch(addressProvider);

    if (addressState is Loading) {
      locationContent = const Center(child: CircularProgressIndicator());
    }
    if (addressState is Loaded) {
      locationContent = Image.network(
        addressState.address.geocodeUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.primary),
          ),
          child: locationContent,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  await PermissionHandlerImp(
                    context: context,
                    permissionEnum: PermissionEnum.location,
                  ).requestPermission();

                  await ref
                      .read(addressProvider.notifier)
                      .getCurrentLocationAddress();
                } on UtilException {
                  if (context.mounted) {
                    PermissionHandlerImp(
                      context: context,
                      permissionEnum: PermissionEnum.location,
                    ).showPermissionErrorDialog();
                  }
                }
              },
              icon: const Icon(Icons.pin_drop),
              label: const Text("Localisation"),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final pickedLocation = await Navigator.of(context)
                    .push<LatLng>(MaterialPageRoute(builder: (ctx) {
                  return const MapScreen();
                }));
                if (pickedLocation == null) {
                  return;
                }
                await ref
                    .read(addressProvider.notifier)
                    .getSelectedLociationAddress(
                        pickedLocation.latitude, pickedLocation.longitude);
              },
              icon: const Icon(Icons.map),
              label: const Text("Carte"),
            )
          ],
        ),
      ],
    );
  }
}
