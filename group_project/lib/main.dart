import 'package:flutter/material.dart';
import 'home.dart'; // Import home.dart
import 'settings.dart'; // Import settings.dart
import 'gallery.dart'; // Import gallery.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'key',
        appId: 'id',
        messagingSenderId: 'sendid',
        projectId: 'group_app',
        storageBucket: 'myapp-b9yt18.appspot.com',
      ),
    );

    FirebaseAuth.instance.useAuthEmulator('0.0.0.0', 9099);
    FirebaseStorage.instance.useStorageEmulator('0.0.0.0', 9199);
    FirebaseFirestore.instance.useFirestoreEmulator('0.0.0.0', 8080);
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Media App',
        home: const MainScreen(),
        theme: AppTheme.lightTheme
    );
  }
}




