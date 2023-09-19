import 'package:faro_clean_tdd/pages/search_page/sections/event_list_section/event_list_section.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/search_and_filter_section/search_and_filter_section.dart';

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: [
            SearchAndFilterSection(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("Evènements disponibles"),
            ),
            EventListSection(),
          ],
        ),
      ),
    );
  }
}
