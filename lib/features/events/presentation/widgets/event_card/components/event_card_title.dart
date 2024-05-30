// Flutter imports:
import 'package:flutter/material.dart';

class EventCardTitle extends StatelessWidget {
  const EventCardTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
