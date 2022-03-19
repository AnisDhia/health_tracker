import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/model/user.dart';
import 'package:health_tracker/utils/user_preferences.dart';
import 'package:health_tracker/widgets/appbar.dart';
import 'package:health_tracker/widgets/button_widget.dart';
import 'package:health_tracker/widgets/profile_widget.dart';
import 'package:health_tracker/widgets/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({ Key? key }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold (
            appBar: buildAppBar(context),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final directory = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage = 
                        await File(image.path).copy(imageFile.path);
                    setState(() => user = user.copy(imagePath: newImage.path));
                  },

                ),
                const SizedBox(height: 24,),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) => user = user.copy(name: name),
                ),
                const SizedBox(height: 24,),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) => user = user.copy(email: email),
                ),
                const SizedBox(height: 24,),
                TextFieldWidget(
                  label: 'About',
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) => user = user.copy(about: about),
                ),
                const SizedBox(height: 24,),
                ButtonWidget(
                  text: 'Save',
                  onClicked: () {
                    UserPreferences.setUser(user);
                    Navigator.of(context).pop();
                  }
                ),
              ],
            )
          );
        }
      ),
    );
  }
}