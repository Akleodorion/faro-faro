// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/device_info.dart';
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';
import 'package:faro_faro/features/tickets/presentation/widgets/ticket_tile/components/ticket_tile_general_info_container.dart';
import 'package:faro_faro/features/tickets/presentation/widgets/ticket_tile/components/ticket_tile_image_container.dart';

class TicketTileClass {
  final BuildContext context;
  final Ticket ticket;
  final Event event;

  TicketTileClass(
      {required this.context, required this.ticket, required this.event});

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      borderRadius: BorderRadius.circular(5),
      boxShadow: kElevationToShadow[3],
    );
  }

  TicketTileImageContainer getImageContainer(String eventUrl) {
    return TicketTileImageContainer(
      eventUrl: eventUrl,
    );
  }

  TicketTileGeneralInfoContainer getGeneralInfoContainer() {
    return TicketTileGeneralInfoContainer(
      ticket: ticket,
      ticketFormatedDescription: getFormatedDescription(ticket.description),
    );
  }

  String getFormatedDescription(String description) {
    if (description.length >= 60) {
      return "${description.substring(0, 57)}...";
    }
    return description;
  }

  double getTileHeight() {
    return getValueBasedOnScreenHeight(100, 110, 120);
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
}
