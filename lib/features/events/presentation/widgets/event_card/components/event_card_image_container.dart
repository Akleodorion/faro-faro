import 'package:flutter/material.dart';

class EventCardImageContainer extends StatelessWidget {
  const EventCardImageContainer({
    super.key,
    required this.imageUrl,
    required this.height,
  });
  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
