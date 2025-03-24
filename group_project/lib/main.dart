import 'package:flutter/material.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_project/loginPage.dart';
import 'package:group_project/home_screen.dart';

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

FirebaseAuthService _authService = FirebaseAuthService();
class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Media App',
        home: StreamBuilder<User?>(
        stream: _authService.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();  // While Firebase is loading
          }

          // If the user is logged in, show the HomeScreen
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
          // If the user is not logged in, show the LoginPage
            return MyHomePage();
          }
        },
      ),
    );
  }
}




