// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/internal_features/general_filter/general_filter_provider.dart';

class DatePickerFilter extends ConsumerStatefulWidget {
  const DatePickerFilter({super.key});

  @override
  ConsumerState<DatePickerFilter> createState() => _DatePickerFilterState();
}

class _DatePickerFilterState extends ConsumerState<DatePickerFilter> {
  @override
  Widget build(BuildContext context) {
    final pickedDate = ref.watch(generalFiltersProvider)[GeneralFilter.date];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("A partir du : ${formated.format(pickedDate)}",
            style: Theme.of(context).textTheme.bodyLarge),
        IconButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate:
                    DateTime.now().copyWith(year: DateTime.now().year + 1));
            if (pickedDate != null) {
              ref
                  .read(generalFiltersProvider.notifier)
                  .setFilter(GeneralFilter.date, pickedDate);
            }
          },
          icon: const Icon(
            Icons.calendar_month_outlined,
          ),
        )
      ],
    );
  }
}
