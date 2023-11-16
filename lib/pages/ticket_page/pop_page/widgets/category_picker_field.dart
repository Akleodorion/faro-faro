import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/internal_features/category_filter/data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/events/presentation/providers/post_event/post_event_provider.dart';
import '../../../../features/events/presentation/providers/post_event/state/post_event_state.dart';

class CategoryPickerField extends ConsumerStatefulWidget {
  const CategoryPickerField({super.key});

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
    final state = ref.watch(postEventProvider);

    if (state is Initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pickedValue = state.infoMap["category"];
      });
    }
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
            ref.read(postEventProvider.notifier).updateKey('category', value);
          },
          onSaved: (value) {
            ref.read(postEventProvider.notifier).updateKey('category', value);
          },
        ),
      ),
    );
  }
}
