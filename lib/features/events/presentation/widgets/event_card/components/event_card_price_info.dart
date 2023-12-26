import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/constants/event_widgets_strings.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_button.dart';
import 'package:flutter/material.dart';

class EventCardPriceInfo extends StatelessWidget {
  const EventCardPriceInfo({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              EventWidgetsStrings.startAt,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              event.isFree
                  ? EventWidgetsStrings.free
                  : "${event.standardTicketPrice} XOF",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        EventCardButton(
          event: event,
        ),
      ],
    );
  }
}
