// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/util/validate_input.dart';

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
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
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
            setState(() => hasError = false);
            final result = ValidateInputImpl().eventTitleValidator(value);
            result != null ? setState(() => hasError = true) : null;
            return result;
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
