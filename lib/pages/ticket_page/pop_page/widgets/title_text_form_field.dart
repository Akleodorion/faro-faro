import 'package:flutter/material.dart';

class TitleTextFormField extends StatefulWidget {
  const TitleTextFormField(
      {super.key, required this.initialValue, required this.onSave});

  final String initialValue;
  final void Function(String value) onSave;

  @override
  State<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends State<TitleTextFormField> {
  bool hasError = false;
  double minHeight = 70.0; // Taille minimale
  double maxHeight = 90.0; // Taille maximale en cas d'erreur

  @override
  Widget build(BuildContext context) {
    // final double mediaHeight = MediaQuery.of(context).size.height;
    final double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      width: (mediaWidth - 40),
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          initialValue: widget.initialValue,
          decoration: const InputDecoration(
            label: Text(
              "Nom de l'évènement :",
              style: TextStyle(fontSize: 12),
            ),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            setState(() {
              hasError = false;
            });

            if (value!.trim().length <= 10) {
              setState(() {
                hasError = true;
              });
              return 'Le titre doit avoir un minimum de 10 caractères';
            }
            if (value.trim().length >= 50) {
              hasError = true;
              return 'Le titre doit avoir un maximum de 50 caractères';
            }
            return null;
          },
          onSaved: (value) {
            widget.onSave(value!);
          },
        ),
      ),
    );
  }
}
