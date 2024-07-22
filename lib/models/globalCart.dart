import 'package:fastfood/models/product.dart';
import 'package:flutter/cupertino.dart';


class Cart extends ChangeNotifier{
  List<Product> _cartList = [];
  List<Product> get cartList => _cartList;


  void addItem(Product item){
    if(!cartList.contains(item)){
      _cartList.insert(0, item);
    }
    notifyListeners();
  }


  void removeItem(int position){
    _cartList.removeAt(position);
    notifyListeners();
  }

  void updateItemQuantity(int index, int newQuantity) {
    cartList[index].quantity = newQuantity;
    notifyListeners();
  }

}