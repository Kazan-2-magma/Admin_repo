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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAz_mvbMPpbJ1l4uGNoXL5ZVvEtq1Z28A8',
    appId: '1:915635564483:web:58eef5ffe6018da0b3d776',
    messagingSenderId: '915635564483',
    projectId: 'admin-manager-app',
    authDomain: 'admin-manager-app.firebaseapp.com',
    storageBucket: 'admin-manager-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWCa0kDkATv20nnpaU9eMK05bmMHdJK-E',
    appId: '1:915635564483:android:3723b80514a9a4b7b3d776',
    messagingSenderId: '915635564483',
    projectId: 'admin-manager-app',
    storageBucket: 'admin-manager-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDLGEWj02M3VlTnTS-J-yBrWRNOhxjp5w',
    appId: '1:915635564483:ios:9baeb043e5288670b3d776',
    messagingSenderId: '915635564483',
    projectId: 'admin-manager-app',
    storageBucket: 'admin-manager-app.appspot.com',
    iosBundleId: 'com.example.adminManager',
  );
}
