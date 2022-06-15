import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/ui/screens/notifications_screen.dart';
import 'package:health_tracker/ui/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ));
            },
            icon: const Icon(Icons.notifications)),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                          uid: FirebaseAuth.instance.currentUser!.uid)));
            },
            child: CircleAvatar(
              // backgroundImage: AssetImage('assets/images/profile.jpg'),
              backgroundImage: NetworkImage(user.photoUrl),
              backgroundColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
