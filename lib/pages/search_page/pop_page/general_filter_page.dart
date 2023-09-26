import 'package:faro_clean_tdd/internal_features/general_filter/general_filter_provider.dart';
import 'package:faro_clean_tdd/pages/search_page/pop_page/widgets/date_picker_filter.dart';
import 'package:faro_clean_tdd/pages/search_page/pop_page/widgets/text_switch.dart';
import 'package:flutter/material.dart';

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
            'Filtres',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          const TextSwitch(
            switchText: 'Voir les évènements gratuits :',
            generalFilter: GeneralFilter.free,
          ),
          const TextSwitch(
            switchText: 'Voir les évènements payants :',
            generalFilter: GeneralFilter.paid,
          ),
          const DatePickerFilter(),
        ],
      ),
    );
  }
}
