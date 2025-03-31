import 'package:flutter/material.dart';
import 'home_screen.dart';  // Import the HomeScreen
import 'post_screen.dart';  // Import the CreatePostScreen
import 'settings.dart';  // Import the SettingsScreen
import 'theme.dart'; // Import the custom theme if needed
import 'colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Tracks which tab is active

  // List of actual screens to navigate to
  final List<Widget> _screens = [
    const HomeScreen(),  // Home screen
    CreatePostScreen(),  // Screen for creating a post
    SettingsPage(),  // Settings screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the active screen based on the bottom nav
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],  // Switch between screens based on selected index

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, size: 32), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
