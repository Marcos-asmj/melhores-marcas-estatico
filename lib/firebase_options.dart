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
    apiKey: 'AIzaSyCA77gdgPFKZaQUKdeiS8yirRsn5eoMqJc',
    appId: '1:631034627803:web:edea92b0b00aabcb1faefe',
    messagingSenderId: '631034627803',
    projectId: 'melhores-marcas-e40ef',
    authDomain: 'melhores-marcas-e40ef.firebaseapp.com',
    storageBucket: 'melhores-marcas-e40ef.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzCBTjBiNeh52k2JucIHxR9Rsv_-iLxV0',
    appId: '1:631034627803:android:46b35804e98923541faefe',
    messagingSenderId: '631034627803',
    projectId: 'melhores-marcas-e40ef',
    storageBucket: 'melhores-marcas-e40ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9uJ05EQvEN7QzXUug9VWxOmqC9J73nmI',
    appId: '1:631034627803:ios:493e50f559b866d01faefe',
    messagingSenderId: '631034627803',
    projectId: 'melhores-marcas-e40ef',
    storageBucket: 'melhores-marcas-e40ef.appspot.com',
    iosClientId: '631034627803-uvebvb7ruirsp57qqrd0dqms6nmbmdph.apps.googleusercontent.com',
    iosBundleId: 'com.example.marcasEstatico',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9uJ05EQvEN7QzXUug9VWxOmqC9J73nmI',
    appId: '1:631034627803:ios:493e50f559b866d01faefe',
    messagingSenderId: '631034627803',
    projectId: 'melhores-marcas-e40ef',
    storageBucket: 'melhores-marcas-e40ef.appspot.com',
    iosClientId: '631034627803-uvebvb7ruirsp57qqrd0dqms6nmbmdph.apps.googleusercontent.com',
    iosBundleId: 'com.example.marcasEstatico',
  );
}