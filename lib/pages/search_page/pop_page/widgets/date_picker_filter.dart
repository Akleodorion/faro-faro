import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/internal_features/general_filter/general_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onBackground)),
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
            size: 36,
          ),
        )
      ],
    );
  }
}
