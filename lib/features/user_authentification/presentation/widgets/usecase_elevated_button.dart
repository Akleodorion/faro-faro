import 'package:flutter/material.dart';

class UsecaseElevatedButton extends StatelessWidget {
  const UsecaseElevatedButton(
      {super.key, required this.usecaseTitle, required this.onUsecaseCall});

  final String usecaseTitle;
  final void Function() onUsecaseCall;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onUsecaseCall,
      child: Text(usecaseTitle),
    );
  }
}
