// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1-5G3_1ijdc-K6DzLsuKdZXhJ3HCDZFQ',
    appId: '1:156423456357:web:37dfd5b1ea44cc1159688c',
    messagingSenderId: '156423456357',
    projectId: 'flutter-project-ecbd6',
    authDomain: 'flutter-project-ecbd6.firebaseapp.com',
    storageBucket: 'flutter-project-ecbd6.appspot.com',
    measurementId: 'G-18PYC7PCH6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxc87xGC4U28sJ0ayAJkqRCLJdOznSYH4',
    appId: '1:156423456357:android:c54729d275bccf2459688c',
    messagingSenderId: '156423456357',
    projectId: 'flutter-project-ecbd6',
    storageBucket: 'flutter-project-ecbd6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCathjbDlkV2g7cehJY7EpX2ceNT3UjkgE',
    appId: '1:156423456357:ios:b263e54ba84d8fb459688c',
    messagingSenderId: '156423456357',
    projectId: 'flutter-project-ecbd6',
    storageBucket: 'flutter-project-ecbd6.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCathjbDlkV2g7cehJY7EpX2ceNT3UjkgE',
    appId: '1:156423456357:ios:98d4adc45beb4b6359688c',
    messagingSenderId: '156423456357',
    projectId: 'flutter-project-ecbd6',
    storageBucket: 'flutter-project-ecbd6.appspot.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}
