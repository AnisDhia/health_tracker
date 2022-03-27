import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/screens/profile/profile_screen.dart';
import 'package:health_tracker/screens/settings/settings_screen.dart';
import 'package:health_tracker/shared/services/authentication_service.dart';
import 'package:health_tracker/shared/themes.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          child: Text(
            'Side menu',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/cover.jpg'),
              )),
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => const ProfileScreen()))
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
          onTap: () => {context.read<AuthenticationService>().signOut()},
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
                }
              );
            },
          ),
        ),
      ],
    ));
  }
}
