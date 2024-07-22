import 'package:fastfood/connect/user/user_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/user/user_model.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/menu/menu_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  UserProfile({Key? key, bool? viewLayout}) : super(key: key);
  GlobalKey<FormState>? viewKey;

  @override
  State<StatefulWidget> createState() => _UserProfileLayout();
}

class _UserProfileLayout extends State<UserProfile> {
  User? user;

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
                  Navigator.pop(context);
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
      drawer: Drawer(
        child: MenuView(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              LocalImages.avatar,
              height: 200,
            ),
            TextFormField(
              controller: TextEditingController(text: userLogin!.userName),
              enabled: false,
              focusNode: FocusNode(),
              decoration: const InputDecoration(
                labelText: 'Tên tài khoản',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: TextEditingController(text: userLogin!.numberPhone),
              decoration: const InputDecoration(
                labelText: 'Sdt',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: TextEditingController(text: userLogin!.email),
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: TextEditingController(text: userLogin!.passWord),
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await UserConnectDB.updateuser(userLogin!)
                    .then((value) => Navigator.pop(context));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    CommonColors.primaryColor.withOpacity(0.7), // Text color
              ),
              child: const Text('Cập nhật thông tin'),
            ),
          ],
        ),
      ),
    );
  }
}
