import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/pages/search_page/search_page.dart';
import 'package:faro_clean_tdd/pages/ticket_page/pop_page/new_event_page/new_event_page.dart';

import '../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'settings_page/settings_page.dart';
import 'ticket_page/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_page/home_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late int _currentIndex;
  bool isMyTicket = true;
  late Widget content;

  @override
  void initState() {
    super.initState();
    ref.read(fetchEventProvider.notifier).fetchAllEvents();
    int userId = ref.read(userInfoProvider)["user_id"];
    _currentIndex = 0;
    ref.read(fetchTicketsProvider.notifier).fetchUserTickets(userId: userId);
    ref.read(contactStateProvider.notifier).fetchContact();
  }

  void setEvent(bool value) {
    setState(() {
      isMyTicket = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: (_currentIndex == 2 && isMyTicket == false)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const NewEventPage();
                }));
              },
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            )
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
          child: SafeArea(child: content)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: "Ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          )
        ],

        // selected Item style
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedIconTheme: const IconThemeData(size: 40),
        selectedLabelStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

        // unselected Item style
        unselectedItemColor:
            Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        unselectedIconTheme: const IconThemeData(size: 32),
        unselectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        showUnselectedLabels: true,
        // General behavior
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
