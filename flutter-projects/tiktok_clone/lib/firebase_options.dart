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
    apiKey: 'AIzaSyBY5RbTATpTRe5gBEkUm4Z5UrWP1lxTuO0',
    appId: '1:650417211116:web:d37d7c4c68992cee6907c9',
    messagingSenderId: '650417211116',
    projectId: 'tiktok-clone-2024',
    authDomain: 'tiktok-clone-2024.firebaseapp.com',
    storageBucket: 'tiktok-clone-2024.appspot.com',
    measurementId: 'G-SM1METBT9P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfufZ2S5XXQbPXpkoxgnpVcJ9SPj3Af4w',
    appId: '1:650417211116:android:b974736e4c8c48476907c9',
    messagingSenderId: '650417211116',
    projectId: 'tiktok-clone-2024',
    storageBucket: 'tiktok-clone-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFbWryaRR-XWrqom01ZWxhv6EKOguGfrI',
    appId: '1:650417211116:ios:63539f2aed73f7716907c9',
    messagingSenderId: '650417211116',
    projectId: 'tiktok-clone-2024',
    storageBucket: 'tiktok-clone-2024.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}