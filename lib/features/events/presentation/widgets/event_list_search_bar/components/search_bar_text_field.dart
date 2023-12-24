import 'package:flutter/material.dart';

class SearchBarTextField extends StatelessWidget {
  const SearchBarTextField({
    super.key,
    required this.searchBarWidth,
    required this.textEditingController,
  });

  final double searchBarWidth;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: searchBarWidth,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: TextFormField(
          controller: textEditingController,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
              hintText: "Recherchez un évènement",
              hintStyle: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
