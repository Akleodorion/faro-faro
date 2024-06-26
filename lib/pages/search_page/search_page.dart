// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/pages/search_page/sections/category_section/category_section.dart';
import 'package:faro_faro/pages/search_page/sections/event_list_section/event_list_section.dart';
import 'package:faro_faro/pages/search_page/sections/search_and_filter_section/search_and_filter_section.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            SearchAndFilterSection(),
            CategorySection(),
            EventListSection(),
          ],
        ),
      ),
    );
  }
}
