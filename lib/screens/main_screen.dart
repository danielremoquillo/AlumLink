import 'package:alumlink_app/screens/account_screen.dart';
import 'package:alumlink_app/screens/job_screen.dart';
import 'package:alumlink_app/widgets/profile_menu_button.dart';
import 'package:alumlink_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _children = [
    const JobScreen(),
    const JobScreen(),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF216831),
        elevation: 1,
        leading: const ProfileMenuButton(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ))
        ],
        title: SearchBar(),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: const Color(0xFF216831),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                _currentIndex == 1 ? Icons.groups : Icons.groups_outlined,
                color: const Color(0xFF216831),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 32.0),
            IconButton(
              icon: Icon(
                _currentIndex == 2
                    ? Icons.chat_bubble
                    : Icons.chat_bubble_outline,
                color: const Color(0xFF216831),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(
                _currentIndex == 3 ? Icons.person : Icons.person_outline,
                color: const Color(0xFF216831),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF216831),
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: Text('This is a BottomSheet'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
