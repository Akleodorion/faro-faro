import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitleTextFormField extends ConsumerStatefulWidget {
  const TitleTextFormField({super.key, required this.setValue});

  final void Function(String value) setValue;

  @override
  ConsumerState<TitleTextFormField> createState() => _TitleTextFormFieldState();
}

class _TitleTextFormFieldState extends ConsumerState<TitleTextFormField> {
  bool hasError = false;

  TextEditingController titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  double minHeight = 70.0;
  double maxHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;

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
          controller: titleController,
          focusNode: _titleFocusNode,
          keyboardType: TextInputType.name,

          // validation
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
            titleController.text = value!;
            widget.setValue(value);
          },
        ),
      ),
    );
  }
}
