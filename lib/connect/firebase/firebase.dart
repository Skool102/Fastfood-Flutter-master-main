//------------------------------------Firebase----------------------------------------------//
import 'dart:io';
import 'package:fastfood/connect/firebase/exec_message.dart';
import 'package:fastfood/connect/firebase/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class StartFirebase {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    StartNotification.showRemoteMessage(message);
  }

  static Future<void> configFirebase() async {
    FirebaseMessaging.onBackgroundMessage(
        StartFirebase.firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ExecMessage.getValues(message);
      StartNotification.showRemoteMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        ExecMessage.exec(message);
      },
    );
  }

  static Future<void> initFirebase() async {
    try {
      var firebaseOption = Platform.isIOS
          ? const FirebaseOptions(
              apiKey: "AIzaSyCe0n7LVqGymcvjQBpAIya2lflKDsrsg50",
              appId: "1:142740881779:android:87670f0a48789f36708506",
              messagingSenderId: "142740881779",
              projectId: "fastfood-62b85",
              storageBucket: "fastfood-62b85.appspot.com")
          : const FirebaseOptions(
              apiKey: "AIzaSyCe0n7LVqGymcvjQBpAIya2lflKDsrsg50",
              appId: "1:142740881779:android:87670f0a48789f36708506",
              messagingSenderId: "142740881779",
              projectId: "fastfood-62b85",
              storageBucket: "fastfood-62b85.appspot.com");

      await Firebase.initializeApp(
        options: firebaseOption,
      );
      // ignore: empty_catches
    } catch (error) {}

    // ignore: unused_local_variable
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getToken().then(
      (String? token) async {
        // ignore: prefer_conditional_assignment
      },
    );
  }

  static Future<String?> getAccessToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  static Future<RemoteMessage?> getMessage() {
    return FirebaseMessaging.instance.getInitialMessage();
  }
}
