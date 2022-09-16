import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/Brand.dart';
import 'package:jmob/Pages/PartList/PartList.dart';
import 'package:jmob/Pages/PartList/PartListController.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../Model/Device.dart';
import '../../Model/ProductCategory.dart';
import '../ProductView/ProductController.dart';

class PhoneModelViewController extends GetxController {
  var userString = "Initial State".obs;
  var deviceList = <Device>[].obs;
  // var childBrandList = <Device>[].obs;
  var isLoading = false.obs;

  var selectedBrand = Brand(id: 0).obs;

  var productCategoryList = <ProductCategory>[].obs;

  PartListController partListController = Get.find<PartListController>();

  @override
  void onInit(){
    super.onInit();
  }

  Future getDevices(Brand brand) async {
    isLoading(true);
    try {
      print("getDeviceList is called");
      deviceList.value = await BackendServices.getDeviceList(brand);
      userString.value = deviceList.length.toString();
      print("Tedad device ha:" +deviceList.length.toString());
    }catch(e){
      isLoading(false);
      print("9999999999999999");
      print(e.toString());
      print("9999999999999999");
    }finally{
      isLoading(false);
    }
  }


  selectDevice(Device device){

    try{
      PartListController partListController = Get.find<PartListController>();
      partListController.selectedDevice.value = device;
      partListController.getProducts(device);
    }catch(e){
      Get.put(ProductController);
      PartListController partListController = Get.find<PartListController>();
      partListController.selectedDevice.value = device;
      partListController.getProducts(device);
    }

    Get.to(() => PartList(),);
  }

}