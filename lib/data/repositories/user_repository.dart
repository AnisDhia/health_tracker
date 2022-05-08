import 'dart:typed_data';

import 'package:health_tracker/shared/constants/consts_variables.dart';

abstract class UserRepository {
  const UserRepository();

  Future<void> login({required String email, required String password});

  Future<void> register(
      {required String username,
      required String email,
      required String password,
      required Sex sex,
      required Uint8List file});

  logout();
}
