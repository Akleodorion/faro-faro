import 'package:faro_clean_tdd/core/util/size_info.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_list_search_bar/components/search_bar_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/event_list_search_bar_icon.dart';

class EventListSearchBar extends ConsumerStatefulWidget {
  const EventListSearchBar({super.key});

  @override
  ConsumerState<EventListSearchBar> createState() => _EventListSearchBarState();
}

class _EventListSearchBarState extends ConsumerState<EventListSearchBar> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    void searchEvent() {
      formKey.currentState!.save();
      ref.read(fetchEventProvider.notifier).searchEvent(
          textEditingController.text, ref.read(fetchEventProvider));
    }

    final double searchBarContainerHeight =
        getSearchBarContainerHeight(context);
    final double searchBarContainerWidth = getSearchBarContainerWidth(context);

    return Container(
      height: searchBarContainerHeight,
      width: searchBarContainerWidth,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: kElevationToShadow[3]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchBarTextField(
                  searchBarWidth: searchBarContainerWidth * 0.7,
                  textEditingController: textEditingController),
              EventListSearchBarIcon(
                  textEditingController: textEditingController,
                  onPressed: searchEvent),
            ],
          ),
        ),
      ),
    );
  }

  double getSearchBarContainerHeight(context) {
    final bool isScreenMini = SizeInfo(context: context).isScreenSizeMini();
    final bool isScreenStandard =
        SizeInfo(context: context).isScreenSizeStandard();

    if (isScreenMini) {
      return 40;
    }
    if (isScreenStandard) {
      return 50;
    }
    return 60;
  }

  double getSearchBarContainerWidth(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool screenWidthIsMini = screenWidth < 350;
    final bool screenWidthIsStandard = screenWidth >= 350 && screenWidth <= 400;
    final bool screenWidthIsLarge = screenWidth > 400 && screenWidth <= 500;
    final bool screenWidthIsXLarge = screenWidth > 500;

    if (screenWidthIsMini) {
      return 200;
    }
    if (screenWidthIsStandard) {
      return 230;
    }

    if (screenWidthIsLarge) {
      return 250;
    }
    if (screenWidthIsXLarge) {
      return 300;
    }

    return 250;
  }
}
