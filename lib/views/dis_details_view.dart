import 'dart:math';

import 'package:fastfood/connect/cart/cart_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/cart/cart_model.dart';
import 'package:fastfood/models/product.dart';
import 'package:fastfood/views/login/login_view.dart';
import 'package:fastfood/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/utils/local_images.dart';

import '../utils/CommonColors.dart';

// ignore: must_be_immutable
class DishDetailsView extends StatefulWidget {
  DishDetailsView({Key? key, Product? product})
      : _product = product,
        super(key: key);

  Product? _product;
  @override
  State<DishDetailsView> createState() => _DishDetailsView(_product);
}

class _DishDetailsView extends State<DishDetailsView> {
  bool isFavorite = false;

  _DishDetailsView(this._product);

  Product? _product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  foregroundDecoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            LocalImages.dish,
                          ),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0))),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage(
                          LocalImages.offer_overlay,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.75), BlendMode.screen)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      InkWell(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: CommonColors.primaryColor,
                              size: 30,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text('Ăn chay',
                      style: TextStyle(
                          fontSize: 11, color: Colors.green.shade800)),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_product!.title.toString(),
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: CommonColors.primaryTextColor)),
                      InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: CommonColors.primaryTextColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text('Thêm',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text('2.4 Km ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: CommonColors.primaryTextColor)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              LocalImages.ic_rating,
                              height: 20.0,
                            ),
                            const Text(' 4.5 ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: CommonColors.primaryTextColor)),
                          ]),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Mô tả",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: CommonColors.primaryTextColor)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(_product!.description.toString(),
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: CommonColors.primaryTextColor)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
          child: Row(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 2.5,
                alignment: Alignment.center,
                child: Text(_product!.price.toString(),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: CommonColors.primaryTextColor)),
              ),
              InkWell(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: CommonColors.primaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: () async {
                        if (userLogin == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        } else {
                          final id = (Random().nextInt(100) + 50);
                          final CartModel model = CartModel(
                              id: id,
                              productId: _product!.id,
                              price: _product!.price,
                              userId: userLogin!.id,
                              quantity: 1);

                          await CartConnectDB.addCart(model)
                              .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RBottomNavigationBar()),
                                  ));
                        }
                      },
                      child: const Text('Thêm vào giỏ hàng',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    ));
  }
}
