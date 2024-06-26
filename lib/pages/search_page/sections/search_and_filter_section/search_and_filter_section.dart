// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/widgets/event_list_search_bar/event_list_search_bar.dart';
import 'package:faro_faro/pages/search_page/pop_page/general_filter_page.dart';

class SearchAndFilterSection extends StatelessWidget {
  const SearchAndFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const EventListSearchBar(),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                builder: (context) => const GeneralFilterPage());
          },
          icon: const Icon(
            Icons.filter_list_alt,
          ),
        )
      ],
    );
  }
}
