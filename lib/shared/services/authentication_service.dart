import 'dart:developer';
import 'package:health_tracker/data/models/user_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_tracker/shared/constants/consts_variables.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // AuthenticationService(this._firebaseAuth, this._firestore);

  Future<model.User> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }

  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

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
      return "success";
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String name,
      required Sex? sex,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      model.User user = model.User(
        username: name,
        sex: sex,
        uid: userCredential.user!.uid,
        photoUrl: '',
        email: email,
        bio: '',
        isDarkMode: true,
        bookmarkedRecipes: [],
        followers: [],
        following: [],
      );

      await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(user.toJson());

      log('Signed Up');
      return "success";
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
