import 'package:flutter/material.dart';

class DescriptionTextFormField extends StatefulWidget {
  const DescriptionTextFormField(
      {super.key,
      required this.initialValue,
      required this.onSave,
      required this.isTicket});

  final String initialValue;
  final bool isTicket;
  final void Function(String value) onSave;

  @override
  State<DescriptionTextFormField> createState() =>
      _DescriptionTextFormFieldState();
}

class _DescriptionTextFormFieldState extends State<DescriptionTextFormField> {
  bool hasError = false;
  int maxCharsValue = 151;
  int minCharsValue = 20;

  double minHeight = 130.0; // Taille minimale
  double maxHeight = 150.0; // Taille maximale en cas d'erreur

  @override
  Widget build(BuildContext context) {
    if (widget.isTicket == false) {
      minHeight = 180;
      maxHeight = 200;
      maxCharsValue = 601;
    }
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
          maxLines: widget.isTicket == true ? 3 : 5,
          maxLength: maxCharsValue,
          initialValue: widget.initialValue,
          decoration: const InputDecoration(
            label: Text(
              "Description des prestations du ticket :",
              style: TextStyle(fontSize: 14),
            ),
          ),
          keyboardType: TextInputType.name,
          validator: (value) {
            setState(() {
              hasError = false;
            });

            if (value!.trim().length <= minCharsValue) {
              setState(() {
                hasError = true;
              });
              return 'La description doit avoir un minimum de $minCharsValue caractères';
            }

            if (value.trim().length >= maxCharsValue) {
              hasError = true;
              return 'La description doit avoir un maximum de $maxCharsValue caractères';
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
