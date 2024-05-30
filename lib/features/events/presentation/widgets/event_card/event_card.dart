// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/widgets/event_card/event_card_class.dart';
import '../../../domain/entities/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  Widget build(BuildContext context) {
    final EventCardClass cardClass = EventCardClass(
      context: context,
      event: event,
    );
    return Container(
      decoration: cardClass.getBoxDecoration(),
      width: cardClass.getCardWidth(),
      margin: cardClass.getCardRightMargin(),
      child: Padding(
        padding: cardClass.getCardPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardClass.getCardImageContainer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardClass.getCardTitle(),
                const SizedBox(
                  height: 3,
                ),
                cardClass.getDateAndLocality(),
              ],
            ),
            cardClass.getPriceInfo()
          ],
        ),
      ),
    );
  }
}
