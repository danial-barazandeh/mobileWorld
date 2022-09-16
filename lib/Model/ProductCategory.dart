// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

ProductCategory productCategoryFromJson(String str) => ProductCategory.fromJson(json.decode(str));

String productCategoryToJson(ProductCategory data) => json.encode(data.toJson());

class ProductCategory {
  ProductCategory({
    required this.id,
    this.name,
  });

  int id;
  dynamic name;

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
      id: json["id"],
      name: json["name"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
