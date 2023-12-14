import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.mediaHeight,
    required this.eventImageUrl,
  });

  final double mediaHeight;
  final String eventImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: mediaHeight * 0.40,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(eventImageUrl),
        ),
      ),
    );
  }
}
