// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

class Brand {
  Brand({
    required this.id,
    this.name,
    this.image,
  });

  int id;
  dynamic name;
  dynamic image;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
      id: json["id"],
      name: json["name"].toString(),
      image: json["image"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
