import 'package:faro_clean_tdd/internal_features/category_filter/data_source.dart';
import 'package:faro_clean_tdd/internal_features/category_filter/category_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterMap = ref.watch(filtersProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var category in CATEGORIES)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: filterMap[category] == true
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background,
                    foregroundColor: filterMap[category] == true
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: () {
                    ref.read(filtersProvider.notifier).setFilter(category);
                  },
                  child: Text(
                    category.name,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
