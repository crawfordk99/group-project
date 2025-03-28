import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Used to create unique timestamp id for the image
  Uuid _uuid = Uuid();

  // Get the current user
  User? get user => _auth.getCurrentUser();

  // Get a unique id for the user
  String? get userId => user?.uid;



  // Connect to emulator during development
  void connectToEmulator() {
    _storage.useStorageEmulator('localhost', 9199);
  }

  // Upload an image file to Firebase Storage
  Future<Map<String, dynamic>> uploadFile(File imageFile) async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return {};
      }

      // Unique id for the image
      String imageId = _uuid.v4();

      // Create file path to store image in
      final imageRef = _storage.ref().child('$userId/images/$imageId.jpg');

      // Put it to a file
      UploadTask uploadTask = imageRef.putFile(imageFile);

      // Create a snapshot of the data
      TaskSnapshot snapshot = await uploadTask;

      //
      String downloadURL = await snapshot.ref.getDownloadURL();

      // Store metadata in Firestore under the user's document
      Map<String, dynamic> imageData = {
        "userID": userId,
        "imageID": imageId,
        "url": downloadURL,
        "uploadedAt": FieldValue.serverTimestamp()
      };

      // Wait for it to create the entry
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("images")
          .doc(imageId)
          .set(imageData);

      return imageData;

    } catch (e) {
      print("Error uploading file: $e");
      return {};
    }

  }
  Future<List<Map<String, dynamic>>> getUserImages() async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return [];
      }

      // Query Firestore for images uploaded by the user
      QuerySnapshot querySnapshot = await _firestore
          .collection("images")
          .where("userID", isEqualTo: userId)
          .get();

      // Convert documents into a list of maps
      List<Map<String, dynamic>> images = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return images;
    } catch (e) {
      print("Error retrieving images: $e");
      return [];
    }
  }

  Future<bool> deleteImage(String imageId) async {
    try {
      // Get image document from Firestore
      DocumentSnapshot imageDoc = await _firestore.collection("images").doc(imageId).get();

      if (!imageDoc.exists) {
        print("Error: Image not found.");
        return false;
      }

      // Get image URL and delete from Storage
      String imageUrl = imageDoc['url'];
      final storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();

      // Delete Firestore document
      await _firestore.collection("images").doc(imageId).delete();

      print("Image deleted successfully.");
      return true;
    } catch (e) {
      print("Error deleting image: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> uploadProfilePic(File imageFile) async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return {};
      }

      // Unique id for the image
      String imageId = _uuid.v4();

      // Create file path to store image in
      final imageRef = _storage.ref().child('$userId/profilePic/$imageId.jpg');

      // Put it to a file
      UploadTask uploadTask = imageRef.putFile(imageFile);

      // Create a snapshot of the data
      TaskSnapshot snapshot = await uploadTask;

      //
      String downloadURL = await snapshot.ref.getDownloadURL();

      // Store metadata in Firestore under the user's document
      Map<String, dynamic> imageData = {
        "userID": userId,
        "imageID": imageId,
        "url": downloadURL,
        "uploadedAt": FieldValue.serverTimestamp()
      };

      // Wait for it to create the entry
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("profilePic")
          .doc(imageId)
          .set(imageData);

      return imageData;

    } catch (e) {
      print("Error uploading file: $e");
      return {};
    }

  }

  Future<List<Map<String, dynamic>>> getUserProfilePic() async {
    try {
      if (userId == null) {
        print("Error: User is not logged in.");
        return [];
      }

      // Query Firestore for images uploaded by the user
      QuerySnapshot querySnapshot = await _firestore
          .collection("profilePic")
          .where("userID", isEqualTo: userId)
          .get();

      // Convert documents into a list of maps
      List<Map<String, dynamic>> image = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return image;
    } catch (e) {
      print("Error retrieving images: $e");
      return [];
    }
  }
  // Pick an image from the gallery and upload it
//   Future<String?> pickAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       File file = File(pickedFile.path);
//       return await uploadFile(file, pickedFile.name);
//     }
//     return null;
//   }
}