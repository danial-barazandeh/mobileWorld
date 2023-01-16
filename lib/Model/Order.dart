import 'dart:convert';

import 'Product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    this.userId,
    this.status,
    this.type,
    required this.product,

  });

  int id;
  dynamic userId;
  dynamic status;
  dynamic type;
  Product product;

  factory Order.fromJson(Map<String, dynamic> json) {

    Product temp = Product.fromJson(json['product']);

  return Order(
      id: json["id"],
      userId: json["user_id"].toString(),
      status: json["status"].toString(),
      type: json["type"].toString(),
      product: temp
  );

  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "status": status,
    "type": type,
    "product": product
  };
}
