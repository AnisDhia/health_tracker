abstract class UserRepository {
  const UserRepository();

  Future<void> login({required String email, required String password});

  Future<void> register(
      {required String username,
      required String email,
      required String password});

  logout();
}
