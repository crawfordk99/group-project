import 'package:flutter/material.dart';
import 'colors.dart'; // Ensure this file contains your custom colors

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String profilePicUrl = 'https://example.com/profile-pic.jpg'; // Replace with actual image URL
  String userName = 'John Doe';
  String userEmail = 'john.doe@example.com';
  String userPassword = 'Passw0rd!';
  bool enableNotifications = true;
  bool isProfilePrivate = true;

  late TextEditingController userNameController;
  late TextEditingController userEmailController;
  late TextEditingController userPasswordController;

  void _changeProfilePic() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Change profile picture')));
  }

  void _saveSettings() {
    setState(() {
      userName = userNameController.text;
      userEmail = userEmailController.text;
      userPassword = userPasswordController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings saved')));
  }

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: userName);
    userEmailController = TextEditingController(text: userEmail);
    userPasswordController = TextEditingController(text: userPassword);
  }

  @override
  void dispose() {
    userNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        backgroundColor: AppColors.secondary, // 🔹 Custom Color from colors.dart
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 🔹 Profile Picture Section
            Center(
              child: GestureDetector(
                onTap: _changeProfilePic,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePicUrl),
                  child: Icon(Icons.camera_alt, size: 40, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🔹 Name Field with White Background
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // ⬜ White background
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: userNameController,
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white, // ⬜ Ensures white background
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🔹 Email Field with White Background
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // ⬜ White background
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
                  fillColor: Colors.white, // ⬜ Ensures white background
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🔹 Password Field with White Background
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // ⬜ White background
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
                  fillColor: Colors.white, // ⬜ Ensures white background
                ),
              ),
            ),
            SizedBox(height: 16),

            // 🔹 Save Changes Button
            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navigation,
                foregroundColor: AppColors.text
                // 🔹 Custom Color from colors.dart
              ),
            ),
            SizedBox(height: 16),

            // 🔹 Additional Settings
            Text(
              'Additional Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text),
            ),
            SwitchListTile(
              title: Text('Enable Notifications', style: TextStyle(color: AppColors.text)),
              value: enableNotifications,
              onChanged: (bool value) {
                setState(() {
                  enableNotifications = value;
                });
              },
              activeColor: AppColors.text,
            ),
            SwitchListTile(
              title: Text('Make Profile Private',
                  style: TextStyle(color: AppColors.text)),

              value: isProfilePrivate,
              onChanged: (bool value) {
                setState(() {
                  isProfilePrivate = value;
                });
              },
              activeColor: AppColors.text,
            ),
            SizedBox(height: 16),

            // 🔹 Log Out Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged Out')));
              },
              child: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navigation,
                foregroundColor: AppColors.text// 🔹 Custom Color from colors.dart
              ),
            ),
          ],
        ),
      ),
    );
  }
}
