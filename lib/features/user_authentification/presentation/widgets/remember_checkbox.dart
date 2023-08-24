import 'package:faro_clean_tdd/main.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RememberCheckbox extends StatefulWidget {
  RememberCheckbox({super.key, required this.isChecked});
  bool isChecked;

  @override
  State<RememberCheckbox> createState() => _RememberCheckboxState();
}

class _RememberCheckboxState extends State<RememberCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: widget.isChecked,
            onChanged: (value) {
              setState(() {
                widget.isChecked = value!;
              });
            }),
        const SizedBox(width: 10),
        Text(
          'Se souvenir de moi ?',
          style: TextStyle(color: theme.colorScheme.secondary, fontSize: 12),
        )
      ],
    );
  }
}
