import 'package:flutter/material.dart';
import 'home.dart'; // Import home.dart
import 'settings.dart'; // Import settings.dart
import 'gallery.dart'; // Import mail.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: 'key',
      appId: 'id',
      messagingSenderId: 'sendid',
      projectId: 'group_app',
      storageBucket: 'myapp-b9yt18.appspot.com',
    ));

    FirebaseAuth.instance.useAuthEmulator('0.0.0.0', 9099);
    FirebaseStorage.instance.useStorageEmulator('0.0.0.0', 9199);

  }
  catch (e) {

  }

}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  // Create a list of widgets for each page
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(), // HomePage from home.dart
    SettingsPage(), // SettingsPage from settings.dart
    GalleryPage(), // MailPage from mail.dart
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden Gem', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6A0DAD),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Show the selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Gallery',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFB71C1C),
        onTap: _onItemTapped,
      ),
    );
  }
}
