import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/my_ticket_page/sections/image_section/widgets/back_navigator.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/my_ticket_page/sections/image_section/widgets/image_container.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/my_ticket_page/sections/image_section/widgets/opacity_filter.dart';
import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.mediaHeight,
    required this.event,
  });

  final double mediaHeight;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageContainer(mediaHeight: mediaHeight, event: event),
        OpacityFilter(mediaHeight: mediaHeight),
        BackNavigator(mediaHeight: mediaHeight)
      ],
    );
  }
}
