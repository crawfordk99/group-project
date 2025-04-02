import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:group_project/services/firebase_storage.dart';
import 'dart:io';
import 'dart:typed_data';

class PostsStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseStorageService _imageRepo = FirebaseStorageService();

  User? get user => _auth.getCurrentUser();

  String? get userId => user?.uid;



  Future<Map<String, dynamic>> savePosts(Uint8List? imageBytes, String caption) async {
    try {
      if (user == null) {
        throw Exception("No user logged in");
      }
      Map<String, dynamic> imageData = await _imageRepo.uploadFile(imageBytes!);

      String postId = _firestore.collection("users").doc(userId).collection("posts").doc().id;

      Map<String, dynamic> postsData = {
        "imageUrl": imageData["url"],
        "caption": caption,
        "timestamp": FieldValue.serverTimestamp(),
        "postId": postId
      };
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
  Future<List<Map<String, dynamic>>> getUserPosts() async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return [];
      }

      // Query Firestore for posts uploaded by the user
      QuerySnapshot querySnapshot = await _firestore
          .collection("posts")
          .where("userID", isEqualTo: userId)
          .get();

      // Convert documents into a list of maps
      List<Map<String, dynamic>> posts = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return posts;
    } catch (e) {
      print("Error retrieving images: $e");
      return [];
    }
  }
}