import 'package:flutter/material.dart';

import '../../../../features/events/domain/entities/event.dart';

class TicketTileImageContainer extends StatelessWidget {
  const TicketTileImageContainer({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 40) * 0.33,
      width: (MediaQuery.of(context).size.width - 40) * 0.33,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(event.imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
