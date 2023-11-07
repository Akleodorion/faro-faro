import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key, required this.setEvent});

  final void Function(bool value) setEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  setEvent(false);
                },
                child: const Text("Mes tickets"),
              ),
              TextButton(
                onPressed: () {
                  setEvent(true);
                },
                child: const Text("Mes Evènements"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
