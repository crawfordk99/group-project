import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream

=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart'; // Add the image_picker package
>>>>>>> Stashed changes

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
<<<<<<< Updated upstream
  // Example user profile information (can be replaced with real data)
  String profilePicUrl = 'https://example.com/profile-pic.jpg'; // Replace with your image URL
  String userName = 'John Doe';
  String userEmail = 'john.doe@example.com';
  String userPassword = 'Passw0rd!';
  bool enableNotifications = true;  // For notifications switch
  bool isProfilePrivate = true;     // For profile privacy switch

  // Declare the TextEditingController for each field
  late TextEditingController userNameController;
  late TextEditingController userEmailController;
  late TextEditingController userPasswordController;

  // Function to handle profile picture change (add your logic here)
  void _changeProfilePic() {
    // Example action: You can add logic to open image picker here
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Change profile picture')));
  }

  void _saveSettings() {
    // Example: You can add logic to save the updated profile info
    setState(() {
      userName = userNameController.text;
      userEmail = userEmailController.text;
      userPassword = userPasswordController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings saved')));
  }
=======
  String profilePicUrl = 'https://example.com/profile-pic.jpg'; // Default image URL
  String userEmail = '';
  String userPassword = '';

  late TextEditingController userEmailController;
  late TextEditingController userPasswordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late File _profilePicFile;
  bool isLoading = false; // Loading state for image upload or settings update
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
<<<<<<< Updated upstream
    // Initialize the controllers with current user data
    userNameController = TextEditingController(text: userName);
=======
>>>>>>> Stashed changes
    userEmailController = TextEditingController(text: userEmail);
    userPasswordController = TextEditingController(text: userPassword);
    _fetchUserDetails();
  }

  @override
  void dispose() {
<<<<<<< Updated upstream
    // Dispose of the controllers when the widget is disposed to prevent memory leaks
    userNameController.dispose();
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
        backgroundColor: Colors.blue,
>>>>>>> Stashed changes
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
<<<<<<< Updated upstream
            // Profile Picture Section
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
            // Name Field
            TextField(
              controller: userNameController,
              onChanged: (value) {
                setState(() {
                  userName = value; // Update userName when edited
                });
              },
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Email Field
            TextField(
              controller: userEmailController,
              onChanged: (value) {
                setState(() {
                  userEmail = value; // Update userEmail when edited
                });
              },
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            // Password Field
            TextField(
              controller: userPasswordController,
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  userPassword = value; // Update userPassword when edited
                });
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Save Changes Button
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Changes'),
            ),
            SizedBox(height: 16),
            // Additional Settings Section
            Text(
              'Additional Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: enableNotifications, // State for notifications
              onChanged: (bool value) {
                setState(() {
                  enableNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Make Profile Private'),
              value: isProfilePrivate, // State for profile privacy
              onChanged: (bool value) {
                setState(() {
                  isProfilePrivate = value;
                });
              },
            ),
            SizedBox(height: 16),
            // Log Out Button
            ElevatedButton(
              onPressed: () {
                // Log out action
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged Out')));
              },
              child: Text('Log Out'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB71C1C)),
=======
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
>>>>>>> Stashed changes
            ),
          ],
        ),
      ),
    );
  }
}
