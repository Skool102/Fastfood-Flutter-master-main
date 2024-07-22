import 'package:fastfood/main.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/views/login/login_view.dart';
import 'package:fastfood/views/user/cart/bottom_cart_view.dart';
import 'package:fastfood/views/user/my_orders.dart';
import 'package:fastfood/views/user/notification.dart';
import 'package:fastfood/views/user/signupView.dart';
import 'package:fastfood/views/user/user_profile.dart';
import 'package:fastfood/views/user/wishlist.dart';
import 'package:flutter/material.dart';

import '../../../utils/local_images.dart';

// ignore: must_be_immutable
class MenuLayout extends StatelessWidget {
  GlobalKey<FormState>? viewKey;
  // ignore: unused_field
  final BuildContext? _context;

  // ignore: use_key_in_widget_constructors
  MenuLayout(GlobalKey<FormState>? key, BuildContext? context)
      : _context = context,
        super() {
    key = viewKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          userLogin != null
              ? UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: CommonColors.primaryColor.withOpacity(0.7)),
                  accountName:
                      Text(userLogin!.userName), // Replace with user's name
                  accountEmail: Text(
                      userLogin!.email.toString()), // Replace with user's email
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage(
                        LocalImages.avatar), // Replace with user's avatar image
                  ),
                )
              : UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: CommonColors.primaryColor.withOpacity(0.7)),
                  accountName: const Text(''), // Replace with user's name
                  accountEmail: const Text(''), // Replace with user's email
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage(LocalImages
                        .avatarNotLogin), // Replace with user's avatar image
                  ),
                ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Thông tin'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text('Thông báo'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('Đơn hàng'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrders()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Yêu thích'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: const Text('Giỏ hàng'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomCartView()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Cài đặt'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          userLogin == null
              ? Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.login),
                      title: const Text('Đăng nhập'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.how_to_reg_sharp),
                      title: const Text('Đăng ký'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                  ],
                )
              : ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Đăng Xuất'),
                  onTap: () {
                    userLogin = null;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
