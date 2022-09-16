// To parse this JSON data, do
//
//     final vendor = vendorFromJson(jsonString);

import 'dart:convert';

Vendor vendorFromJson(String str) => Vendor.fromJson(json.decode(str));

String vendorToJson(Vendor data) => json.encode(data.toJson());

class Vendor {
  Vendor({
    required this.id,
    required this.storeName,
    required this.firstName,
    required this.lastName,
    required this.social,
    required this.phone,
    required this.showEmail,
    required this.address,
    required this.location,
    required this.banner,
    required this.bannerId,
    required this.gravatar,
    required this.gravatarId,
    required this.shopUrl,
    required this.productsPerPage,
    required this.showMoreProductTab,
    required this.tocEnabled,
    required this.storeToc,
    required this.featured,
    required this.rating,
    required this.enabled,
    required this.registered,
    required this.payment,
    required this.trusted,
    required this.storeOpenClose,
    required this.links,
  });

  int id;
  String storeName;
  String firstName;
  String lastName;
  Social social;
  String phone;
  bool showEmail;
  Address address;
  String location;
  String banner;
  int bannerId;
  String gravatar;
  int gravatarId;
  String shopUrl;
  int productsPerPage;
  bool showMoreProductTab;
  bool tocEnabled;
  String storeToc;
  bool featured;
  Rating rating;
  bool enabled;
  DateTime registered;
  String payment;
  bool trusted;
  StoreOpenClose storeOpenClose;
  Links links;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    storeName: json["store_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    social: Social.fromJson(json["social"]),
    phone: json["phone"],
    showEmail: json["show_email"],
    address: Address.fromJson(json["address"]),
    location: json["location"],
    banner: json["banner"],
    bannerId: json["banner_id"],
    gravatar: json["gravatar"],
    gravatarId: json["gravatar_id"],
    shopUrl: json["shop_url"],
    productsPerPage: json["products_per_page"],
    showMoreProductTab: json["show_more_product_tab"],
    tocEnabled: json["toc_enabled"],
    storeToc: json["store_toc"],
    featured: json["featured"],
    rating: Rating.fromJson(json["rating"]),
    enabled: json["enabled"],
    registered: DateTime.parse(json["registered"]),
    payment: json["payment"],
    trusted: json["trusted"],
    storeOpenClose: StoreOpenClose.fromJson(json["store_open_close"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_name": storeName,
    "first_name": firstName,
    "last_name": lastName,
    "social": social.toJson(),
    "phone": phone,
    "show_email": showEmail,
    "address": address.toJson(),
    "location": location,
    "banner": banner,
    "banner_id": bannerId,
    "gravatar": gravatar,
    "gravatar_id": gravatarId,
    "shop_url": shopUrl,
    "products_per_page": productsPerPage,
    "show_more_product_tab": showMoreProductTab,
    "toc_enabled": tocEnabled,
    "store_toc": storeToc,
    "featured": featured,
    "rating": rating.toJson(),
    "enabled": enabled,
    "registered": registered.toIso8601String(),
    "payment": payment,
    "trusted": trusted,
    "store_open_close": storeOpenClose.toJson(),
    "_links": links.toJson(),
  };
}

class Address {
  Address({
    required this.street1,
    required this.street2,
    required this.city,
    required this.zip,
    required this.country,
    required this.state,
  });

  String street1;
  String street2;
  String city;
  String zip;
  String country;
  String state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street1: json["street_1"],
    street2: json["street_2"],
    city: json["city"],
    zip: json["zip"],
    country: json["country"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "street_1": street1,
    "street_2": street2,
    "city": city,
    "zip": zip,
    "country": country,
    "state": state,
  };
}

class Links {
  Links({
    required this.self,
    required this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    required this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Rating {
  Rating({
    required this.rating,
    required this.count,
  });

  String rating;
  int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rating: json["rating"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "count": count,
  };
}

class Social {
  Social({
    required this.fb,
    required this.twitter,
    required this.pinterest,
    required this.linkedin,
    required this.youtube,
    required  this.instagram,
    required this.flickr,
  });

  String fb;
  String twitter;
  String pinterest;
  String linkedin;
  String youtube;
  String instagram;
  String flickr;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    fb: json["fb"],
    twitter: json["twitter"],
    pinterest: json["pinterest"],
    linkedin: json["linkedin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    flickr: json["flickr"],
  );

  Map<String, dynamic> toJson() => {
    "fb": fb,
    "twitter": twitter,
    "pinterest": pinterest,
    "linkedin": linkedin,
    "youtube": youtube,
    "instagram": instagram,
    "flickr": flickr,
  };
}

class StoreOpenClose {
  StoreOpenClose({
    required this.enabled,
    required this.time,
    required this.openNotice,
    required this.closeNotice,
  });

  bool enabled;
  List<dynamic> time;
  String openNotice;
  String closeNotice;

  factory StoreOpenClose.fromJson(Map<String, dynamic> json) => StoreOpenClose(
    enabled: json["enabled"],
    time: List<dynamic>.from(json["time"].map((x) => x)),
    openNotice: json["open_notice"],
    closeNotice: json["close_notice"],
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled,
    "time": List<dynamic>.from(time.map((x) => x)),
    "open_notice": openNotice,
    "close_notice": closeNotice,
  };
}
