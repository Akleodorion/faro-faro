import 'package:flutter/material.dart';

class ListViewRedirect extends StatelessWidget {
  const ListViewRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: Theme.of(context).textButtonTheme.style,
        onPressed: () {},
        child: const Text(
          "See all",
        ));
  }
}
