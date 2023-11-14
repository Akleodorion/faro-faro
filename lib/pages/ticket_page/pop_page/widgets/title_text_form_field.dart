import 'package:flutter/material.dart';

class TitleTextFormField extends StatefulWidget {
  const TitleTextFormField({super.key, required this.onSave});

  final void Function(String value) onSave;

  @override
  State<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends State<TitleTextFormField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    double minHeight = 70.0;
    double maxHeight = 90.0;

    return Container(
      width: (mediaWidth - 40),
      height: hasError ? maxHeight : minHeight,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
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
