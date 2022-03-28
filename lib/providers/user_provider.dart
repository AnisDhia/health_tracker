import 'package:flutter/widgets.dart';
import 'package:health_tracker/models/user.dart';
import 'package:health_tracker/shared/services/authentication_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthenticationService _authService = AuthenticationService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authService.getUserDetails();
    _user = user;
    notifyListeners();
  }
}