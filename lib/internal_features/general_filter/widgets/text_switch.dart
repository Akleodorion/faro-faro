import 'package:faro_clean_tdd/internal_features/general_filter/general_filter_provider.dart';
import 'package:faro_clean_tdd/internal_features/general_filter/widgets/slider_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSwitch extends ConsumerStatefulWidget {
  const TextSwitch(
      {super.key, required this.switchText, required this.generalFilter});

  final String switchText;
  final GeneralFilter generalFilter;

  @override
  ConsumerState<TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends ConsumerState<TextSwitch> {
  late bool switchValue;
  late bool paidCondition;

  @override
  Widget build(BuildContext context) {
    final bool isFilterFree = widget.generalFilter == GeneralFilter.free;
    final bool isFilterPaid = widget.generalFilter == GeneralFilter.paid;

    if (isFilterFree) {
      switchValue = ref.watch(generalFiltersProvider)[GeneralFilter.free];
    }
    if (isFilterPaid) {
      switchValue = ref.watch(generalFiltersProvider)[GeneralFilter.paid];
    }
    final bool paidCondition = isFilterPaid && switchValue == true;

    return Column(
      children: [
        Row(
          children: [
            Text(widget.switchText,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              width: 15,
            ),
            Switch(
                value: switchValue,
                onChanged: (value) {
                  ref
                      .read(generalFiltersProvider.notifier)
                      .setFilter(widget.generalFilter, value);
                })
          ],
        ),
        if (paidCondition) const SliderFilter(),
      ],
    );
  }
}
