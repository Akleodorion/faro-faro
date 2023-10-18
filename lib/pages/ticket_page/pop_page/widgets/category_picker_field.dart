import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/internal_features/category_filter/data_source.dart';
import 'package:flutter/material.dart';

class CategoryPickerField extends StatelessWidget {
  const CategoryPickerField(
      {super.key, required this.initialValue, required this.setValue});

  final Category initialValue;
  final void Function(Category) setValue;

  final double minHeight = 70.0;

  @override
  Widget build(BuildContext context) {
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
            value: initialValue,
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
              setValue(value!);
            }),
      ),
    );
  }
}
