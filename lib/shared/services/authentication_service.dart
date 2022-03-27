import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthenticationService(this._firebaseAuth, this._firestore);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    log('Signed Out');
  }

  // EMAIL AUTHENTICATION
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      log('Signed In');
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore
          .collection("/users")
          .doc(userCredential.user!.uid)
          .set({'Full Name': name, 'uid': userCredential.user!.uid});

      log('Signed Up');
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return e.message;
    }
  }

  // GOOGLE AUTHENTICATION

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // TODO: generate firebase document for google users

    log('Signed Up With Google');
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
