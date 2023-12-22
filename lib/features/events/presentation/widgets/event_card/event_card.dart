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
    final double eventCardWidth = getCardWidth(context);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[3]),
      width: eventCardWidth,
      margin: const EdgeInsets.only(
        right: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EventCardImageContainer(
              imageUrl: event.imageUrl,
              height: listViewHeight * 0.45,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventCardTitle(
                  title: event.name,
                ),
                const SizedBox(
                  height: 3,
                ),
                DateAndLocality(
                  formatedDate: event.formatedDate,
                  formatedAddress:
                      event.address.getLocalityIfPresentElseReturnCountry(),
                ),
              ],
            ),
            EventCardPriceInfo(event: event)
          ],
        ),
      ),
    );
  }

  double getCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool screenWidthIsMini = screenWidth < 350;
    final bool screenWidthIsStandard = screenWidth >= 350 && screenWidth <= 400;
    final bool screenWidthIsLarge = screenWidth > 400;

    if (screenWidthIsMini) {
      return 170;
    }
    if (screenWidthIsStandard) {
      return 190;
    }
    if (screenWidthIsLarge) {
      return 210;
    }
    return 0;
  }
}
