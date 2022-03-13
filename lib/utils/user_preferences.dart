import 'package:health_tracker/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const myUser = User(
    imagePath: 'https://images.pexels.com/photos/10761393/pexels-photo-10761393.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940', 
    name: 'Borat', 
    email: 'borat@mail.kz', 
    about: 'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: true
    );

    static Future init() async => 
      _preferences = await SharedPreferences.getInstance();
}