import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/device_info.dart';

import '../../../../../../features/events/domain/entities/event.dart';
import 'list_view_layout.dart';
import 'package:flutter/material.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer({
    super.key,
    required this.title,
    required this.events,
  });

  final String title;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    final double listViewHeight = getListViewHeight(context);

    return SizedBox(
      height: listViewHeight,
      child: ListViewLayout(
        listViewTitle: title,
        events: events,
      ),
    );
  }

  double getListViewHeight(BuildContext context) {
    final screenHeight = DeviceInfo().getScreenHeight(context);

    if (screenHeight == ScreenHeight.smallHeight) {
      return 280;
    }

    if (screenHeight == ScreenHeight.standardHeight) {
      return 320;
    }

    if (screenHeight == ScreenHeight.largeHeight) {
      return 350;
    }

    throw ServerException(errorMessage: 'oops');
  }
}
