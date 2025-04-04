# Overview
Hidden Gem is a social media app that enables users to create and share a variety of posts. When the app launches, users are greeted with an authentication page. If they already have an account linked to Gmail, they can simply log in; otherwise, new users must create an account using a Gmail address and a strong password of at least six characters. Once authenticated, users can explore different sections of the app, such as account settings, post creation, a gallery, and a home page where they can view posts from other users. Future updates will include features for creating post-specific prompts and setting reminders to encourage regular posting.

# Running the Software

Before running the app, users must ensure that all required software is installed on their computer. This includes Flutter, Firebase, the Firebase CLI, Android Studio (for Windows users), and Java. Additionally, users should verify that the latest version of Firebase is installed.

Once the necessary software is installed, follow these steps:

1. **Start the Firebase Emulator:**  
   Open a terminal and run the following command:
   ```
   firebase emulators:start --import=.\emulator-data --export-on-exit=.\emulator-data
   ```
   **Note:** The command to start the emulators is provided in this Markdown file. However, if you choose to run it manually, be aware that the file path syntax may need to be adjusted depending on your operating system. Windows users should use backslashes (`.\emulator-data`), while Mac users should replace them with forward slashes (`./emulator-data`). Additionally, you can find a copy of this command at the bottom of the `start_emulators.bat` and `start_emulators.sh` files for convenience.

2. **Launch the App:**  
   Open a new terminal and run:
   ```
   flutter run
   ```

For Mac users, a script named `start_emulators.sh` is provided. It can be executed by entering `./start_emulators.sh` in the command line.

For Windows users, a script named `start_emulators.bat` is available. Based on available instructions, it may be necessary to double-click the file to start the process. If that does not work, users can copy the Firebase command provided at the bottom of the script to start the emulators manually.

This configuration ensures that data is saved locally during testing while maintaining a smooth startup process.


[Software Demo Video](http://youtube.link.goes.here)

# Development Environment

This code was written in Dart using the Flutter framework, which provides a robust and efficient platform for building cross-platform mobile applications. The development environment is an integrated ecosystem that allows developers to write, test, and deploy code. In this setup, every tool has a clear job. Flutter and Dart are used to write the app’s code. Android Studio is where developers write and debug their code. Firebase handles the back-end services, while Java makes sure the app works smoothly on Android devices. Extra packages like image_picker and intl.dart add features for image handling and adapting the app for different languages.

- Flutter & Dart
- Android Studio
- Firebase
- image_picker
- intl.dart
- Java

# Collaborators

- Henry Bondah
- Jordan Bodily
- Keith Crawford
- Natalia Navarrete
- Cesar Tavarez
- Sully Tuft

# Useful Websites

* [dart.dev](https://dart.dev/)
* [Flutter Docs](https://docs.flutter.dev/get-started/fundamentals/dart)
* [Flutter on Mac installation](https://dev.to/rubyc/install-flutter-on-macos-apple-silicon-52b8)
* [Flutter on Windows installation](https://medium.com/@blup-tool/step-by-step-guide-to-installing-flutter-and-dart-on-windows-b30a631e7583)


# Future Work

* **Create Prompts for User Interaction**: Interactive prompts will be implemented to guide users and enhance engagement.
* **Implement Private Profiles and Notifications**: The app will support private profiles and real-time notifications for a more personalized experience. 
* **Create a Profile Page for Individual User Posts**: A dedicated profile page will be developed where users can view and manage only their own posts.
