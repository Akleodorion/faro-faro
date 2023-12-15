import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/date_and_locality.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_price_info.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_title.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/event.dart';
import 'components/event_card_image_container.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.listViewHeight,
  });
  final Event event;
  final double listViewHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[3]),
      width: MediaQuery.of(context).size.width * 0.45,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.07,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventCardImageContainer(
              imageUrl: event.imageUrl,
              height: listViewHeight * 0.51,
            ),
            const SizedBox(
              height: 10,
            ),
            EventCardTitle(
              title: event.name,
            ),
            DateAndLocality(
              formatedDate: event.formatedDate,
              formatedAddress: event.address.getShortFormattedAddress(),
            ),
            const SizedBox(
              height: 10,
            ),
            EventCardPriceInfo(event: event)
          ],
        ),
      ),
    );
  }
}
