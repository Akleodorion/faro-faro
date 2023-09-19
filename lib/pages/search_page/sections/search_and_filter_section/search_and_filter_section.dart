import 'package:faro_clean_tdd/pages/search_page/sections/search_and_filter_section/widgets/event_list_search_bar/event_list_search_bar.dart';
import 'package:flutter/material.dart';

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
          onPressed: () {},
          icon: const Icon(
            Icons.filter_list_alt,
            size: 40,
          ),
        )
      ],
    );
  }
}
