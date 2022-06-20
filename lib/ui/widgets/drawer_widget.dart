import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/data/repositories/firebase_auth.dart';
import 'package:health_tracker/shared/services/user_provider.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/screens/messages/messages_screen.dart';
import 'package:health_tracker/ui/screens/profile/profile_screen.dart';
import 'package:health_tracker/ui/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(user.photoUrl),
                  radius: 25,
                ),
                const SizedBox(height: 14),
                Text(
                  user.username,
                  style: const TextStyle(fontSize: 26),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.input),
          title: const Text('Welcome'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.verified_user),
          title: const Text('Profile'),
          onTap: () => {
            Navigator.pop(context),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfileScreen(
                          uid: user.uid,
                        )))
          },
        ),
        ListTile(
          leading: const Icon(Icons.message),
          title: const Text('Messages'),
          onTap: () => {
            Navigator.pop(context),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const MessagesScreen()))
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => {
            Navigator.of(context).pop(),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SettingsScreen()))
          },
        ),
        ListTile(
          leading: const Icon(Icons.border_color),
          title: const Text('Feedback'),
          onTap: () => {Navigator.of(context).pop()},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          onTap: () => {FirebaseAuthRepo().logout()},
        ),
        ListTile(
          leading: const Icon(CupertinoIcons.moon_stars),
          title: const Text('Dark Mode'),
          trailing: Consumer<ThemeNotifier>(
            builder: (context, value, child) {
              return CupertinoSwitch(
                  value: value.darkTheme,
                  activeColor: Colors.red,
                  onChanged: (newValue) {
                    value.toggleTheme();
                  });
            },
          ),
        ),
      ],
    ));
  }
}
