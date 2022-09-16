import 'dart:convert';

import 'Product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    this.buyerId,
    this.status,
    this.type,
    required this.product,

  });

  int id;
  dynamic buyerId;
  dynamic status;
  dynamic type;
  Product product;

  factory Order.fromJson(Map<String, dynamic> json) {

    Product temp = Product.fromJson(json['product']);

  return Order(
      id: json["id"],
      buyerId: json["buyer_id"].toString(),
      status: json["status"].toString(),
      type: json["type"].toString(),
      product: temp
  );

  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "status": status,
    "type": type,
    "product": product
  };
}
