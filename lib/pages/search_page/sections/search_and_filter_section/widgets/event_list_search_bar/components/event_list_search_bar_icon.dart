import 'package:flutter/material.dart';

class EventListSearchBarIcon extends StatelessWidget {
  const EventListSearchBarIcon({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        Icons.search,
        size: 40,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
