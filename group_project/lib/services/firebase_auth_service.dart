import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Connect to the firebase emulator only in debug mode
  void connectAuthEmulator() {
    _auth.useAuthEmulator('localhost', 9099);
  }

  // Allows for checking to see whether the user has logged in or not
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  //
  Future<User?> createUser(String email, String password, String userName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = userCredential.user;

      if (user != null) {
        // Store additional user details in Firestore
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "userID": user.uid,
          "email": email,
          "username": userName
        });

        print("User created successfully!");
        return user;
      }
      return null;
    }
    catch (e) {
      print("Sign up error: $e");
      return null;
    }
  }

  Future<User?> logIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    }
    catch (e) {
      print("Sign up error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Stores the user's email, password, and userName in a dictionary/map
  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get the logged-in user

      if (user == null) {
        print("Error: No user is logged in.");
        return null;
      }

      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>; // Return user details as a map
      } else {
        print("Error: User document not found.");
        return null;
      }
    } catch (e) {
      print("Error fetching user details: $e");
      return null;
    }
  }
}