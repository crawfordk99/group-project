import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:group_project/services/posts_storage.dart';
class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  Uint8List? _imageBytes; // Image in byte format
  String? _imageUrl; // Displayed image URL
  final TextEditingController _captionController = TextEditingController();
  final PostsStorage _storage = PostsStorage();


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
      // Our services class will handle the actual saving of the posts.
      Map <String, dynamic> postData = await _storage.savePosts(_imageBytes, _captionController.text);

      setState(() {
        _imageUrl = postData["imageUrl"];
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
