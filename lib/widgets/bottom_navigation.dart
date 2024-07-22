import 'dart:convert';

import 'package:fastfood/connect/config/user/user_data_component.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/views/HomeView.dart';
import 'package:fastfood/views/product/product_view.dart';
import 'package:fastfood/views/user/my_orders.dart';
import 'package:fastfood/views/user/notification.dart';
import 'package:fastfood/views/user/wishlist.dart';
import 'package:flutter/material.dart';
import '../views/user/cart/bottom_cart_view.dart';

// ignore: use_key_in_widget_constructors
class RBottomNavigationBar extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RBottomNavigationBar());
  }

  @override
  // ignore: library_private_types_in_public_api
  _RBottomNavigationBar createState() => _RBottomNavigationBar();
}

class _RBottomNavigationBar extends State<RBottomNavigationBar> {
  int _currentIndex = 0;

  void setUser() async {
    var token = await UserDataComponent().getAppToken();
    if (token != null) {
      var userJson = await UserDataComponent().getAppUser();
      if (userJson != null) {
        var user = json.decode(userJson);
        userLogin = user;
      }
    }
  }

  final List<Widget> _children = [
    const HomeView(),
    userLogin != null
        ? userLogin!.isManager == 0
            ? Wishlist()
            : AddProductView()
        : Wishlist(),
    MyOrders(),
    BottomCartView(),
    Notifications(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: CommonColors.primaryColor,
        unselectedItemColor: CommonColors.primaryTextColor,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: userLogin != null
                ? userLogin!.isManager == 1
                    ? 'Thêm món'
                    : 'Yêu thích'
                : 'Yêu thích',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Đơn hàng',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Giỏ hàng',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Thông báo',
          ),
        ],
      ),
    );
  }
}
