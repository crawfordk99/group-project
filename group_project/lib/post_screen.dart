import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  Uint8List? _imageBytes; // Image in byte format
  String? _imageUrl; // Displayed image URL
  final TextEditingController _captionController = TextEditingController();

  // Function to pick image from file system
  Future<void> _pickImage() async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files?.isEmpty ?? true) return;

      final file = files![0];
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        setState(() {
          _imageBytes = reader.result as Uint8List;
          _imageUrl = null; // Reset URL
        });
      });
    });
  }

  // Function to upload image and save post to Firebase
  Future<void> _uploadImageAndSavePost() async {
    if (_imageBytes == null || _captionController.text.isEmpty) return;

    try {
      String fileName = "post_${const Uuid().v4()}.jpg";
      Reference ref = FirebaseStorage.instance.ref().child('posts/$fileName');

      // Upload image bytes to Firebase Storage
      UploadTask uploadTask = ref.putData(_imageBytes!);
      TaskSnapshot snapshot = await uploadTask;

      // Get download URL for the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the post data (image URL, caption, timestamp) in Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'imageUrl': downloadUrl,
        'caption': _captionController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _imageUrl = downloadUrl;
        _imageBytes = null; // Clear uploaded bytes
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post uploaded successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload post")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display selected image or image URL
            _imageBytes != null
                ? Image.memory(_imageBytes!, height: 200, fit: BoxFit.cover)
                : _imageUrl != null
                ? Image.network(_imageUrl!, height: 200, fit: BoxFit.cover)
                : Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Caption input field
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                hintText: "Enter a caption...",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),

            // Image picker button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Select from File"),
            ),
            const SizedBox(height: 10),

            // Upload button
            ElevatedButton(
              onPressed: _uploadImageAndSavePost,
              child: const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
