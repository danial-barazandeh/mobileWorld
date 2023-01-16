import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jmob/Model/Acf.dart';
import 'package:jmob/Model/Device.dart';
import 'package:jmob/Model/Product.dart';
import 'package:jmob/Model/User.dart';
import 'package:jmob/Model/Vendor.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:dio/dio.dart';

import '../Model/Brand.dart';
import '../Model/Order.dart';
import '../Model/Post.dart';
import '../Model/ProductCategory.dart';
import 'MyColors.dart';
import 'MyStrings.dart';

class BackendServices {
  static var domainBase = "http://brzdev.ir";
  static var myStrings = Get.find<MyStrings>();
  static var myColors = Get.find<MyColors>();
  static var client = http.Client();
  static var token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvam1vYi5pciIsImlhdCI6MTYzNzU4OTk3NywibmJmIjoxNjM3NTg5OTc3LCJleHAiOjE2MzgxOTQ3NzcsImRhdGEiOnsidXNlciI6eyJpZCI6IjIifX19.Mgzp-BURjcT94fDGiJC9XnwzyWmaxnK7t2Zffw8_QbU";


  static Future<List<dynamic>> getBrands() async {
    var response = await client.get(Uri.parse('$domainBase/api/brands'));


    print("brandsssssssssssssssssss");
    print(response.body);
    print("brandsssssssssssssssssss");

    var brandList = <Brand>[];
    var productCategoryList = <ProductCategory>[];
    var postList = <Post>[];

    try {
      var json = jsonDecode(response.body.toString());

      var jsonArray = jsonDecode(response.body.toString());

      try {
        for (var jsonObject in jsonArray["brands"]) {
          Brand brand = Brand.fromJson(jsonObject);
          brandList.add(brand);
        }
      } catch (e) {
        print("55555555555");
        print(e.toString());
        print("55555555555");
      }

      try {
        for (var jsonObject in jsonArray["product_categories"]) {
          ProductCategory productCategory = ProductCategory.fromJson(jsonObject);
          productCategoryList.add(productCategory);
        }
      } catch (e) {
        print("55555555555");
        print(e.toString());
        print("55555555555");
      }


      try {
        for (var jsonObject in jsonArray["posts"]) {
          Post post = Post.fromJson(jsonObject);
          postList.add(post);
        }
      } catch (e) {
        print("55555555555");
        print(e.toString());
        print("55555555555");
      }



      var temp = <dynamic>[];
      temp.add(brandList);
      temp.add(productCategoryList);
      temp.add(postList);

      return temp;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }


  static Future<JmobUser?> onClickRegisterOrLogin(String countryCode, String phoneNumber, String fToken) async {
    Map<String, String> body = {
      'country_code': countryCode.replaceFirst("+", ""),
      'mobile_number': phoneNumber,
      'firebase_token': fToken,
    };

    print("ZzzzzzzzzzZ");
    print(countryCode.replaceFirst("+", ""));
    print(phoneNumber);
    print("ZzzzzzzzzzZ");

    var response = await client.post(Uri.parse("$domainBase/api/onClickRegisterOrLogin"), body: body);



    print("******************");
    print(response.body.toString());
    print("******************");

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      try {
        JmobUser user = new JmobUser.fromJson(jsonData["user"]);
        return user;
      } catch (e) {
        Get.snackbar(
          myStrings.error,
          myStrings.errorOccurred,
          icon: Icon(Icons.lock, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: myColors.coll,
        );
        return null;
      }
    } else {
      Get.snackbar(
        myStrings.error,
        myStrings.errorInCommunication,
        icon: Icon(Icons.lock, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: myColors.coll,
      );
      return null;
    }
  }

  static Future<JmobUser?> getUserInfo(String token) async {
    var response = await client.get(
      Uri.parse("$domainBase/api/getUserInfo"),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
    );

    print("*****************");
    print(response.body.toString());
    print("*****************");

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      try {
        JmobUser user = new JmobUser.fromJson(jsonData);
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<JmobUser?> updateUser(JmobUser user) async {
    var token = user.token;
    var response = await client.post(
      Uri.parse('$domainBase/api/updateUser'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'name': user.name,
        'family_name': user.familyName,
        'phone': user.phone,
        'country': user.country,
        'address': user.address,
        'city': user.city,
      }),
    );

    print("*****************");
    print(response.body.toString());
    print("*****************");

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData["success"].toString() == "1") {
        JmobUser user = new JmobUser.fromJson(jsonData["user"]);
        return user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<List<Device>> getDeviceList(Brand brand) async {
    var response = await client.post(
      Uri.parse('$domainBase/api/devices'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'brand_id': brand.id,
      }),
    );

    var deviceList = <Device>[];
    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var jsonObject in jsonData) {
        Device device = new Device.fromJson(jsonObject);
        deviceList.add(device);
      }
      return deviceList;
    } else {
      return deviceList;
    }
  }

  static Future <List<Product>> getProducts(Device device) async {
    var response = await client.post(
      Uri.parse('$domainBase/api/products'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'device_id': device.id,
      }),
    );

    print("Products");
    print(response.body);
    print("Products");

    var productList = <Product>[];

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      for(var json in jsonArray){
        productList.add(Product.fromJson(json));
      }
      return productList;
    } else {
      return productList;
    }
  }

  static Future<List<Device>> doTheSearch(String key) async {
    var deviceList = <Device>[];

    var response = await client.post(
      Uri.parse('$domainBase/api/search'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'key': key,
      }),
    );

    print("are we ok ?");
    print(response.body.toString());
    print("are we ok ?");


    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      for(var json in jsonArray){
        deviceList.add(Device.fromJson(json));
      }
      return deviceList;
    } else {
      return deviceList;
    }

  }

  static Future<List<Order>> addOrder(Product product) async {
    print("selam");
    var orderList = <Order>[];

    await GetStorage.init("userStorage");
    var storage = GetStorage("userStorage");
    var data = await storage.read('user') ?? "empty";
    JmobUser user = JmobUser.fromJson(data);



    var token = user.token;
    print(token);
    var response = await client.post(
      Uri.parse('$domainBase/api/addOrder'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
      body: jsonEncode(<String, dynamic>{
        'product_id': product.id,
      }),
    );

    print("are we ok ?");
    print(response.body.toString());
    print("are we ok ?");


    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      for(var json in jsonArray['orders']){
        orderList.add(Order.fromJson(json));
      }
      return orderList;
    } else {
      return orderList;
    }

  }



  static Future<List<Order>> getOrders() async {
    var orderList = <Order>[];

    print("token");

    await GetStorage.init("userStorage");
    var storage = GetStorage("userStorage");
    var data = await storage.read('user') ?? "empty";
    JmobUser user = JmobUser.fromJson(data);

    var token = user.token;

    print(token);

    var response = await client.get(
      Uri.parse('$domainBase/api/getOrders'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
    );

    print("are we ok ?");
    print(response.body.toString());
    print("are we ok ?");


    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      for(var json in jsonObject['orders']){
        orderList.add(Order.fromJson(json));
      }
      return orderList;
    } else {
      return orderList;
    }
  }



  static Future<List<Order>> deleteOrder(Order order) async {
    var orderList = <Order>[];

    await GetStorage.init("userStorage");
    var storage = GetStorage("userStorage");
    var data = await storage.read('user') ?? "empty";
    JmobUser user = JmobUser.fromJson(data);

    var token = user.token;
    var response = await client.post(
      Uri.parse('$domainBase/api/deleteOrder'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
      body: jsonEncode(<String, dynamic>{
        'order_id': order.id,
      }),
    );

    print("are we ok ?");
    print(response.body.toString());
    print("are we ok ?");


    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      for(var json in jsonArray['orders']){
        orderList.add(Order.fromJson(json));
      }
      return orderList;
    } else {
      return orderList;
    }
  }

  static Future<List<String>> fetchSliders() async {
    var imgList = <String>[];
    var response = await client.get(
      Uri.parse('$domainBase/api/sliders'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonArray = jsonDecode(response.body);
      for(var json in jsonArray){
        imgList.add(json["image"]);
      }
    }
    return imgList;
  }

}
