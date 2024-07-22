import 'package:fastfood/models/product.dart';

class CartModel {
  int? id;
  int? productId;
  double? price;
  int? quantity;
  Product? productData;
  int? userId;
  bool isCheck;

  CartModel({
    this.id,
    this.productId,
    this.productData,
    this.price,
    this.quantity,
    this.userId,
    this.isCheck = false
  });

  factory CartModel.fromJson(Map<String, dynamic> data) => CartModel(
        id: data['id'],
        productId: data['productId'],
        price: double.parse(data['price'].toString()),
        quantity: data['quantity'],
        userId: data['userId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'price': price,
        'quantity': quantity,
        'userId': userId
      };
}
