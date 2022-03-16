import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('Signed Out');
  }

  Future<String?> signIn({required String email, required String password}) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('Signed In');
      return "Signed in";
    } on FirebaseAuthException catch(e) {
      print(e.message);
      return e.message;
    }
  }

  Future<String?> signUp({required String email, required String password}) async{ 
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print('Signed Up');
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}