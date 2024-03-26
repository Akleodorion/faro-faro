import 'package:flutter/material.dart';

class UsecaseElevatedButton extends StatelessWidget {
  const UsecaseElevatedButton(
      {super.key,
      required this.usecaseTitle,
      required this.onUsecaseCall,
      required this.isLoading});

  final String usecaseTitle;
  final bool isLoading;
  final void Function() onUsecaseCall;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              onUsecaseCall();
            },
      child: Text(
        usecaseTitle,
      ),
    );
  }
}
