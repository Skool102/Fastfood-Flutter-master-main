import 'package:fastfood/connect/cart/cart_connect.dart';
import 'package:fastfood/models/cart/cart_model.dart';
import 'package:fastfood/models/product.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  List<Product> _cartList = [];
  List<Product> get cartList => _cartList;

  void removeItem(CartModel cart) async {
    await CartConnectDB.deleteCart(cart);
    notifyListeners();
  }

  void updateItemQuantity(
      List<CartModel> cartModel, int index, int newQuantity, bool view) {
    cartModel[index].quantity = view == true
        ? cartModel[index].quantity! + 1
        : cartModel[index].quantity! - 1;
    if (cartModel[index].quantity! > 0) {
      CartConnectDB.updateCart(cartModel[index]);
    } else if (cartModel[index].quantity! == 0) {
      CartConnectDB.deleteCart(cartModel[index]);
    }
    notifyListeners();
  }
}
