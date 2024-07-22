import 'dart:math';

import 'package:fastfood/connect/config/user/user_data_component.dart';
import 'package:fastfood/connect/user/user_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/user/signupView.dart';
import 'package:fastfood/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginLayout extends StatefulWidget {
  LoginLayout({Key? key}) : super(key: key);
  GlobalKey<FormState>? viewKey;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _LoginLayout();
}

class _LoginLayout extends State<LoginLayout> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = !passwordVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RBottomNavigationBar()),
                  );
                },
                child: Image.asset(
                  LocalImages.ic_back,
                  width: 50.0,
                  height: 50,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        child: ListView(
          children: [
            Image.asset(
              LocalImages.logo1,
              height: 200,
            ),
            TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: 'Tài khoản',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Quên mật khẩu',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Implement forget password functionality here
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var data = await UserConnectDB.getAlluser();
                    var value = data!
                        .where((e) =>
                            e.userName
                                .contains(userNameController.value.text) &&
                            e.passWord.contains(passwordController.value.text))
                        .firstOrNull;
                    if (value != null) {
                      userLogin = value;
                      isManager = value.isManager;
                      var r = Random();
                      String randomString = String.fromCharCodes(
                          List.generate(20, (index) => r.nextInt(33) + 89));

                      // dùng để lưu token xuống library, lần bật app tiếp theo sẽ không phải login
                      await UserDataComponent().setAppToken(randomString);
                      await UserDataComponent()
                          .setEncrptedAuthToken(randomString);
                      // await UserDataComponent()
                      //     .setAppUser(json.encode(userLogin));

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RBottomNavigationBar()));
                    } else {
                      // ignore: use_build_context_synchronously
                      await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Icon(Icons.warning_rounded, color: AppStyle.colors[2][3],),
                          content:const Text('Sai mật khẩu hoặc tài khoản'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: CommonColors.primaryColor
                        .withOpacity(0.7), // Text color
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    CommonColors.primaryColor.withOpacity(0.7), // Text color
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
