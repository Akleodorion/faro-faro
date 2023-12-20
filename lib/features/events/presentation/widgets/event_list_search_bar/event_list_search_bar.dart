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
    final double screenWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    void searchEvent() {
      formKey.currentState!.save();
      ref.read(fetchEventProvider.notifier).searchEvent(
          textEditingController.text, ref.read(fetchEventProvider));
    }

    final searchBarContainerHeight = getSearchBarContainerHeight(context);

    return Container(
      height: searchBarContainerHeight,
      width: screenWidth * 0.65,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: kElevationToShadow[3]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchBarTextField(
                  screenWidth: screenWidth,
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
}
