import 'dart:async';
import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/Device.dart';
import 'package:jmob/Model/Order.dart';
import 'package:jmob/Model/Product.dart';
import 'package:jmob/Model/ProductCategory.dart';
import 'package:jmob/Pages/Home/Home.dart';
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/ProductView/ProductView.dart';
import 'package:jmob/Pages/SignUpForm/SignUpForm.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:woocommerce/woocommerce.dart';
import "package:collection/collection.dart";

import '../../Services/MyColors.dart';

class OrdersViewController extends GetxController{

  MyStrings myStrings = new MyStrings();

  var ordersList = <Order>[].obs;

  var isLoaded = false.obs;


  MyColors myColors = new MyColors();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchOrder() async {

    var storage = GetStorage("userStorage");
    var data =  await storage.read('user') ?? "empty";

    if(data.toString() == "empty") {
      Get.to(Home());
      Get.snackbar(
        myStrings.error,
        myStrings.registerForOrders,
        icon: Icon(Icons.lock, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: myColors.coll.withAlpha(200),
      );

    }else {
      var temp = <Order>[];
      temp = await BackendServices.getOrders();
      ordersList.value = temp;
      isLoaded(true);
    }

  }




  Future<void> deleteOrder(Order order) async {
      var temp = <Order>[];
      temp = await BackendServices.deleteOrder(order);
      ordersList.value = temp;

  }


}
