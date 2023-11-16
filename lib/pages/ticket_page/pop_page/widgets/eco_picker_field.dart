import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/events/presentation/providers/post_event/state/post_event_state.dart';

class EcoPickerField extends ConsumerStatefulWidget {
  const EcoPickerField({super.key});

  @override
  ConsumerState<EcoPickerField> createState() => _EcoPickerFieldState();
}

class _EcoPickerFieldState extends ConsumerState<EcoPickerField> {
  ModelEco pickedValue = ModelEco.gratuit;

  @override
  Widget build(BuildContext context) {
    const double minHeight = 70.0;
    final double mediaWidth = MediaQuery.of(context).size.width;
    final state = ref.watch(postEventProvider);

    if (state is Initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pickedValue = state.infoMap["modelEco"];
      });
    }

    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      width: (mediaWidth - 40) * 0.3,
      height: minHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              label: Text(
            'Model Eco',
            style: TextStyle(fontSize: 12),
          )),
          value: pickedValue,
          items: [
            DropdownMenuItem(
              value: ModelEco.gratuit,
              child: Text(
                ModelEco.gratuit.name,
              ),
            ),
            DropdownMenuItem(
              value: ModelEco.payant,
              child: Text(
                ModelEco.payant.name,
              ),
            )
          ],
          onChanged: (value) {
            ref.read(postEventProvider.notifier).updateKey('modelEco', value);
          },
          onSaved: (value) {
            ref.read(postEventProvider.notifier).updateKey('modelEco', value);
          },
        ),
      ),
    );
  }
}
