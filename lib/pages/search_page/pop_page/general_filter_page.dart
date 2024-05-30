// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/internal_features/general_filter/general_filter_provider.dart';
import 'package:faro_faro/internal_features/general_filter/widgets/date_picker_filter.dart';
import 'package:faro_faro/internal_features/general_filter/widgets/text_switch.dart';
import 'package:faro_faro/pages/search_page/constants/search_page_strings.dart';

class GeneralFilterPage extends StatelessWidget {
  const GeneralFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            SearchPageStrings.filters,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const TextSwitch(
            switchText: SearchPageStrings.freeEvents,
            generalFilter: GeneralFilter.free,
          ),
          const TextSwitch(
            switchText: SearchPageStrings.paidEvents,
            generalFilter: GeneralFilter.paid,
          ),
          const DatePickerFilter(),
        ],
      ),
    );
  }
}
