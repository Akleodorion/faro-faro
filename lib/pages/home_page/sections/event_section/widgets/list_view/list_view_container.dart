// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/device_info.dart';
import '../../../../../../features/events/domain/entities/event.dart';
import 'list_view_layout.dart';

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
