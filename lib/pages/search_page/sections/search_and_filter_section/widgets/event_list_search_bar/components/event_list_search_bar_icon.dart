import 'package:flutter/material.dart';

class EventListSearchBarIcon extends StatelessWidget {
  const EventListSearchBarIcon({
    super.key,
    required this.textEditingController,
    required this.onPressed,
  });

  final TextEditingController textEditingController;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
        textEditingController.clear();
      },
      icon: Icon(
        Icons.search,
        size: 40,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
