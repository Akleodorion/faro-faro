// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/providers/post_event/post_event_provider.dart';

class EcoPickerField extends ConsumerStatefulWidget {
  const EcoPickerField({super.key, required this.setValue});
  final void Function(ModelEco) setValue;
  @override
  ConsumerState<EcoPickerField> createState() => _EcoPickerFieldState();
}

class _EcoPickerFieldState extends ConsumerState<EcoPickerField> {
  ModelEco pickedValue = ModelEco.gratuit;

  @override
  Widget build(BuildContext context) {
    const double minHeight = 70.0;
    final double mediaWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
      width: (mediaWidth - 40) * 0.4,
      height: minHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              label: Text(
            'Model Eco',
            style: Theme.of(context).textTheme.bodyLarge,
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
            setState(() {
              pickedValue = value!;
            });
            ref.read(postEventProvider.notifier).updateModelEco(value!);
          },
          onSaved: (value) {
            widget.setValue(value!);
          },
        ),
      ),
    );
  }
}
