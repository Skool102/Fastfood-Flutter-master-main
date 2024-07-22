import 'dart:math';

import 'package:fastfood/connect/user/user_connect.dart';
import 'package:fastfood/models/user/user_model.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:flutter/material.dart';

import '../../utils/local_images.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPhoneSignup = false;
  User? user;

  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _resendPassWordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  
  @override
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Image.asset(
              LocalImages.logo1,
              height: 200,
            ),
            if (!_isPhoneSignup)
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Tên tài khoản',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            const SizedBox(height: 20),
            if (_isPhoneSignup)
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Sdt',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
            if (_isPhoneSignup)
              TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  prefixIcon: Icon(Icons.security),
                ),
                keyboardType: TextInputType.number,
              ),
            if (!_isPhoneSignup)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passWordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (!_isPhoneSignup)
              TextFormField(
                controller: _resendPassWordController,
                decoration: const InputDecoration(
                  labelText: 'Xác nhận Password',
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
                    setState(() {
                      _isPhoneSignup = !_isPhoneSignup;
                    });
                  },
                  child: Text(
                    _isPhoneSignup ? 'Đăng ký bằng gmail' : 'Đăng ký bằng sdt',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.value.text;
                    final passWord = _passWordController.value.text;
                    final userName = _userNameController.value.text;
                    final fullName = _fullNameController.value.text;
                    final phone = _phoneController.value.text;
                    final userId = (Random().nextInt(100) + 50);
                    var isManager = 0;

                    if (email.isEmpty || passWord.isEmpty) {
                      return;
                    }
                    if (userName.contains('admin')) {
                      isManager = 1;
                    }
                    final User model = User(
                        id: userId,
                        email: email,
                        passWord: passWord,
                        userName: userName,
                        fullName: fullName,
                        numberPhone: phone,
                        isManager: isManager);

                    if (user == null) {
                      await UserConnectDB.adduser(model)
                          .then((value) => Navigator.pop(context));
                    } else {
                      await UserConnectDB.updateuser(model)
                          .then((value) => Navigator.pop(context));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: CommonColors.primaryColor
                        .withOpacity(0.7), // Text color
                  ),
                  child: const Text('Đăng ký'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
