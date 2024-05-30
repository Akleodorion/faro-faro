// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/presentation/pages/my_ticket_page/sections/image_section/widgets/back_navigator.dart';
import 'package:faro_faro/features/tickets/presentation/pages/my_ticket_page/sections/image_section/widgets/image_container.dart';
import 'package:faro_faro/features/tickets/presentation/pages/my_ticket_page/sections/image_section/widgets/opacity_filter.dart';
import 'package:faro_faro/features/tickets/presentation/pages/my_ticket_page/sections/image_section/widgets/send_ticket.dart';

class ImageSection extends StatelessWidget {
  const ImageSection(
      {super.key,
      required this.mediaHeight,
      required this.eventImageUrl,
      required this.ticket});

  final double mediaHeight;
  final String eventImageUrl;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageContainer(mediaHeight: mediaHeight, eventImageUrl: eventImageUrl),
        OpacityFilter(mediaHeight: mediaHeight),
        BackNavigator(mediaHeight: mediaHeight),
        SendTicket(
          mediaHeight: mediaHeight,
          ticket: ticket,
        )
      ],
    );
  }
}
