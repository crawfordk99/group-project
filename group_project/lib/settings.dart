import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // Add the image_picker package

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String profilePicUrl = 'https://example.com/profile-pic.jpg'; // Default image URL
  String userEmail = '';
  String userPassword = '';

  late TextEditingController userEmailController;
  late TextEditingController userPasswordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late File _profilePicFile;
  bool isLoading = false; // Loading state for image upload or settings update

  @override
  void initState() {
    super.initState();
    userEmailController = TextEditingController(text: userEmail);
    userPasswordController = TextEditingController(text: userPassword);
    _fetchUserDetails();
  }

  @override
  void dispose() {
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  void _fetchUserDetails() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? '';
        userPassword = '********';
      });
      userEmailController.text = userEmail;
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    // Picking image from the gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicFile = File(pickedFile.path);
      });
      _uploadProfilePic(); // Upload the selected image to Firebase Storage
    }
  }

  Future<void> _uploadProfilePic() async {
    setState(() {
      isLoading = true; // Set loading to true while the upload is in progress
    });
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Define the storage reference for the image
        Reference ref = _storage.ref().child('profile_pics/${user.uid}.png');
        // Upload the image file to Firebase Storage
        await ref.putFile(_profilePicFile);
        String downloadUrl = await ref.getDownloadURL(); // Get the image URL after uploading
        setState(() {
          profilePicUrl = downloadUrl; // Update the profile picture URL with the new URL
          isLoading = false; // Reset loading state
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile picture uploaded successfully!'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Reset loading state
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading image: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _updateSettings() async {
    setState(() {
      isLoading = true; // Set loading to true during settings update
    });
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(userEmailController.text);
        await user.updatePassword(userPasswordController.text);
        setState(() {
          isLoading = false; // Reset loading state
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Settings updated successfully!'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Reset loading state
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating settings: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImageFromGallery, // Change the onTap to allow picking an image from the gallery
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePicUrl),
                  child: isLoading
                      ? CircularProgressIndicator() // Show loading indicator while uploading
                      : Icon(Icons.camera_alt, size: 40, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: userEmailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    userEmail = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: userPasswordController,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    userPassword = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _updateSettings, // Disable the button if loading
              child: isLoading
                  ? CircularProgressIndicator() // Show loading indicator if settings are being updated
                  : Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}