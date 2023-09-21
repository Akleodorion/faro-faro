import 'package:faro_clean_tdd/features/category_filter/data/datasources/filter_local_data_source.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/filter_provider.dart';
import 'package:faro_clean_tdd/features/category_filter/presentation/providers/state/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    late Widget content;

    if (filterState is Loaded) {
      content = Padding(
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
                      backgroundColor: filterState.filters[category] == true
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.background,
                      foregroundColor: filterState.filters[category] == true
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                    onPressed: () {
                      ref.read(filterProvider.notifier).toggleFilter(
                          category.index, ref.read(filterProvider));
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

    return content;
  }
}
