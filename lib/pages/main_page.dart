
import '../features/events/presentation/providers/event_provider.dart';
import '../features/filters/presentation/pages/search_page/search_page.dart';
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
  late Widget content;

  @override
  void initState() {
    super.initState();
    ref.read(eventProvider.notifier).fetchAllEvents();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentIndex) {
      case 1:
        content = const SearchPage();
        break;
      case 2:
        content = const TicketPage();
        break;
      case 3:
        content = const SettingsPage();
        break;
      default:
        content = const HomePage();
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
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
