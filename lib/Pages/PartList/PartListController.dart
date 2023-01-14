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
import 'package:jmob/Model/Product.dart';
import 'package:jmob/Model/ProductCategory.dart';
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Pages/ProductView/ProductView.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:jmob/Widget/ProductWidget.dart';
import 'package:woocommerce/woocommerce.dart';
import "package:collection/collection.dart";

class PartListController extends GetxController{
  var isLoading = false.obs;
  var selectedDevice = Device(id: 0).obs;
  var selectedProductCategory = ProductCategory(id: 0).obs;

  MyStrings myStrings = new MyStrings();

  var productCategoryList = <ProductCategory>[].obs;
  var productList = <Product>[].obs;
  var allProductList = <Product>[].obs;
  var groupBy = <Product>[].obs;
  var isEmpty = false.obs;
  var activatedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  selectTab(int index){
    activatedTab.value = index;

    var tempList = allProductList.where((element) => element.productCategoryId.toString() == productCategoryList[index].id.toString()).toList();
    productList.value = tempList;

    productGroupBy(index);
  }

  // getLengthOfAll(){
  //   var counter = 0;
  //   productList.value.forEach((element) {
  //     counter++;
  //   });
  //   return counter;
  // }
  
  
  productGroupBy(int index){

    var tempList  =  allProductList.where((p0) => p0.productCategoryId.toString() == productCategoryList[index].id.toString()).toList();
    var tempList2 = tempList.groupListsBy((element) => element.vendor.id);
    return tempList2;
  }
  
  getProducts(Device device) async {
    allProductList.value = await BackendServices.getProducts(device);
    productList.value = allProductList.value;
    selectTab(0);
  }


}
