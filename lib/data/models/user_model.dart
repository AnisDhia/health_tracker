import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tracker/shared/constants/consts_variables.dart';

class User {
  final String uid, photoUrl, username, email, bio;
  final Sex? sex;
  final bool isDarkMode;
  final List bookmarkedRecipes, followers, following;

  const User(
      {required this.username,
      required this.uid,
      required this.sex,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.isDarkMode,
      required this.bookmarkedRecipes,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot['username'],
        uid: snapshot['uid'],
        sex: snapshot['sex'] == 1 ? Sex.male : Sex.female,
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email'],
        bio: snapshot['bio'],
        isDarkMode: snapshot['isDarkMode'],
        bookmarkedRecipes: snapshot['bookmarkedRecipes'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'sex': sex == Sex.male ? 1 : 2,
        'photoUrl': photoUrl,
        'email': email,
        'bio': bio,
        'isDarkMode': isDarkMode,
        'bookmarkedRecipes': bookmarkedRecipes,
        'followers': followers,
        'following': following
      };
}
