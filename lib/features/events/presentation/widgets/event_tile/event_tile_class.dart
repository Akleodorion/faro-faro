import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/device_info.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_tile/components/event_tile_general_info_container.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_tile/components/event_tile_image_container.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_tile/components/event_tile_more_info_container.dart';
import 'package:flutter/material.dart';

class EventTileClass {
  final BuildContext context;
  final Event event;

  EventTileClass({required this.context, required this.event});

  double getTileHeight() {
    return getValueBasedOnScreenHeight(80, 100, 120);
  }

  double getValueBasedOnScreenHeight(
    double smallValue,
    double standardValue,
    double largeValue,
  ) {
    final screenHeight = DeviceInfo().getScreenHeight(context);
    if (screenHeight == ScreenHeight.smallHeight) {
      return smallValue;
    }
    if (screenHeight == ScreenHeight.standardHeight) {
      return standardValue;
    }
    if (screenHeight == ScreenHeight.largeHeight) {
      return largeValue;
    }

    throw ServerException(errorMessage: 'oops');
  }

  double getValueBasedOnScreenWidth(
    double smallValue,
    double standardValue,
    double largeValue,
  ) {
    final screenWidth = DeviceInfo().getScreenWidth(context);
    if (screenWidth == ScreenWidth.smallWidth) {
      return smallValue;
    }
    if (screenWidth == ScreenWidth.standardWidth) {
      return standardValue;
    }
    if (screenWidth == ScreenWidth.largeWidth) {
      return largeValue;
    }

    throw ServerException(errorMessage: 'oops');
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      borderRadius: BorderRadius.circular(5),
      boxShadow: kElevationToShadow[3],
    );
  }

  EdgeInsetsGeometry getContainerMargin() {
    return const EdgeInsets.only(bottom: 20);
  }

  EventTileImageContainer getImageContainer() {
    return EventTileImageContainer(
      event: event,
      squareSize: 70,
    );
  }

  EventTileMoreInfoContainer getMoreInfoContainer() {
    return EventTileMoreInfoContainer(event: event);
  }

  EventTileGeneralInfoContainer getGeneralInfoContainer() {
    return EventTileGeneralInfoContainer(
      eventTitle: event.name,
      eventFormatedAddress: event.formatedDate,
      eventCategory: event.category.name,
      eventLimitedAddress: getLimitedAddress(
          event.address.getLocalityIfPresentElseReturnCountry()),
    );
  }

  String getLimitedAddress(address) {
    if (address.length > 14) {
      return "${address.substring(0, 10)}...";
    }
    return address;
  }
}
