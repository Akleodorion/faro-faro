import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.mediaHeight,
    required this.event,
  });

  final double mediaHeight;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: mediaHeight * 0.40,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(event.imageUrl),
        ),
      ),
    );
  }
}
