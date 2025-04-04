import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:group_project/services/firebase_storage.dart';
import 'dart:typed_data';

class PostsStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseStorageService _imageRepo = FirebaseStorageService();

  User? get user => _auth.getCurrentUser();

  // Firebase auth automatically creates a unique id for every user
  String? get userId => user?.uid;


  // calls the image upload function to firebase storage, and saves the details in firestore
  // Along with the post caption
  // Images must be passed in as bytes to be saved best
  Future<Map<String, dynamic>> savePosts(Uint8List? imageBytes, String caption) async {
    try {
      if (user == null) {
        throw Exception("No user logged in");
      }

      // Upload the image to Firebase storage, and grab the image details in a dictionary
      Map<String, dynamic> imageData = await _imageRepo.uploadFile(imageBytes!);

      // Grabs a unique id for the post
      String postId = _firestore.collection("users").doc(userId).collection("posts").doc().id;

      // Create a dictionary to pass into firestore with the details
      Map<String, dynamic> postsData = {
        "imageUrl": imageData["url"],
        "caption": caption,
        "timestamp": FieldValue.serverTimestamp(),
        "postId": postId
      };

      // Save the posts to the user, and add the post data to the posts collection
      await _firestore
        .collection("users")
        .doc(userId)
        .collection("posts")
        .add(postsData);
      return postsData;
    }
    catch (e) {
      throw Exception("Couldn't save post");
    }
  }

  // Retrieve the post details
  Future<List<Map<String, dynamic>>> getUserPostDetails() async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return [];
      }
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("posts")
          .get();

      List<Map<String, dynamic>> posts = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return posts;
    } catch (e) {
      print("Error retrieving post images: $e");
      return [];
    }
  }

}

