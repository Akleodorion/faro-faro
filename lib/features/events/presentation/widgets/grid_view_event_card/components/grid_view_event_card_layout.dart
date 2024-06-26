// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/widgets/event_card/components/date_and_locality.dart';
import 'package:faro_faro/features/events/presentation/widgets/event_card/components/event_card_price_info.dart';
import 'package:faro_faro/features/events/presentation/widgets/event_card/components/event_card_title.dart';
import 'package:faro_faro/features/events/presentation/widgets/grid_view_event_card/components/event_card_image_container.dart';

class GridViewEventCardLayout extends StatelessWidget {
  const GridViewEventCardLayout({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventCardImageContainer(
          imageUrl: event.imageUrl,
        ),
        const SizedBox(height: 10),
        EventCardTitle(
          title: event.name,
        ),
        const SizedBox(height: 5),
        DateAndLocality(
          formatedDate: event.formatedDate,
          formatedAddress:
              event.address.getLocalityIfPresentElseReturnCountry(),
        ),
        const SizedBox(height: 10),
        EventCardPriceInfo(
          event: event,
        ),
      ],
    );
  }
}
