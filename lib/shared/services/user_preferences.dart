// import 'dart:convert';

// import 'package:health_tracker/models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserPreferences {
//   static late SharedPreferences _preferences;

//   static const _keyUser = 'user';
//   // static const myUser = User(
//   //   imagePath: 'https://images.pexels.com/photos/10761393/pexels-photo-10761393.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 
//   //   name: 'Borat', 
//   //   email: 'borat@mail.kz', 
//   //   about: 'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
//   //   isDarkMode: true
//   //   );

//     static Future init() async => 
//       _preferences = await SharedPreferences.getInstance();

//   static Future setUser(User user) async {
//     final json = jsonEncode(user.toJson());

//     await _preferences.setString(_keyUser, json);
//   }

//   static User getUser() {
//     final json = _preferences.getString(_keyUser);

//     return json == null ? myUser : User.fromJson(jsonDecode(json));
//   }
// }