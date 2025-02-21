import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with current user data
    userNameController = TextEditingController(text: userName);
    userEmailController = TextEditingController(text: userEmail);
    userPasswordController = TextEditingController(text: userPassword);
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to prevent memory leaks
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Picture Section
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
            ),
          ],
        ),
      ),
    );
  }
}
