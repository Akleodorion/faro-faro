import 'package:flutter/material.dart';

class SearchBarTextField extends StatelessWidget {
  const SearchBarTextField({
    super.key,
    required this.screenWidth,
    required this.textEditingController,
  });

  final double screenWidth;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.45,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: "Recherchez un évènement",
          ),
        ),
      ),
    );
  }
}
