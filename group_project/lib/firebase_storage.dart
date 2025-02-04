import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Connect to emulator during development
  void connectToEmulator() {
    _storage.useStorageEmulator('localhost', 9199);
  }

  // Upload an image file to Firebase Storage
  Future<String?> uploadFile(File file, String fileName) async {
    try {
      Reference ref = _storage.ref().child('uploads/$fileName');
      await ref.putFile(file);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading file: $e");
      return null;
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