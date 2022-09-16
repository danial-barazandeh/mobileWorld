import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jmob/Model/Brand.dart';
import 'package:jmob/Model/Post.dart';
import 'package:jmob/Pages/PartList/PartListController.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelView.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewController.dart';
import 'package:jmob/Pages/PhoneModelView/PhoneModelViewBinding.dart';
import 'package:jmob/Pages/ProductView/ProductController.dart';
import 'package:jmob/Services/BackendServices.dart';
import 'package:jmob/Services/MyStrings.dart';
import 'package:woocommerce/woocommerce.dart';

class HomeController extends GetxController {
  var userString = "Initial State".obs;
  var brandList = <Brand>[].obs;
  var postList = <Post>[].obs;
  var isLoading = false.obs;

  PhoneModelViewController phoneModelViewController = Get.find<PhoneModelViewController>();

  @override
  void onInit(){
    getBrands();
    super.onInit();
  }

  Future getBrands() async {
    isLoading(true);
    try {
      print("getWooProductCategory is called");


      var tempList = <dynamic>[];
      tempList = await BackendServices.getBrands();
      brandList.value = tempList[0];
      userString.value = brandList.length.toString();

      try{
        PartListController partListController = Get.find<PartListController>();
        partListController.productCategoryList.value = tempList[1];

      }catch(e){
        Get.put(ProductController);
        PartListController partListController = Get.find<PartListController>();
        partListController.productCategoryList.value = tempList[1];
      }

      postList.value = tempList[2];

    }catch(e){
      isLoading(false);
    }finally{
      isLoading(false);
    }
  }

  selectBrand(Brand brand){
    phoneModelViewController.selectedBrand(brand);
    print(brand.name);
    phoneModelViewController.getDevices(brand);
    Get.to(() => PhoneModelView(), binding: PhoneModelViewBinding());
  }





}