// Flutter imports:
import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  const MySpacer({
    super.key,
    required this.thickness,
  });

  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Divider(thickness: thickness),
        const SizedBox(height: 10),
      ],
    );
  }
}
