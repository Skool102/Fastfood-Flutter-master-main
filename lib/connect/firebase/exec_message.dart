import 'package:fastfood/connect/firebase/global_params.dart';
import 'package:fastfood/widgets/bottom_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ExecMessage {
  static void exec(RemoteMessage message) {
    var navigatorKey = GlobalParams.getGlobalKeyNavigatorState();

    if (navigatorKey.currentState != null) {
      Navigator.pushReplacement(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => RBottomNavigationBar(),
        ),
      );
    }
  }

  static List<Widget> getValues(RemoteMessage? message) {
    List<Widget> values = [];

    if (message != null) {
      if (message.notification != null) {
        values.add(Text(message.notification!.body ?? ""));
      }
    } else {
      values.add(const Text("Content"));
    }

    return values;
  }
}
