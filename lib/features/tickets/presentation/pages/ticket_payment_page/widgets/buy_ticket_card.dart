import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/device_info.dart';
import 'package:faro_clean_tdd/core/util/general_spacers.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';

class BuyTicketCard extends StatelessWidget {
  const BuyTicketCard({
    super.key,
    required this.incrOrDecr,
    required this.event,
    required this.ticketType,
    required this.ticketQuantity,
  });

  final void Function(bool value) incrOrDecr;
  final Event event;
  final Type ticketType;
  final int ticketQuantity;

  @override
  Widget build(BuildContext context) {
    late String ticketLeft;
    late int? ticketPrice;

    if (ticketType == Type.standard) {
      ticketLeft = event.standardTicketLeft;
      ticketPrice = event.standardTicketPrice;
    } else if (ticketType == Type.gold) {
      ticketLeft = event.goldTicketLeft;
      ticketPrice = event.goldTicketPrice;
    } else {
      ticketLeft = event.platinumTicketLeft;
      ticketPrice = event.platinumTicketPrice;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ticket ${ticketType.name}:",
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(
            height: GeneralSpacers().getTitleSpace(context),
          ),
          Text(
            ticketLeft,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: GeneralSpacers().getTitleSpace(context),
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            height: 60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ticketPrice == null
                      ? Text(
                          "Grauit ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : Text(
                          "$ticketPrice XOF",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                  SizedBox(
                    width: getBuyTicketCardInputWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            incrOrDecr(false);
                          },
                          style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          icon: const Icon(Icons.remove),
                        ),
                        Container(
                          height: getBuyTicketCardInputHeight(context),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          width: getBuyTicketCardInputHeight(context),
                          child: Center(
                            child: Text(
                              ticketQuantity.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            incrOrDecr(true);
                          },
                          style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double getBuyTicketCardInputHeight(BuildContext context) {
    final screenHeight = DeviceInfo().getScreenHeight(context);

    if (screenHeight == ScreenHeight.smallHeight) {
      return 40;
    }
    if (screenHeight == ScreenHeight.standardHeight) {
      return 50;
    }
    if (screenHeight == ScreenHeight.largeHeight) {
      return 60;
    }
    throw ServerException(errorMessage: 'an error as occured');
  }

  double getBuyTicketCardInputWidth(BuildContext context) {
    final screenWidth = DeviceInfo().getScreenWidth(context);

    if (screenWidth == ScreenWidth.smallWidth) {
      return 150;
    }
    if (screenWidth == ScreenWidth.standardWidth) {
      return 180;
    }
    if (screenWidth == ScreenWidth.largeWidth) {
      return 210;
    }

    throw ServerException(errorMessage: 'an error as occured');
  }
}
