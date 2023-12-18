import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/constants/event_widgets_strings.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_button.dart';
import 'package:flutter/material.dart';

class EventCardPriceInfo extends StatelessWidget {
  const EventCardPriceInfo({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final bool isFree = event.modelEco == ModelEco.gratuit;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isFree)
          Text(
            EventWidgetsStrings.free,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (!isFree)
          Column(
            children: [
              Text(
                EventWidgetsStrings.startAt,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${event.standardTicketPrice} XOF",
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
