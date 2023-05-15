import 'package:alumlink_app/screens/account_screen.dart';
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
    const AccountScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Alum',
                style: TextStyle(
                    fontSize: 24.0,
                    letterSpacing: -1.5,
                    color: Color(0xFF353535),
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: 'Link',
                    style: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: -2,
                      color: Color(0xFF216831),
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.green,
                ))

            // //Actions
            // Row(
            //   children: [
            //     const CircleAvatar(
            //       radius: 18,
            //       child: Icon(
            //         Icons.search_outlined,
            //         size: 18,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           color: const Color(0xFF216831),
            //           width: 2.0,
            //         ),
            //       ),
            //       child: const CircleAvatar(
            //         backgroundColor: Colors.white,
            //         radius: 16,
            //         child: Icon(
            //           Icons.menu_outlined,
            //           size: 16,
            //           color: Color(0xFF216831),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
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
