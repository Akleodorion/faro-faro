import 'package:faro_clean_tdd/internal_features/general_filter/general_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderFilter extends ConsumerStatefulWidget {
  const SliderFilter({super.key});

  @override
  ConsumerState<SliderFilter> createState() => _SliderFilterState();
}

class _SliderFilterState extends ConsumerState<SliderFilter> {
  @override
  Widget build(BuildContext context) {
    final sliderValue =
        ref.watch(generalFiltersProvider)[GeneralFilter.minPrice];

    final double maxPrice = ref.watch(maxPaidEventPrice);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Slider(
        value: sliderValue,
        label: '$sliderValue',
        max: maxPrice,
        divisions: 10,
        min: 0,
        onChanged: (value) {
          ref
              .read(generalFiltersProvider.notifier)
              .setFilter(GeneralFilter.minPrice, value);
          ref.read(maxPaidEventPrice);
        },
      ),
    );
  }
}
