import 'package:flutter/material.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF216831),
                width: 2.0,
              ),
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/default_profile.jpg'),
            ),
          ),
        ),
        const Positioned(
          bottom: 5,
          right: 1,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 10,
            child: Icon(
              Icons.menu,
              size: 10,
              color: Color(0xFF216831),
            ),
          ),
        ),
      ],
    );
  }
}
