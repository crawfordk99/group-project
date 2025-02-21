import 'package:flutter/material.dart';
import 'home.dart'; // Import home.dart
import 'settings.dart'; // Import settings.dart
import 'gallery.dart'; // Import mail.dart

void main() => runApp(const MyApp());

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
    GalleryPage(), // MailPage from mail.dart
    SettingsPage(), // SettingsPage from settings.dart
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
            icon: Icon(Icons.photo_library),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFB71C1C),
        onTap: _onItemTapped,
      ),
    );
  }
}
