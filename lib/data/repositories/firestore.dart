import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tracker/data/models/post_model.dart';
import 'package:health_tracker/data/repositories/storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FireStoreCrud {
  // FireStoreCrud();

  final _firestore = FirebaseFirestore.instance;

  // Upload a post
  Future<String> uploadPost(String description, Uint8List? file, String uid,
      String username, String profImage) async {
    String res = "Some error occured";
    try {
      String? photoUrl;
      if (file != null) {
        photoUrl =
            await FireStorage().uploadImageToStorage('posts', file, true);
      }
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          likes: [],
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateDiaryMeal(
      String meal,
      String foodId,
      String type,
      String name,
      double calories,
      double carbs,
      double fat,
      double protein) async {
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(DateTime.now()))
          .set({
        'totalCalories': FieldValue.increment(calories),
        'totalProtein': FieldValue.increment(protein),
        'totalCarbs': FieldValue.increment(carbs),
        'totalFat': FieldValue.increment(fat),
        meal: {
          '${meal.toLowerCase()}Calories': FieldValue.increment(calories),
          '${meal.toLowerCase()}Protein': FieldValue.increment(protein),
          '${meal.toLowerCase()}Fat': FieldValue.increment(fat),
          '${meal.toLowerCase()}Carbs': FieldValue.increment(carbs),
          'foods': FieldValue.arrayUnion([
            {
              'id': foodId,
              'name': name,
              'calories': calories,
              'carbs': carbs,
              'protein': protein,
              'fat': fat,
              'source': type
            }
          ])
        }
      }, SetOptions(merge: true)).onError(
              (error, stackTrace) => log('Error writing document: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeDiaryMealFood(
      String meal,
      String foodId,
      String name,
      double calories,
      double carbs,
      double fat,
      double protein,
      String type) async {
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(DateTime.now()))
          .set({
        'totalCalories': FieldValue.increment(-calories),
        'totalProtein': FieldValue.increment(-protein),
        'totalCarbs': FieldValue.increment(-carbs),
        'totalFat': FieldValue.increment(-fat),
        meal: {
          '${meal.toLowerCase()}Calories': FieldValue.increment(-calories),
          '${meal.toLowerCase()}Protein': FieldValue.increment(-protein),
          '${meal.toLowerCase()}Fat': FieldValue.increment(-fat),
          '${meal.toLowerCase()}Carbs': FieldValue.increment(-carbs),
          'foods': FieldValue.arrayRemove([
            {
              'id': foodId,
              'name': name,
              'calories': calories,
              'carbs': carbs,
              'protein': protein,
              'fat': fat,
              'source': type
            }
          ])
        }
      }, SetOptions(merge: true)).onError(
              (error, stackTrace) => log('Error writing document: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateDiaryWeight(DateTime date, String weight, String? bodyFat,
      String? skeletalMuscle, String? notes) async {
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(date))
          .set({
        'weight': FieldValue.arrayUnion([
          {
            'hour': date.hour,
            'minute': date.minute,
            'weight': weight,
            'bodyFat': bodyFat,
            'notes': notes
          }
        ])
      }, SetOptions(merge: true)).onError(
              (error, stackTrace) => log('Error writing document: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateDiaryWater(int waterValue) async {
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(DateTime.now()))
          .set({'water': waterValue}, SetOptions(merge: true)).onError(
              (error, stackTrace) => log('Error writing document: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> quickAddMacros(
      double calories, double protein, double fat, double carbs) async {
    try {
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('diary')
          .doc(DateFormat('d-M-y').format(DateTime.now()))
          .set({
        'totalCalories': FieldValue.increment(calories),
        'quickAdd': {
          'calories': FieldValue.increment(calories),
          'protein': FieldValue.increment(protein),
          'fat': FieldValue.increment(fat),
          'carbs': FieldValue.increment(carbs),
        }
      }, SetOptions(merge: true)).onError(
              (error, stackTrace) => log('Error writing document: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

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
