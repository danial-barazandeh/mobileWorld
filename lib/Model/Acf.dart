// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Acf acfFromJson(String str) => Acf.fromJson(json.decode(str));

String acfToJson(Acf data) => json.encode(data.toJson());

class Acf {
  Acf({
    required this.phone,
  });

  String phone;

  factory Acf.fromJson(Map<String, dynamic> json) => Acf(
    phone: json["phone"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
