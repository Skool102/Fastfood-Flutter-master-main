import 'dart:convert';
import 'dart:math';

import 'package:fastfood/connect/cart/cart_connect.dart';
import 'package:fastfood/connect/cart/cart_controller.dart';
import 'package:fastfood/main.dart';
import 'package:fastfood/models/cart/cart_model.dart';
import 'package:fastfood/models/pays/pay_model.dart';
import 'package:fastfood/utils/CommonColors.dart';
import 'package:fastfood/utils/constant.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:fastfood/views/address_view.dart';
import 'package:fastfood/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class BottomCartView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomCartView();
}

class _BottomCartView extends State<BottomCartView> {
  var isCheck = false;
  int subtotal = 0;
  int deliveryCharge = 30;
  double gst = 0;
  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    return userLogin != null
        ? Scaffold(
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
                    const Text(AppConstants.cart,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                child: FutureBuilder<List<CartModel>?>(
                  future: CartConnectDB.getAllCart(),
                  builder: (context, AsyncSnapshot<List<CartModel>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return Consumer<CartController>(
                            builder: (context, carts, _) {
                          double calculateTotal() {
                            double subtotal = 0;
                            for (var item in snapshot.data!) {
                              String priceString = (item.price).toString();
                              String qtyString = (item.quantity).toString();
                              double price = double.tryParse(priceString) ?? 0;
                              double qty = double.tryParse(qtyString) ?? 0;
                              subtotal += price * qty;
                            }
                            deliveryCharge = 30000;
                            double grandTotal = subtotal + deliveryCharge;
                            return grandTotal;
                          }

                          double subTotal() {
                            double subtotal = 0;
                            for (var item in snapshot.data!) {
                              String priceString = (item.price).toString();
                              String qtyString = (item.quantity).toString();
                              double price = double.tryParse(priceString) ?? 0;
                              double qty = double.tryParse(qtyString) ?? 0;
                              subtotal += price * qty;
                            }
                            return subtotal;
                          }

                          return Column(
                            children: [
                              Expanded(
                                  child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) => Container(
                                  height: 140.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
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
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                LocalImages.dish,
                                                width: 80.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                      snapshot.data![index]
                                                          .productData!.title,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: CommonColors
                                                              .primaryTextColor)),
                                                  Text(
                                                      snapshot.data![index]
                                                          .productData!.name,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: CommonColors
                                                              .primaryTextColor)),
                                                  Text(
                                                      '${snapshot.data![index].quantity} X ${snapshot.data![index].price} VND',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: CommonColors
                                                              .primaryTextColor)),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                        color: CommonColors
                                                            .primaryTextColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            carts.updateItemQuantity(
                                                                snapshot.data!,
                                                                index,
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity! +
                                                                    1,
                                                                true);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          snapshot.data![index]
                                                              .quantity
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            carts.updateItemQuantity(
                                                                snapshot.data!,
                                                                index,
                                                                snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity! -
                                                                    1,
                                                                false);
                                                            if (snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity ==
                                                                0) {
                                                              snapshot
                                                                  .data![index]
                                                                  .productData!
                                                                  .isAdded = false;
                                                              carts.removeItem(
                                                                  snapshot.data![
                                                                      index]);
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                  '${snapshot.data![index].price! * snapshot.data![index].quantity!} VND',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CommonColors
                                                          .primaryTextColor)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: const Divider()),
                              Container(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          'SubTotal: ${subTotal().toString()} VNĐ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700)),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      const Text('Phí giao hàng: 30000 VND',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      Text('Tax(VNĐ): $gst VNĐ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.6),
                                          child: const Divider()),
                                      Text(
                                          'Tổng tiền: ${calculateTotal().toString()} VNĐ',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: CommonColors
                                                  .primaryTextColor)),
                                    ],
                                  )),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    final id = (Random().nextInt(100) + 50);
                                    List<String> listId = [];
                                    snapshot.data!.forEach((r) {
                                      listId.add(r.productData!.id.toString());
                                    });
                                    PayModel model = PayModel(
                                        id: id,
                                        status: '',
                                        address: '',
                                        listProductId: json.encode(listId),
                                        content: 'Đã nhận đơn',
                                        userId: userLogin!.id);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressView(
                                                pay: model,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Text('Kiểm tra',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                      }
                    } else {
                      const Center(
                        child: Text(
                          'Không có mặt hàng nào trong giỏ hàng. Vui lòng thêm một mục',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
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
