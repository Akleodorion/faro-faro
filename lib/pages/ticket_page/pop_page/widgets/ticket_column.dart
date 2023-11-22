import 'package:faro_clean_tdd/features/events/presentation/providers/post_event/post_event_provider.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/widgets/ticket_input_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/events/domain/entities/event.dart';

class TicketColumn extends ConsumerWidget {
  const TicketColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFree = false;

    ref.watch(postEventMapProvider)["modelEco"] == ModelEco.gratuit
        ? isFree = true
        : isFree = false;

    return Column(
      children: [
        const TicketInputForm(
          ticketType: "Standard",
        ),
        if (!isFree)
          const TicketInputForm(
            ticketType: "Vip",
          ),
        if (!isFree)
          const TicketInputForm(
            ticketType: "Vvip",
          ),
      ],
    );
  }
}