import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/themes.dart';
import 'package:health_tracker/utils/user_preferences.dart';
// import 'package:health_tracker/utils/user_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  final user = UserPreferences.getUser();
  final isDarkMode = user.isDarkMode;
  const icon = CupertinoIcons.moon_stars;
  
  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
      
            ThemeSwitcher.of(context).changeTheme(theme: theme,);

            final newUser = user.copy(isDarkTheme: !isDarkMode);
            UserPreferences.setUser(newUser);
          },
          icon: const Icon(icon), 
        ),
      ),
    ],
  );
}