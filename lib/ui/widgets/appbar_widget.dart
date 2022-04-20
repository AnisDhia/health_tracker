import 'package:flutter/material.dart';
import 'package:health_tracker/ui/screens/profile/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;

  CustomAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
