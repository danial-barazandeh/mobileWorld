// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:jmob/Model/User.dart';
import 'package:jmob/Model/Vendor.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    this.name,
    this.image,
    this.content,
    this.price,
    this.salePrice,
    this.brand,
    this.productCategoryId,
    this.ownerId,
    this.user,
    this.vendor,
  });

  int id;
  dynamic name;
  dynamic image;
  dynamic content;
  dynamic price;
  dynamic salePrice;
  dynamic brand;
  dynamic productCategoryId;
  dynamic ownerId;
  dynamic user;
  dynamic vendor;


  factory Product.fromJson(Map<String, dynamic> json){


    var userTemp;
    try{
      userTemp = new JmobUser.fromJson(json["user"]).name;
    }catch(e){
      userTemp = "";
    }

    var vendorTemp;
    try{
      vendorTemp = new Vendor.fromJson(json["vendor"]);
    }catch(e){
      vendorTemp = "";
    }


    return Product(
        id: json["id"],
        name: json["name"].toString(),
        image: json["image"].toString(),
        content: json["content"].toString(),
        price: json["price"].toString(),
        salePrice: json["sale_price"].toString(),
        brand: json["brand"].toString(),
        ownerId: json["owner_id"].toString(),
        productCategoryId: json["product_category_id"].toString(),
        user: userTemp,
        vendor: vendorTemp,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "content": content,
    "price": price,
    "sale_price": salePrice,
    "productCategoryId": productCategoryId,
    "ownerId": ownerId,
    "user": user,
    "vendor": vendor,
  };
}
