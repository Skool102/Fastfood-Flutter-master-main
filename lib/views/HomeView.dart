import 'dart:math';

import 'package:fastfood/connect/cart/cart_connect.dart';
import 'package:fastfood/connect/cart/cart_controller.dart';
import 'package:fastfood/connect/product/product_connect.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/cart/cart_model.dart';
import 'package:fastfood/models/home_model.dart';
import 'package:fastfood/models/product.dart';
import 'package:fastfood/utils/constant.dart';
import 'package:fastfood/views/menu/menu_view.dart';
import 'package:fastfood/views/most_popular_view.dart';
import 'package:fastfood/views/nearyby_restro_view.dart';
import 'package:fastfood/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:provider/provider.dart';

import '../models/globalCart.dart';
import '../utils/CommonColors.dart';
import 'dis_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });
  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final Cart cart = Cart();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<HomeModel>(context).products;
    // ignore: unused_local_variable
    HomeModel homeModel = Provider.of<HomeModel>(context);
    Cart cartProvider = Provider.of<Cart>(context);
    CartController cartController = Provider.of<CartController>(context);

    return FutureBuilder<List<Product>?>(
        future: ProductConnectDB.getAllProduct(),
        builder: (context, AsyncSnapshot<List<Product>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Scaffold(
                key: _scaffoldKey,
                drawer: Drawer(
                  child: MenuView(),
                ),
                body: ListView(
                  children: [
                    Container(
                      height: 60.0,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(LocalImages.logo),
                          InkWell(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: CircleAvatar(
                              radius: 40,
                              child: Image.asset(
                                LocalImages.avatar,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 3.0,
                                    )
                                  ]),
                              child: Row(
                                children: [
                                  Image.asset(
                                    LocalImages.ic_search,
                                    width: 30.0,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  const Text(
                                    AppConstants.search,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: CommonColors.primaryTextColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          InkWell(
                            child: Image.asset(
                              LocalImages.ic_filter,
                              height: 58.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      height: 140.0,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 320.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: CommonColors.primaryColor
                                      .withOpacity(0.7),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage(LocalImages.offer_overlay),
                                      repeat: ImageRepeat.noRepeat,
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('50% OFF',
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(' Deals trong ngày',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Image.asset(
                                    LocalImages.dish,
                                    height: 100.0,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Phổ biến',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.primaryTextColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MostPopularView()),
                              );
                            },
                            child: const Text('Xem thêm',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: CommonColors.primaryTextColor)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 260.0,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // var base64String =
                            //     snapshot.data![index].image.substring(26);
                            // Uint8List imageBytes = base64.decode(base64String);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DishDetailsView(
                                              product: snapshot.data![index],
                                            )));
                              },
                              child: Container(
                                width: 280.0,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 30.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: const AssetImage(
                                          LocalImages.offer_overlay,
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.white.withOpacity(0.75),
                                            BlendMode.screen)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(1.0, 1.0),
                                        blurRadius: 12.0,
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      products[index].image,
                                      height: 100.0,
                                    )

                                        // snapshot.data![index].image != null
                                        //     ? Image.memory(imageBytes)
                                        //     : Image.asset(
                                        //         products[index].image,
                                        //         height: 100.0,
                                        //       ),
                                        ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                          color: Colors.amber.shade100,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Text(snapshot.data![index].label,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.amber.shade800)),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].name,
                                                style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonColors
                                                        .primaryTextColor)),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      snapshot.data![index]
                                                          .duration,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: CommonColors
                                                              .primaryTextColor)),
                                                  const Icon(
                                                    Icons.circle,
                                                    size: 5,
                                                    color: Colors.grey,
                                                  ),
                                                  Image.asset(
                                                    LocalImages.ic_rating,
                                                    height: 15.0,
                                                  ),
                                                  Text(
                                                      snapshot
                                                          .data![index].rating,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: CommonColors
                                                              .primaryTextColor)),
                                                ]),
                                          ],
                                        ),
                                        snapshot.data![index].isAdded
                                            ? SizedBox(
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        cartProvider
                                                            .updateItemQuantity(
                                                                index,
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity -
                                                                    1);
                                                        if (snapshot
                                                                .data![index]
                                                                .quantity ==
                                                            0) {
                                                          snapshot.data![index]
                                                              .isAdded = false;
                                                          cartProvider
                                                              .removeItem(
                                                                  index);
                                                        }
                                                        setState(() {});
                                                      },
                                                      child: Image.asset(
                                                          LocalImages.ic_minus,
                                                          height: 20),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        snapshot.data![index]
                                                            .quantity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: CommonColors
                                                                .primaryTextColor),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        cartProvider
                                                            .updateItemQuantity(
                                                                index,
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity +
                                                                    1);
                                                        setState(() {});
                                                      },
                                                      child: Image.asset(
                                                          LocalImages.ic_plus,
                                                          height: 20),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  snapshot.data![index]
                                                      .isAdded = true;
                                                  snapshot.data![index]
                                                      .quantity = 1;
                                                  final id =
                                                      (Random().nextInt(100) +
                                                          50);
                                                  final CartModel model =
                                                      CartModel(
                                                          id: id,
                                                          productId:
                                                              snapshot
                                                                  .data![index]
                                                                  .id,
                                                          price: snapshot
                                                              .data![index]
                                                              .price,
                                                          userId: userLogin!.id,
                                                          quantity: 1);

                                                  await CartConnectDB.addCart(
                                                      model);
                                                  cartProvider.addItem(
                                                      snapshot.data![index]);
                                                  setState(() {});
                                                },
                                                child: Image.asset(
                                                    LocalImages.ic_add,
                                                    height: 23),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Các nhà hàng gần',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.primaryTextColor)),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NearbyView()),
                              );
                            },
                            child: const Text('Xem thêm',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: CommonColors.primaryTextColor)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 280.0,
                      child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 300.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 12.0,
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 140,
                                    width: 300,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              LocalImages.restro_banner,
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25.0),
                                            topLeft: Radius.circular(25.0))),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text('Food',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.green.shade800)),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      children: [
                                        const Text("The Coffee House",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: CommonColors
                                                    .primaryTextColor)),
                                        const SizedBox(
                                          width: 40.0,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                LocalImages.ic_rating,
                                                height: 20.0,
                                              ),
                                              const Text(' 4.5 ',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: CommonColors
                                                          .primaryTextColor)),
                                            ]),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          Text('2.4 Km ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: CommonColors
                                                      .primaryTextColor)),
                                        ]),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
          } else {
            return Scaffold(
              key: _scaffoldKey,
              drawer: Drawer(
                child: MenuView(),
              ),
              body: ListView(
                children: [
                  Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(LocalImages.logo),
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 40,
                            child: Image.asset(LocalImages.avatar),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                  )
                                ]),
                            child: Row(
                              children: [
                                Image.asset(
                                  LocalImages.ic_search,
                                  width: 30.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const Text(
                                  AppConstants.search,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: CommonColors.primaryTextColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          child: Image.asset(
                            LocalImages.ic_filter,
                            height: 58.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 140.0,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 320.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                color:
                                    CommonColors.primaryColor.withOpacity(0.7),
                                image: const DecorationImage(
                                    image:
                                        AssetImage(LocalImages.offer_overlay),
                                    repeat: ImageRepeat.noRepeat,
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('50% OFF',
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    Text(' Deals trong ngày',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white))
                                  ],
                                ),
                                Image.asset(
                                  LocalImages.dish,
                                  height: 100.0,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phổ biến',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: CommonColors.primaryTextColor)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MostPopularView()),
                            );
                          },
                          child: const Text('Xem thêm',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.primaryTextColor)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 260.0,
                    child: ListView.builder(
                        itemCount: products.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DishDetailsView(
                                            product: products[index],
                                          )));
                            },
                            child: Container(
                              width: 280.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: const AssetImage(
                                        LocalImages.offer_overlay,
                                      ),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.white.withOpacity(0.75),
                                          BlendMode.screen)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 12.0,
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Image.asset(
                                    products[index].image,
                                    height: 100.0,
                                  )

                                      // snapshot.data![index].image != null
                                      //     ? Image.memory(imageBytes)
                                      //     : Image.asset(
                                      //         products[index].image,
                                      //         height: 100.0,
                                      //       ),
                                      ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(products[index].label,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.amber.shade800)),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(products[index].name,
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: CommonColors
                                                      .primaryTextColor)),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(products[index].duration,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: CommonColors
                                                            .primaryTextColor)),
                                                const Icon(
                                                  Icons.circle,
                                                  size: 5,
                                                  color: Colors.grey,
                                                ),
                                                Image.asset(
                                                  LocalImages.ic_rating,
                                                  height: 15.0,
                                                ),
                                                Text(products[index].rating,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: CommonColors
                                                            .primaryTextColor)),
                                              ]),
                                        ],
                                      ),
                                      products[index].isAdded
                                          ? SizedBox(
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider
                                                          .updateItemQuantity(
                                                              index,
                                                              snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity -
                                                                  1);
                                                      if (snapshot.data![index]
                                                              .quantity ==
                                                          0) {
                                                        snapshot.data![index]
                                                            .isAdded = false;
                                                        cartProvider
                                                            .removeItem(index);
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: Image.asset(
                                                        LocalImages.ic_minus,
                                                        height: 20),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: CommonColors
                                                              .primaryTextColor),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider
                                                          .updateItemQuantity(
                                                              index,
                                                              products[index]
                                                                      .quantity +
                                                                  1);
                                                      setState(() {});
                                                    },
                                                    child: Image.asset(
                                                        LocalImages.ic_plus,
                                                        height: 20),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                products[index].isAdded = true;
                                                products[index].quantity = 1;
                                                cartProvider
                                                    .addItem(products[index]);
                                                setState(() {});
                                              },
                                              child: Image.asset(
                                                  LocalImages.ic_add,
                                                  height: 23),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Các nhà hàng gần',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: CommonColors.primaryTextColor)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NearbyView()),
                            );
                          },
                          child: const Text('Xem thêm',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: CommonColors.primaryTextColor)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280.0,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 300.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 12.0,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            LocalImages.restro_banner,
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25.0),
                                          topLeft: Radius.circular(25.0))),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text('Food',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.green.shade800)),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      const Text("The Coffee House",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                      const SizedBox(
                                        width: 40.0,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              LocalImages.ic_rating,
                                              height: 20.0,
                                            ),
                                            const Text(' 4.5 ',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: CommonColors
                                                        .primaryTextColor)),
                                          ]),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        Text('2.4 Km ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: CommonColors
                                                    .primaryTextColor)),
                                      ]),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
