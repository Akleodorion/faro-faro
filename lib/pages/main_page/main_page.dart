// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/pages/main_page/methods/get_selected_page.dart';
import 'package:faro_faro/pages/main_page/widgets/my_bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:faro_faro/pages/main_page/widgets/my_floating_action_button/my_floating_action_button.dart';
import '../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late int _currentIndex;
  bool isMyTicket = true;

  @override
  void initState() {
    super.initState();
    ref.read(fetchEventProvider.notifier).fetchAllEvents();
    int userId = ref.read(userInfoProvider)["user_id"];
    _currentIndex = 0;
    ref.read(fetchTicketsProvider.notifier).fetchUserTickets(userId: userId);
  }

  void setEvent(bool value) {
    setState(() {
      isMyTicket = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = getSelectedPage(
      selectedIndex: _currentIndex,
      setEvent: setEvent,
      isMyTicket: isMyTicket,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: (_currentIndex == 2 && isMyTicket == false)
          ? const MyFloatingActionButton()
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(42, 43, 42, 1),
              Color.fromRGBO(42, 43, 42, 0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: content,
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int value) {
            setState(() {
              _currentIndex = value;
            });
          }),
    );
  }
}
