import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid, photoUrl, username, email, about; 
  final bool isDarkMode;
  final List bookmarkedRecipes;

  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.about,
    required this.isDarkMode,
    required this.bookmarkedRecipes 
  });

  static User fromSnap(DocumentSnapshot json) => User(
    username: json['username'],
    uid: json['uid'],
    photoUrl: json['photoUrl'],
    email: json['email'],
    about: json['about'],
    isDarkMode: json['isDarkMode'],
    bookmarkedRecipes: json['bookmarkedRecipes']
  );
  
  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'photoUrl': photoUrl,
    'email': email,
    'about': about,
    'isDarkMode': isDarkMode,
    'bookmarkedRecipes': bookmarkedRecipes
  };
}