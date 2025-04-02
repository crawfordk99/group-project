import 'package:flutter/material.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_project/loginPage.dart';
import 'package:group_project/main_screen.dart';




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

    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

    // final originalDebugPrint = debugPrint;
    // debugPrint = (String? message, {int? wrapWidth}){
    //   if(message != null && message.contains('you are using the aith emulator'))
    //     {return;}
    //   originalDebugPrint{message, wrapWidth: wrapWidth);
    // };

    runApp(const MyApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }


}

final FirebaseAuthService _authService = FirebaseAuthService();
class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
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
            return const MainScreen();
          } else {
          // If the user is not logged in, show the LoginPage
            return MyHomePage();
          }
        },
      ),
    );
  }
}




