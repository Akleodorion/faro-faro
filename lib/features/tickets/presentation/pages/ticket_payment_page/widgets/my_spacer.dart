// Flutter imports:
import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  const MySpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Divider(
          thickness: 0.1,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
