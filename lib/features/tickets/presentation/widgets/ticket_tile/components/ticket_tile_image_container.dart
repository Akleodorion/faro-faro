import 'package:flutter/material.dart';

class TicketTileImageContainer extends StatelessWidget {
  const TicketTileImageContainer({super.key, required this.eventUrl});

  final String eventUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40) * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(eventUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
