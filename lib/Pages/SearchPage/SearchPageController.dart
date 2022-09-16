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
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/ProductView/ProductView.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:woocommerce/woocommerce.dart';

class SearchPageController extends GetxController {
  var isLoading = false.obs;

  MyStrings myStrings = new MyStrings();

  var categoryList = <Device>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  doTheSearch(String key) async {

    categoryList.clear();
    isLoading(true);
    try {
      var temp = <Device>[];
      temp = await BackendServices.doTheSearch(key);
      categoryList.value = temp;
    }catch(e){
      isLoading(false);
    }finally{
      isLoading(false);
    }
  }

}
