import 'package:faro_clean_tdd/core/util/validate_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescriptionTextFormField extends ConsumerStatefulWidget {
  const DescriptionTextFormField({
    super.key,
    required this.isTicket,
    required this.mapKey,
    required this.setValue,
  });

  final bool isTicket;
  final String mapKey;
  final void Function(String? value) setValue;

  @override
  ConsumerState<DescriptionTextFormField> createState() =>
      _DescriptionTextFormFieldState();
}

class _DescriptionTextFormFieldState
    extends ConsumerState<DescriptionTextFormField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool hasError = false;
  double minHeight = 180;
  double maxHeight = 200;
  int maxCharsValue = 600;
  int minCharsValue = 50;

  @override
  Widget build(BuildContext context) {
    if (widget.isTicket == true) {
      minCharsValue = 20;
      maxCharsValue = 151;
      minHeight = 130;
      maxHeight = 150;
    }
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
          decoration: InputDecoration(
            label: Text(
              widget.isTicket == true
                  ? "Description des prestations du ticket :"
                  : "Description de l'évènement :",
              style: const TextStyle(fontSize: 14),
            ),
          ),
          keyboardType: TextInputType.name,
          controller: textEditingController,
          validator: (value) {
            setState(() => hasError = false);
            final result = ValidateInputImpl().eventDescriptionValidator(value);
            result != null ? setState(() => hasError = true) : null;
            return result;
          },
          onSaved: (value) {
            textEditingController.text = value!;
            widget.setValue(value);
          },
        ),
      ),
    );
  }
}
