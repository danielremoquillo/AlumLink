// ignore_for_file: use_build_context_synchronously

import 'package:alumlink_app/providers/session_provider.dart';
import 'package:alumlink_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _signOutUser() async {
    final prefs = await SharedPreferences.getInstance();

    //Clearing session
    await prefs.remove('id');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('password');

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const SignInScreen();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    left: 1,
                    right: 1,
                    bottom: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF216831),
                          width: 2.0,
                        ),
                      ),
                      child: const CircleAvatar(
                        minRadius: 20,
                        maxRadius: 50,
                        backgroundImage:
                            AssetImage('assets/images/default_profile.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                  '${Provider.of<SessionProvider>(context, listen: false).user.email}'),
              TextButton(onPressed: _signOutUser, child: Text('logout'))
            ],
          ),
        ),
      ),
    );
  }
}
