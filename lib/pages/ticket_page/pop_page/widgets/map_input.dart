import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_state.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../features/address/presentation/providers/address_provider.dart';
import '../map_page.dart';

class MapInput extends ConsumerStatefulWidget {
  const MapInput({super.key});

  @override
  ConsumerState<MapInput> createState() => _MapInputState();
}

class _MapInputState extends ConsumerState<MapInput> {
  Widget locationContent = const Center(child: Text("No place choosen"));
  @override
  Widget build(BuildContext context) {
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
                final state = await ref
                    .read(addressProvider.notifier)
                    .getCurrentLocationAddress();
                if (state is Loaded) {
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('address', state.address.addressName);
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('latitude', state.address.latitude);
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('longitude', state.address.longitude);
                }
              },
              icon: const Icon(Icons.pin_drop),
              label: const Text("Current position"),
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
                final state = await ref
                    .read(addressProvider.notifier)
                    .getSelectedLociationAddress(
                        pickedLocation.latitude, pickedLocation.longitude);

                if (state is Loaded) {
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('address', state.address.addressName);
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('latitude', state.address.latitude);
                  ref
                      .read(postEventProvider.notifier)
                      .updateKey('longitude', state.address.longitude);
                }
              },
              icon: const Icon(Icons.map),
              label: const Text("Select on map"),
            )
          ],
        ),
      ],
    );
  }
}
