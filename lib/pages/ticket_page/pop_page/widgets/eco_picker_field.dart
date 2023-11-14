import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

class EcoPickerField extends StatefulWidget {
  const EcoPickerField({super.key, required this.onSave});
  final void Function(ModelEco) onSave;

  @override
  State<EcoPickerField> createState() => _EcoPickerFieldState();
}

class _EcoPickerFieldState extends State<EcoPickerField> {
  ModelEco pickedValue = ModelEco.gratuit;
  @override
  Widget build(BuildContext context) {
    const double minHeight = 70.0;
    final double mediaWidth = MediaQuery.of(context).size.width;

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
            pickedValue = value!;
          },
          onSaved: (value) {
            widget.onSave(value!);
          },
        ),
      ),
    );
  }
}
