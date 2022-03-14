import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/model/user.dart';
import 'package:health_tracker/pages/edit_profile.dart';
import 'package:health_tracker/utils/user_preferences.dart';
import 'package:health_tracker/widgets/appbar.dart';
import 'package:health_tracker/widgets/button-widget.dart';
import 'package:health_tracker/widgets/numbers.dart';
import 'package:health_tracker/widgets/profile-widget.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const EditProfile()),
                    );
                    setState(() {
                      
                    });
                  },
                ),
                const SizedBox(height: 24,),
                buildName(user),
                const SizedBox(height: 24,),
                Center(child: buildUpgradeButton()),
                const SizedBox(height: 24,),
                NumbersWidget(),
                const SizedBox(height: 48,),
                buildAbout(user),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget buildAbout(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),        
        ),
        const SizedBox(height: 16,),
        Text(
          user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        )
  
      ],
    ),
  );

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        )
      ),
      const SizedBox(height: 4,),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );
}