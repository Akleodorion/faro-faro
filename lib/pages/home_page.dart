import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          child: const Center()),
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
        unselectedIconTheme: const IconThemeData(size: 40),
        unselectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        showUnselectedLabels: false,
        // General behavior
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
