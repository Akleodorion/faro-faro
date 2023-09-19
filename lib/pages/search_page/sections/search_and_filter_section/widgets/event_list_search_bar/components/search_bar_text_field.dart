import 'package:flutter/material.dart';

class EventListSearchBarTextField extends StatelessWidget {
  const EventListSearchBarTextField({super.key, required this.onSaved});
  final void Function(String text) onSaved;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.45,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          initialValue: '',
          onSaved: (value) {
            onSaved(value!);
          },
          decoration: const InputDecoration(
            hintText: "Recherchez un évènement",
          ),
        ),
      ),
    );
  }
}
