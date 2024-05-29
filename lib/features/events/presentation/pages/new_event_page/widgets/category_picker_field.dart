import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/internal_features/category_filter/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPickerField extends ConsumerStatefulWidget {
  const CategoryPickerField({super.key, required this.setValue});
  final void Function(Category) setValue;
  @override
  ConsumerState<CategoryPickerField> createState() =>
      _CategoryPickerFieldState();
}

class _CategoryPickerFieldState extends ConsumerState<CategoryPickerField> {
  Category pickedValue = Category.concert;
  final double minHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
      width: (mediaWidth - 40) * 0.4,
      height: minHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
              label: Text(
            'Categorie',
            style: Theme.of(context).textTheme.bodyLarge,
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
          onChanged: (value) {},
          onSaved: (value) {
            widget.setValue(value!);
          },
        ),
      ),
    );
  }
}
