# group-project
# Installation Procedures

Here's some helpful links if the main Flutter/Firebase/Firebase CLI/Android Studio/Java set ups don't make sense enough

## Flutter
- [Flutter on Mac installation](https://dev.to/rubyc/install-flutter-on-macos-apple-silicon-52b8)
- [Flutter on Windows installation](https://medium.com/@blup-tool/step-by-step-guide-to-installing-flutter-and-dart-on-windows-b30a631e7583)

## Firebase and Firebase CLI

Normally, you would create a project on Firebase first. However, for now we are just worrying about developing locally, so we
are using the emulators for this project. First you have to set up the command line tools for Firebase. For Mac, as long as
you have bash or npm command line tools, it's pretty simple and you can just look up the Firebase CLI installation page. For Windows,
here's the steps if you don't have npm/node.js installed.

- Open the Start Menu and search for "Environment Variables", then select "Edit the system environment variables".
- In the System Properties window, click on the "Environment Variables" button.
- Under System Variables, locate and select the Path variable, then click Edit.
- Click New and add the full path to the directory where firebase.exe is located (e.g., C:\firebase-tools\).
- Click OK to save your changes and close all dialogs.

## Android Studio

Download the latest one. For Windows users, make sure they all have the same version or it can create problems.

## Dart Configuration

When you clone the Flutter project, go to lib, and find main.dart. If it's giving you a warning up top that it doesn't have
your dart configuration here's the steps to fix that (note for Mac users, this is also in the installation link I shared)

- Find your Android Studio Settings
- Find Languages and Frameworks section
- Go to Dart section
- Enable support for your project at the top
- Find the folder you have Flutter in (you can find the flutter path in the Flutter section of your Android Studio settings)
- Put in the Dart SDK path your path to the Dart (add this on top of the path to your Flutter folder, /bin/cache/dart-sdk)
- Then below that you have to click enable support for all the folders/files for your project

## Java



# Starting app with Firebase emulators

1. Start firebase emulators in one terminal
2. Create a new terminal and type in flutter run in the other

For Mac users, I have created start_emulators.sh which you run simply by adding ./start_emulators.sh in the command line.
For Windows users, I have created start_emulators.bat. From what I have learned, you have to click twice on the file to start
it, but I'm not sure yet how that looks. Worst case you can just copy the firebase line at the bottom to start the emulators.
This script I have created allows us to save data locally while we're testing.

# Hosting rules

If for some reason you want to test run it on the web browser instead of the Android phone emulator, you'll have to change in
the firebase.json every emulator that has a host to "localhost" instead of "0.0.0.0". You'll also have to go to main.dart
and change each firebase instance to local host as well. This is required because Firebase and the Flutter app have to pointing
to the same host in order to work together.

