import 'package:fastfood/connect/cart/cart_controller.dart';
import 'package:fastfood/connect/firebase/firebase.dart';
import 'package:fastfood/connect/firebase/global_params.dart';
import 'package:fastfood/connect/firebase/notification.dart';
import 'package:fastfood/models/home_model.dart';
import 'package:fastfood/models/user/user_model.dart';
import 'package:fastfood/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'models/globalCart.dart';

int? isManager;
User? userLogin;
final FlutterLocalNotificationsPlugin notificationsPlugin =
    GlobalParams.getLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'fastFood', 'Thông báo', // title, // description
  importance: Importance.high,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StartNotification.configNotification();

  await StartFirebase.configFirebase();

  await StartFirebase.initFirebase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeModel()),
      ChangeNotifierProvider(create: (_) => Cart()),
      ChangeNotifierProvider<CartController>(create: (_) => CartController())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: RBottomNavigationBar(),
    );
  }
}

//RBottomNavigationBar()

