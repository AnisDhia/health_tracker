import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('Signed Out');
  }

  // EMAIL AUTHENTICATION 
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
      // TODO: generate user document in firestore
      print('Signed Up');
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // GOOGLE AUTHENTICATION 

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print('Signed Up With Google');
    return await _firebaseAuth.signInWithCredential(credential);
  }
}