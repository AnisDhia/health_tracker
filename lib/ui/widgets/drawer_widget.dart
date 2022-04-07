import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/bloc/auth/authentication_cubit.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:health_tracker/ui/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key, required this.authenticationCubit}) : super(key: key);

  AuthenticationCubit authenticationCubit;

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
          onTap: () => {
            // AuthenticationService().signOut()
            authenticationCubit.signout()
            },
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
