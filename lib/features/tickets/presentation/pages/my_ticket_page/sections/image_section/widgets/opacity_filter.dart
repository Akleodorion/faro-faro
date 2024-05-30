// Flutter imports:
import 'package:flutter/material.dart';

class OpacityFilter extends StatelessWidget {
  const OpacityFilter({
    super.key,
    required this.mediaHeight,
  });

  final double mediaHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: mediaHeight * 0.40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.4),
          ],
        ),
      ),
    );
  }
}
