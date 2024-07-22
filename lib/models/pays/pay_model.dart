import 'package:fastfood/models/product.dart';

class PayModel {
  int? id;
  String? status;
  String? address;
  String? listProductId;
  String? content;
  int? userId;
  List<Product>? listProduct;

  PayModel({
    this.id,
    this.status,
    this.address,
    this.listProductId,
    this.content,
    this.userId,
    this.listProduct
  });

  factory PayModel.fromJson(Map<String, dynamic> data) => PayModel(
        id: data['id'],
        status: data['status'],
        address: data['address'],
        listProductId: data['listProductId'],
        content: data['content']
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'status': status,
        'address': address,
        'listProductId': listProductId,
        'content': content
      };
}
