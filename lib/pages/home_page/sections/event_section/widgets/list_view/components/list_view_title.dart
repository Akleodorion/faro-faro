import 'package:flutter/material.dart';

class ListViewTitle extends StatelessWidget {
  const ListViewTitle({super.key, required this.listViewTitle});
  final String listViewTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      listViewTitle,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
