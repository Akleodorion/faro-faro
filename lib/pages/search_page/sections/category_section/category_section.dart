// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/internal_features/category_filter/category_filter_provider.dart';
import 'package:faro_faro/internal_features/category_filter/data_source.dart';

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
                        : Theme.of(context).colorScheme.tertiary,
                    foregroundColor: filterMap[category] == true
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onTertiary,
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
