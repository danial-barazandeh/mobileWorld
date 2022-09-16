// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    required this.id,
    this.name,
    this.image,
    this.models
  });

  int id;
  dynamic name;
  dynamic image;
  dynamic models;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"],
    name: json["name"].toString(),
    image: json["image"].toString(),
    models: json["models"].toString()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "models": models
  };
}
