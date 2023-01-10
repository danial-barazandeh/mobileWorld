import 'dart:convert';

Vendor vendorFromJson(String str) => Vendor.fromJson(json.decode(str));

String vendorToJson(Vendor data) => json.encode(data.toJson());

class Vendor {
  Vendor({
    required this.id,
    this.name,
    this.country,
    this.city,
    this.address,
    this.email,
    this.phone,
    this.coordinate,
    this.image
  });

  String id;
  dynamic name;
  dynamic country;
  dynamic city;
  dynamic address;
  dynamic email;
  dynamic phone;
  dynamic coordinate;
  dynamic image;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
      id: json["id"].toString(),
      name: json["name"].toString(),
      country: json["country"].toString(),
      city: json["city"].toString(),
      address: json["address"].toString(),
      email: json["email"].toString(),
      phone: json["phone"].toString(),
      coordinate: json["coordinate"].toString(),
      image: json["image"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "city": city,
    "address": address,
    "email": email,
    "phone": phone,
    "coordinate": coordinate,
    "image": image,
  };
}
