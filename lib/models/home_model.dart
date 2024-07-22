import 'package:fastfood/models/product.dart';
import 'package:fastfood/utils/local_images.dart';
import 'package:flutter/cupertino.dart';

class HomeModel with ChangeNotifier{
  List<Product> _products = [];
  List<Product> get products => _products;
  HomeModel(){
    _products = [
      Product(id: 1, title: '', address: '', name: 'Swe Dish',label: 'Healthy', price: 100000.00,image: LocalImages.dish, description: '', rating: '3.4',duration: '34 min'),
      Product(id: 2, title: '', address: '', name: 'Burger', label: 'Phổ biến',price: 150000.00,image: LocalImages.burger, description: '', rating: '4.4',duration: '24 min'),
      Product(id: 3, title: '', address: '', name: 'Swe Dish', label: 'Healthy',price: 200000.0,image: LocalImages.dish, description: '', rating: '2.4',duration: '30 min'),
      Product(id: 4, title: '', address: '', name: 'Burger', label: 'Phổ biến',price: 100000.00,image: LocalImages.burger, description: '', rating: '5.0',duration: '42 min'),
      Product(id: 5, title: '', address: '', name: 'Swe Dish',label: 'Healthy', price: 150000.00,image: LocalImages.dish, description: '', rating: '3.2',duration: '19 min'),
      Product(id: 6, title: '', address: '', name: 'Burger',label: 'Phổ biến', price: 200000.00,image: LocalImages.burger, description: '', rating: '3.5',duration: '26 min'),
    ];
  }
  void addToCart(Product product) {
    int index = _products.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _products[index].quantity++;
    } else {
      _products.add(Product(id: product.id, title: product.title, address: product.address, name: product.name, price: product.price, quantity: 1, label: product.label, image: product.image, description: product.description, rating: product.rating, duration: product.duration));
    }
    notifyListeners();
  }
  void removeFromCart(Product product) {
    int index = _products.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (_products[index].quantity > 0) {
        _products[index].quantity--;
      }
      // else {
      //   products.removeAt(index);
      // }
      notifyListeners();
    }
  }

  double get totalPrice {
    return _products.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
  int get totalQuantity {
    return _products.fold(0, (sum, item) => item.quantity);
  }

}