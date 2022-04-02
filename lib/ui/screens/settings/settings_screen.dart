import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/shared/styles/themes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('settings')),
      body: ListView(children: [
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
      ],)
    );
  }
}