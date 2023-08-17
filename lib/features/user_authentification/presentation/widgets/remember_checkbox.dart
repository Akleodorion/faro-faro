import 'package:flutter/material.dart';

class RememberCheckbox extends StatelessWidget {
  const RememberCheckbox(
      {super.key, required this.isChecked, required this.onSwitch});
  final bool isChecked;
  final void Function(bool value) onSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (value) {
              onSwitch(value!);
            }),
        const SizedBox(width: 20),
        const Text(
          'Remember me ?',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
