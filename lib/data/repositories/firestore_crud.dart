import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreCrud {
  FireStoreCrud();

  final _firestore = FirebaseFirestore.instance;

  // Future<void> bookmarkRecipe(String recipeId, String uid) async {
  //   DocumentReference user = _firestore.collection('users').doc(uid);
  //   user.get();
  //   try {
  //     if (user['bookmarks'].contains(recipeId)) {
  //       // if already bookmarked then remove from bookmarks
  //       _firestore.collection('users').doc(uid).update({
  //         'bookmarkedRecipes': FieldValue.arrayRemove([recipeId])
  //       });
  //     } else {
  //       _firestore.collection('users').doc(uid).update({
  //         'bookmarkedRecipes': FieldValue.arrayUnion([recipeId])
  //       });
  //     }
  //     log("Bookmarks Updated");
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
