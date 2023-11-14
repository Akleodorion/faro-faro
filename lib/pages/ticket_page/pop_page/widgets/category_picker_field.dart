import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/internal_features/category_filter/data_source.dart';
import 'package:flutter/material.dart';

class CategoryPickerField extends StatefulWidget {
  const CategoryPickerField({super.key, required this.onSave});

  final void Function(Category) onSave;

  @override
  State<CategoryPickerField> createState() => _CategoryPickerFieldState();
}

class _CategoryPickerFieldState extends State<CategoryPickerField> {
  Category pickedValue = Category.concert;

  @override
  Widget build(BuildContext context) {
    const double minHeight = 70.0;

    final double mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      width: (mediaWidth - 40) * 0.3,
      height: minHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
              label: Text(
            'Categorie',
            style: TextStyle(fontSize: 12),
          )),
          value: pickedValue,
          items: [
            for (var category in CATEGORIES)
              DropdownMenuItem(
                value: category,
                child: Text(
                  category.name,
                ),
              )
          ],
          onChanged: (value) {
            pickedValue = value!;
          },
          onSaved: (value) {
            widget.onSave(value!);
          },
        ),
      ),
    );
  }
}
