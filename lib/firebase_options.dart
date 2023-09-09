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
    apiKey: 'AIzaSyDui-u3qKvv3nSmKdNuB2a564ML8jzUUvo',
    appId: '1:88512570782:web:4e838e4ceb01099b7ce28f',
    messagingSenderId: '88512570782',
    projectId: 'asanosanapp',
    authDomain: 'asanosanapp.firebaseapp.com',
    storageBucket: 'asanosanapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ1Hpy_nX2P6yY2wIqWSZpZNzQBTieIYY',
    appId: '1:88512570782:android:39c92b4dd9ed86e87ce28f',
    messagingSenderId: '88512570782',
    projectId: 'asanosanapp',
    storageBucket: 'asanosanapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6oXG_8r_o0ShAKvlThB37dd_wrVluuCY',
    appId: '1:88512570782:ios:5ce6bd26915cea3e7ce28f',
    messagingSenderId: '88512570782',
    projectId: 'asanosanapp',
    storageBucket: 'asanosanapp.appspot.com',
    iosClientId: '88512570782-ji1i6v3oerko7n98dcvlu3q0r5g2gq4h.apps.googleusercontent.com',
    iosBundleId: 'com.example.carGoBridge',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6oXG_8r_o0ShAKvlThB37dd_wrVluuCY',
    appId: '1:88512570782:ios:5ce6bd26915cea3e7ce28f',
    messagingSenderId: '88512570782',
    projectId: 'asanosanapp',
    storageBucket: 'asanosanapp.appspot.com',
    iosClientId: '88512570782-ji1i6v3oerko7n98dcvlu3q0r5g2gq4h.apps.googleusercontent.com',
    iosBundleId: 'com.example.carGoBridge',
  );
}
