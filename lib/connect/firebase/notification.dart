//------------------------------------Notifi---------------------------------------------//

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:fastfood/connect/firebase/global_params.dart';
import 'package:fastfood/connect/firebase/notifi_message.dart';
import 'package:fastfood/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import 'exec_message.dart';

class StartNotification {
  static Future<void> configNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings);

    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      onTapLocalNotification(notificationAppLaunchDetails.notificationResponse);
    }

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapLocalNotification,
    );
  }

    static void requestPermission() {
    var notificationsPlugin = GetIt.instance<FlutterLocalNotificationsPlugin>();

    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void showRemoteMessage(
    RemoteMessage message,
  ) {
    var notify = NotifyMessage.fromJson(message.data);
    var title = message.notification!.title ?? notify.sender?.name;

    _showNotification(
      message.hashCode,
      title,
      message.notification!.body,
      json.encode(
        {
          "title": title,
          "body": message.notification!.body,
          "data": json.encode(message.data)
        },
      ),
    );
  }


  // static void showRemoteMessage(RemoteMessage message) {
  //   var notify = NotifyMessage.fromJson(message.data);

  //   showNotification(
  //     message.hashCode,
  //     message.notification!.title ?? notify.sender?.name,
  //     message.notification!.body,
  //   );
  // }

    static void _showNotification(
    int hashCode,
    String? title,
    String? body,
    String payload,
  ) {
    var notificationsPlugin = GlobalParams.getLocalNotificationsPlugin();

    notificationsPlugin.show(
      hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'thongbao.net.vn',
          'Thông báo',
          importance: Importance.high,
          enableVibration: true,
          playSound: true,
          timeoutAfter: 1000,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'slow_spring_board.aiff',
        ),
      ),
      payload: payload,
    );
  }

  // static void showNotification(int hashCode, String? title, String? body) {
  //   notificationsPlugin.show(
  //     hashCode,
  //     title,
  //     body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails('thongbao.net.vn', 'Thông báo',
  //           importance: Importance.high,
  //           enableVibration: true,
  //           playSound: true,
  //           timeoutAfter: 1000),
  //       iOS: DarwinNotificationDetails(sound: 'slow_spring_board.aiff'),
  //     ),
  //   );
  // }

  static void onTapLocalNotification(
      NotificationResponse? notificationResponse) async {
    if (notificationResponse != null) {
      final String? payload = notificationResponse.payload;

      if (payload != null) {
        var mapValues = json.decode(payload);

        RemoteMessage message = RemoteMessage(
          notification: RemoteNotification(
            title: mapValues["title"],
            body: mapValues["body"],
          ),
          data: json.decode(mapValues["data"]),
        );

        ExecMessage.exec(message);
      }
    }
  }
}

//------------------------------------Notifi----------------------------------------------//