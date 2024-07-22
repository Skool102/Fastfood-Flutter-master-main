import 'package:fastfood/views/login/layouts/login_layout.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final viewKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoginLayout();
  }
}
