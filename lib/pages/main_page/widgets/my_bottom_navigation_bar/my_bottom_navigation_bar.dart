import 'package:faro_clean_tdd/pages/main_page/widgets/my_bottom_navigation_bar/navigation_bar_constants.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        onTap(value);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: NavigationBarConstants.navHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: NavigationBarConstants.navSearch,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: NavigationBarConstants.navTicket,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: NavigationBarConstants.navSettings,
        )
      ],
    );
  }
}
