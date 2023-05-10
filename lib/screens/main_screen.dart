import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.home,
              color: Color(0xFF216831),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.groups,
              color: Color(0xFF216831),
            ),
            label: 'Networks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.person,
              color: Color(0xFF216831),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
