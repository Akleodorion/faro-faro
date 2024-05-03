import 'package:faro_clean_tdd/features/events/presentation/pages/new_event_page/new_event_page.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const NewEventPage();
            },
          ),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
