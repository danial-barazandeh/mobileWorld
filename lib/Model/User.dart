// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

JmobUser userFromJson(String str) => JmobUser.fromJson(json.decode(str));

String userToJson(JmobUser data) => json.encode(data.toJson());

class JmobUser {
  JmobUser({
    required this.id,
    this.name,
    this.familyName,
    this.country,
    this.city,
    this.email,
    this.address,
    required this.token,
    required this.phone,
  });

  String id;
  dynamic name;
  dynamic familyName;
  dynamic country;
  dynamic city;
  dynamic email;
  dynamic address;
  String token;
  String phone;

  factory JmobUser.fromJson(Map<String, dynamic> json) => JmobUser(
    id: json["id"].toString(),
    name: json["name"].toString(),
    familyName: json["family_name"].toString(),
    email: json["email"].toString(),
    token: json["token"].toString(),
    phone: json["phone"].toString(),
    country: json["country"].toString(),
    city: json["city"].toString(),
    address: json["address"].toString()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "family_name": familyName,
    "email": email,
    "token": token,
    "phone": phone,
    "country": country,
    "city": city,
    "address": address
  };
}
