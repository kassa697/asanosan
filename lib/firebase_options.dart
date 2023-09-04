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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCn4bHXL2_4ytd-d3BMTSRStFfPeMZPUcA',
    appId: '1:595210072308:web:c67baa03cff01a2733eea1',
    messagingSenderId: '595210072308',
    projectId: 'cargobridge-ff5ec',
    authDomain: 'cargobridge-ff5ec.firebaseapp.com',
    storageBucket: 'cargobridge-ff5ec.appspot.com',
    measurementId: 'G-GJYE2KHE6D',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2lpw2AMoFAgtomur-mGN_BLFmHXVjcHE',
    appId: '1:595210072308:ios:0895e572e4c45a8a33eea1',
    messagingSenderId: '595210072308',
    projectId: 'cargobridge-ff5ec',
    storageBucket: 'cargobridge-ff5ec.appspot.com',
    iosClientId: '595210072308-ulbmsesdh9kqinv6eo795ckj26l659lt.apps.googleusercontent.com',
    iosBundleId: 'com.example.carGoBridge',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2lpw2AMoFAgtomur-mGN_BLFmHXVjcHE',
    appId: '1:595210072308:ios:0895e572e4c45a8a33eea1',
    messagingSenderId: '595210072308',
    projectId: 'cargobridge-ff5ec',
    storageBucket: 'cargobridge-ff5ec.appspot.com',
    iosClientId: '595210072308-ulbmsesdh9kqinv6eo795ckj26l659lt.apps.googleusercontent.com',
    iosBundleId: 'com.example.carGoBridge',
  );
}
