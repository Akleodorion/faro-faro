// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/pages/home_page/home_page.dart';
import 'package:faro_faro/pages/search_page/search_page.dart';
import 'package:faro_faro/pages/settings_page/settings_page.dart';
import 'package:faro_faro/pages/ticket_page/ticket_page.dart';

Widget getSelectedPage({
  required int selectedIndex,
  required void Function(bool) setEvent,
  required bool isMyTicket,
}) {
  late Widget content;

  switch (selectedIndex) {
    case 1:
      content = const SearchPage();
      break;
    case 2:
      content = TicketPage(
        setEvent: setEvent,
        isMyTicket: isMyTicket,
      );
      break;
    case 3:
      content = const SettingsPage();
      break;
    default:
      content = const HomePage();
  }
  return content;
}
