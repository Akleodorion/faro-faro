// Flutter imports:
import 'package:flutter/material.dart';

class BackNavigator extends StatelessWidget {
  const BackNavigator({
    super.key,
    required this.mediaHeight,
  });

  final double mediaHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: mediaHeight * 0.05,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
