import 'package:fastfood/main.dart';
import 'package:fastfood/utils/constant.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/home_model.dart';
import '../../utils/CommonColors.dart';

// ignore: use_key_in_widget_constructors
class Wishlist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Wishlist();
}

class _Wishlist extends State<Wishlist> {
  bool isfavorite = true;
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<HomeModel>(context).products;
    return userLogin != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              flexibleSpace: Container(
                padding:
                    const EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const Text(AppConstants.wishlist,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 240.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: const AssetImage(
                                LocalImages.offer_overlay,
                              ),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.75),
                                  BlendMode.screen)),
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 12.0,
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      LocalImages.ic_rating,
                                      height: 25.0,
                                    ),
                                    const SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(products[index].rating,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color:
                                                CommonColors.primaryTextColor)),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        isfavorite = !isfavorite;
                                      });
                                    },
                                    child: Icon(
                                      isfavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: CommonColors.primaryColor
                                          .withOpacity(0.7),
                                      size: 25,
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                products[index].image,
                                width: 100.0,
                              ),
                              const SizedBox(
                                width: 50.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[index].name,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              CommonColors.primaryTextColor)),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: CommonColors.primaryTextColor,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(products[index].duration,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(products[index].price.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          LocalImages.ic_add,
                                          width: 30.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text('Bạn chưa đăng nhập'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: const Text('Về trang đăng nhập'))
                ],
              ),
            ),
          );
  }
}
