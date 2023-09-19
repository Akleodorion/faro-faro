import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/search_and_filter_section/widgets/event_list_search_bar/components/event_list_search_bar_icon.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/search_and_filter_section/widgets/event_list_search_bar/components/search_bar_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListSearchBar extends ConsumerStatefulWidget {
  const EventListSearchBar({super.key});

  @override
  ConsumerState<EventListSearchBar> createState() => _EventListSearchBarState();
}

class _EventListSearchBarState extends ConsumerState<EventListSearchBar> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    String? enteredSearchString;
    final formKey = GlobalKey<FormState>();

    void searchEvent() {
      // Validation du contenu de la recherche
      formKey.currentState!.save();
      // Appel de la fonction de filtrage avec comme paramètre le contenu de la recherche
      ref
          .read(eventProvider.notifier)
          .searchEvent(enteredSearchString!, ref.read(eventProvider));
    }

    return Container(
      height: screenHeight * 0.06,
      width: screenWidth * 0.65,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: kElevationToShadow[3]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              EventListSearchBarTextField(
                onSaved: (value) {
                  setState(() {
                    enteredSearchString = value;
                  });
                },
              ),
              EventListSearchBarIcon(
                onTap: searchEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
