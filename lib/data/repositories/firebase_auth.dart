import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_tracker/data/repositories/storage.dart';
import 'package:health_tracker/data/repositories/user_repository.dart';
import 'package:health_tracker/data/models/user_model.dart' as model;
import 'package:health_tracker/shared/constants/consts_variables.dart';

class FirebaseAuthRepo implements UserRepository {
  FirebaseAuthRepo();

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> register(
      {required String username,
      required String email,
      required String password,
      required Sex sex,
      required Uint8List file}) async {
    try {
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      String photoUrl =
          await FireStorage().uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
        username: username,
        uid: cred.user!.uid,
        sex: sex,
        photoUrl: photoUrl,
        email: email,
        bio: '',
        bookmarkedRecipes: [],
        followers: [],
        following: [],
        isDarkMode: true,
      );

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());

      // res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw 'Please check your email address.';
      }
    } catch (e) {
      throw Exception('oops,Something wrong happend!');
    }
  }

  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signinanonym() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }
}
