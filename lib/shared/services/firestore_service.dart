import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // bookmark a recipe
  Future<String> bookmarkRecipe(String recipeId, String uid, List bookmarks) async {
    try {
      if (bookmarks.contains(recipeId)) {
        // if already bookmarked then remove from bookmarks
        _firestore.collection('users').doc(uid).update({
          'bookmarkedRecipes': FieldValue.arrayRemove([recipeId])
        });
      } else {
        _firestore.collection('users').doc(uid).update({
          'bookmarkedRecipes': FieldValue.arrayUnion([recipeId])
        });
      }
      return "Bookmarks Updated";
    } catch (e) {
      throw e.toString();
    }
  }
}