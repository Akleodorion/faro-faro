import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/device_info.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/date_and_locality.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_image_container.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_price_info.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/event_card/components/event_card_title.dart';
import 'package:flutter/material.dart';

class EventCardClass {
  final BuildContext context;
  final Event event;
  EventCardClass({
    required this.context,
    required this.event,
  });

  double getCardHeight() {
    return getValueBasedOnScreenHeight(100, 150, 200);
  }

  double getCardWidth() {
    return getValueBasedOnScreenWidth(170, 190, 210);
  }

  double getCardImageContainerHeight() {
    return getValueBasedOnScreenWidth(130, 145, 160);
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

  EdgeInsets getCardRightMargin() {
    return const EdgeInsets.only(right: 20);
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: kElevationToShadow[3]);
  }

  EdgeInsets getCardPadding() {
    return const EdgeInsets.fromLTRB(8, 8, 8, 8);
  }

  EventCardImageContainer getCardImageContainer() {
    return EventCardImageContainer(
      imageUrl: event.imageUrl,
      height: getCardImageContainerHeight(),
    );
  }

  DateAndLocality getDateAndLocality() {
    final String address =
        event.address.getLocalityIfPresentElseReturnCountry();

    return DateAndLocality(
      formatedDate: event.formatedDate,
      formatedAddress: limitLegnthOfFormattedAddress(address),
    );
  }

  String limitLegnthOfFormattedAddress(String address) {
    if (address.length > 14) {
      return "${address.substring(0, 10)}...";
    }
    return address;
  }

  EventCardTitle getCardTitle() {
    return EventCardTitle(
      title: event.name,
    );
  }

  EventCardPriceInfo getPriceInfo() {
    return EventCardPriceInfo(event: event);
  }
}
