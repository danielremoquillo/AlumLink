import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 3;

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
              Icons.home_outlined,
              color: Color(0xFF216831),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.forum_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.forum_outlined,
              color: Color(0xFF216831),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.groups_outlined,
              color: Color(0xFF216831),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF353535),
            ),
            activeIcon: Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF216831),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
