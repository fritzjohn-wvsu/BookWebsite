// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDIuJiwq_Ep0OosQLHcCKqNtaEMLn9mCa4',
    appId: '1:461275719842:web:c69970ba9dc7dca4598ffb',
    messagingSenderId: '461275719842',
    projectId: 'book-recommendation-webs-11149',
    authDomain: 'book-recommendation-webs-11149.firebaseapp.com',
    storageBucket: 'book-recommendation-webs-11149.firebasestorage.app',
    measurementId: 'G-GJPQY7QBSN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1CwwHv97TCsTbpTJ9kGN3ayCxyk2ldmA',
    appId: '1:461275719842:android:656e5a886cb1a4d1598ffb',
    messagingSenderId: '461275719842',
    projectId: 'book-recommendation-webs-11149',
    storageBucket: 'book-recommendation-webs-11149.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCotPErvFcamzsBH4TtTtSR4yXZf9DM0oI',
    appId: '1:461275719842:ios:45986ae70953b48f598ffb',
    messagingSenderId: '461275719842',
    projectId: 'book-recommendation-webs-11149',
    storageBucket: 'book-recommendation-webs-11149.firebasestorage.app',
    iosBundleId: 'com.example.main',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCotPErvFcamzsBH4TtTtSR4yXZf9DM0oI',
    appId: '1:461275719842:ios:45986ae70953b48f598ffb',
    messagingSenderId: '461275719842',
    projectId: 'book-recommendation-webs-11149',
    storageBucket: 'book-recommendation-webs-11149.firebasestorage.app',
    iosBundleId: 'com.example.main',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDIuJiwq_Ep0OosQLHcCKqNtaEMLn9mCa4',
    appId: '1:461275719842:web:46f58537aee77da6598ffb',
    messagingSenderId: '461275719842',
    projectId: 'book-recommendation-webs-11149',
    authDomain: 'book-recommendation-webs-11149.firebaseapp.com',
    storageBucket: 'book-recommendation-webs-11149.firebasestorage.app',
    measurementId: 'G-X3LTCXEV9Y',
  );
}
