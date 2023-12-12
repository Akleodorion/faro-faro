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
          height: 10,
        ),
        Divider(
          thickness: 0.5,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
